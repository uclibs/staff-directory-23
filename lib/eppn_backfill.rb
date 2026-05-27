# frozen_string_literal: true

# Assigns Shibboleth eppn values from existing user emails before SSO cutover.
module EppnBackfill
  Result = Struct.new(
    :updated,
    :manual,
    :skipped,
    :errors,
    keyword_init: true
  )

  module_function

  def run(apply: false, eppn_domain: default_eppn_domain)
    result = Result.new(updated: [], manual: [], skipped: [], errors: [])

    User.find_each do |user|
      process_user(user, apply:, eppn_domain:, result:)
    end

    result
  end

  def print_manual_checklist(manual_rows, io: $stdout)
    print_manual_checklist_header(manual_rows, io:)
    return if manual_rows.empty?

    print_manual_checklist_table(manual_rows, io:)
    print_manual_checklist_commands(manual_rows, io:)
    io.puts '=' * 80
    io.puts
  end

  def print_manual_checklist_header(manual_rows, io:)
    io.puts '=' * 80
    if manual_rows.empty?
      io.puts 'MANUAL EPPN ASSIGNMENT REQUIRED: none'
    else
      io.puts "MANUAL EPPN ASSIGNMENT REQUIRED (#{manual_rows.size} users)"
      io.puts 'These emails contain a period before the @ sign. Set each eppn to the value'
      io.puts 'Shibboleth provides (for example: bearcat@uc.edu).'
    end
    io.puts '=' * 80
  end

  def print_manual_checklist_table(manual_rows, io:)
    io.puts "#{'ID'.ljust(6)}  #{'EMAIL'.ljust(40)}  ACTION"
    io.puts "#{'-' * 6}  #{'-' * 40}  #{'-' * 40}"

    manual_rows.each do |row|
      io.puts "#{row[:id].to_s.ljust(6)}  #{row[:email].ljust(40)}  assign eppn manually"
    end
    io.puts
  end

  def print_manual_checklist_commands(manual_rows, io:)
    io.puts 'Suggested commands (replace THE_EPPN@uc.edu with each user\'s real eppn):'
    manual_rows.each do |row|
      io.puts "  bundle exec rails runner 'User.find(#{row[:id]}).update!(eppn: \"THE_EPPN@uc.edu\")'"
    end
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

  def process_user(user, apply:, eppn_domain:, result:)
    return record_skipped(user, result) if user.eppn.present?

    proposal = proposed_eppn(user.email, eppn_domain:)
    return record_manual(user, result) if proposal == :manual
    return record_invalid_email(user, result) if proposal.nil?
    return record_duplicate_eppn(user, proposal, result) if duplicate_eppn?(user, proposal)

    apply_eppn(user, proposal, apply, result)
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

  def record_duplicate_eppn(user, proposal, result)
    result.errors << {
      email: user.email,
      message: "generated eppn #{proposal} is already assigned to another user"
    }
  end

  def duplicate_eppn?(user, proposal)
    User.where.not(id: user.id).exists?(eppn: proposal)
  end

  def apply_eppn(user, proposal, apply, result)
    user.update!(eppn: proposal) if apply
    result.updated << { email: user.email, eppn: proposal, applied: apply }
  end

  def record_validation_error(user, error, result)
    result.errors << { email: user.email, message: error.record.errors.full_messages.join(', ') }
  end
  private_class_method :process_user, :record_skipped, :record_manual, :record_invalid_email,
                       :record_duplicate_eppn, :duplicate_eppn?, :apply_eppn, :record_validation_error
end
