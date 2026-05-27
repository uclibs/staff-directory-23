# frozen_string_literal: true

namespace :users do
  desc <<~DESC
    Backfill users.eppn from users.email for Shibboleth cutover.
    Auto-assigns eppn when the email local part has no period (e.g. jsmith@uc.edu -> jsmith@uc.edu).
    Prints a checklist of users who need manual eppn assignment.
    Preview by default; set APPLY=1 to write auto-assignments.
    Optional: STADIR_EPPN_DOMAIN=uc.edu (default)
  DESC
  task backfill_eppn: :environment do
    require Rails.root.join('lib/eppn_backfill')
    require Rails.root.join('lib/eppn_backfill_report')

    apply = ENV['APPLY'] == '1'
    eppn_domain = EppnBackfill.default_eppn_domain
    result = EppnBackfill.run(apply:, eppn_domain:)

    puts apply ? 'Applying eppn backfill...' : 'Dry run (no changes written). Set APPLY=1 to update records.'
    puts "eppn domain suffix: #{eppn_domain}"
    puts

    if result.updated.any?
      puts "Auto-assigned (#{result.updated.size}):"
      result.updated.each do |row|
        state = row[:applied] ? 'updated' : 'would update'
        puts "  #{state}: #{row[:email]} -> #{row[:eppn]}"
      end
    else
      puts 'Auto-assigned: none'
    end
    puts

    if result.skipped.any?
      puts "Skipped (#{result.skipped.size}):"
      result.skipped.each do |row|
        puts "  #{row[:email]} (#{row[:reason]}: #{row[:eppn]})"
      end
      puts
    end

    if result.errors.any?
      puts "Errors (#{result.errors.size}):"
      result.errors.each do |row|
        puts "  #{row[:email]}: #{row[:message]}"
      end
      puts
    end

    EppnBackfillReport.print_duplicate_accounts_list(result.duplicates)
    EppnBackfillReport.print_manual_checklist(result.manual)

    exit 1 if result.errors.any?

    puts 'Done.'
  end
end
