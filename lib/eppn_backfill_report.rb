# frozen_string_literal: true

# Formatted console output for the eppn backfill rake task.
module EppnBackfillReport
  module_function

  def print_manual_checklist(manual_rows, io: $stdout)
    print_manual_checklist_header(manual_rows, io:)
    return if manual_rows.empty?

    print_manual_checklist_table(manual_rows, io:)
    print_manual_checklist_commands(manual_rows, io:)
    io.puts '=' * 80
    io.puts
  end

  def print_duplicate_accounts_list(duplicate_rows, io: $stdout)
    print_duplicate_accounts_header(duplicate_rows, io:)
    return if duplicate_rows.empty?

    print_duplicate_accounts_table(duplicate_rows, io:)
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

  def print_duplicate_accounts_header(duplicate_rows, io:)
    io.puts '=' * 80
    if duplicate_rows.empty?
      io.puts 'LIKELY DUPLICATE ACCOUNTS: none'
    else
      io.puts "LIKELY DUPLICATE ACCOUNTS (#{duplicate_rows.size} users)"
      io.puts 'These users would receive the same eppn as another account. No eppn was set.'
      io.puts 'No further action is expected unless Shibboleth login fails for the primary account.'
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

  def print_duplicate_accounts_table(duplicate_rows, io:)
    io.puts "#{'ID'.ljust(6)}  #{'EMAIL'.ljust(40)}  #{'PROPOSED EPPN'.ljust(26)}  HELD BY"
    io.puts "#{'-' * 6}  #{'-' * 40}  #{'-' * 26}  #{'-' * 40}"

    duplicate_rows.each do |row|
      io.puts format_duplicate_account_row(row)
    end
    io.puts
  end

  def format_duplicate_account_row(row)
    held_by = "#{row[:held_by_email]} (id #{row[:held_by_id]})"
    id = row[:id].to_s.ljust(6)
    email = row[:email].ljust(40)
    eppn = row[:eppn].ljust(26)
    "#{id}  #{email}  #{eppn}  #{held_by}"
  end

  def print_manual_checklist_commands(manual_rows, io:)
    io.puts 'Suggested commands (replace THE_EPPN@uc.edu with each user\'s real eppn):'
    manual_rows.each do |row|
      io.puts "  bundle exec rails runner 'User.find(#{row[:id]}).update!(eppn: \"THE_EPPN@uc.edu\")'"
    end
  end
end
