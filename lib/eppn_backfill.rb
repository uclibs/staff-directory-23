# frozen_string_literal: true

# Assigns Shibboleth eppn values from existing user emails before SSO cutover.
module EppnBackfill
  Result = Struct.new(
    :updated,
    :manual,
    :duplicates,
    :skipped,
    :errors,
    keyword_init: true
  )

  module_function

  def run(apply: false, eppn_domain: default_eppn_domain)
    result = Result.new(updated: [], manual: [], duplicates: [], skipped: [], errors: [])
    claimed_eppns = {}

    User.find_each do |user|
      process_user(user, apply:, eppn_domain:, result:, claimed_eppns:)
    end

    result
  end

  def proposed_eppn(email, eppn_domain: default_eppn_domain)
    local_part, domain = email.to_s.split('@', 2)
    return nil if local_part.blank? || domain.blank?

    return :manual if local_part.include?('.')

    ShibbolethLogin.normalize_eppn("#{local_part}@#{eppn_domain}")
  end

  def default_eppn_domain
    ENV.fetch('STADIR_EPPN_DOMAIN', 'uc.edu').strip.presence || 'uc.edu'
  end

  def process_user(user, apply:, eppn_domain:, result:, claimed_eppns:)
    return record_skipped(user, result) if user.eppn.present?

    proposal = proposed_eppn(user.email, eppn_domain:)
    return record_manual(user, result) if proposal == :manual
    return record_invalid_email(user, result) if proposal.nil?

    holder = duplicate_eppn_holder(user, proposal, claimed_eppns)
    return record_duplicate_eppn(user, proposal, holder, result) if holder

    apply_eppn(user, proposal, apply, result, claimed_eppns)
  rescue ActiveRecord::RecordInvalid => e
    record_validation_error(user, e, result)
  end

  def record_skipped(user, result)
    result.skipped << { email: user.email, eppn: user.eppn, reason: 'eppn already set' }
  end

  def record_manual(user, result)
    result.manual << {
      id: user.id,
      email: user.email,
      reason: 'local part of email contains a period'
    }
  end

  def record_invalid_email(user, result)
    result.errors << { email: user.email, message: 'email is missing or invalid' }
  end

  def record_duplicate_eppn(user, proposal, holder, result)
    result.duplicates << {
      id: user.id,
      email: user.email,
      eppn: proposal,
      held_by_id: holder[:id],
      held_by_email: holder[:email]
    }
  end

  def duplicate_eppn_holder(user, proposal, claimed_eppns)
    return claimed_eppns[proposal] if claimed_eppns.key?(proposal)

    existing_user = User.where.not(id: user.id).find_by(eppn: proposal)
    return nil if existing_user.nil?

    { id: existing_user.id, email: existing_user.email }
  end

  def apply_eppn(user, proposal, apply, result, claimed_eppns)
    user.update!(eppn: proposal) if apply
    claimed_eppns[proposal] = { id: user.id, email: user.email }
    result.updated << { email: user.email, eppn: proposal, applied: apply }
  end

  def record_validation_error(user, error, result)
    result.errors << { email: user.email, message: error.record.errors.full_messages.join(', ') }
  end
  private_class_method :process_user, :record_skipped, :record_manual, :record_invalid_email,
                       :record_duplicate_eppn, :duplicate_eppn_holder, :apply_eppn,
                       :record_validation_error
end
