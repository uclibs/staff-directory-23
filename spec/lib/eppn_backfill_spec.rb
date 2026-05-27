# frozen_string_literal: true

require 'rails_helper'
require Rails.root.join('lib/eppn_backfill')

RSpec.describe EppnBackfill do
  describe '.proposed_eppn' do
    it 'auto-generates eppn from the local part when there is no period' do
      expect(described_class.proposed_eppn('jsmith@uc.edu')).to eq('jsmith@uc.edu')
      expect(described_class.proposed_eppn('jsmith@ucmail.uc.edu', eppn_domain: 'uc.edu')).to eq('jsmith@uc.edu')
      expect(described_class.proposed_eppn('JSmith@uc.edu')).to eq('jsmith@uc.edu')
    end

    it 'requires manual assignment when the local part contains a period' do
      expect(described_class.proposed_eppn('dean.bachelder@uc.edu')).to eq(:manual)
    end

    it 'returns nil for invalid email' do
      expect(described_class.proposed_eppn('not-an-email')).to be_nil
    end
  end

  describe '.run' do
    it 'updates users without a period in the email local part when apply is true' do
      user = create(:user, email: 'jsmith@uc.edu', eppn: nil)

      result = described_class.run(apply: true)

      expect(user.reload.eppn).to eq('jsmith@uc.edu')
      expect(result.updated).to contain_exactly(
        hash_including(email: 'jsmith@uc.edu', eppn: 'jsmith@uc.edu', applied: true)
      )
    end

    it 'does not write changes in dry run mode' do
      user = create(:user, email: 'jsmith@uc.edu', eppn: nil)

      described_class.run(apply: false)

      expect(user.reload.eppn).to be_nil
    end

    it 'lists users with a period in the local part for manual assignment' do
      user = create(:user, email: 'dean.bachelder@uc.edu', eppn: nil)

      result = described_class.run(apply: true)

      expect(result.manual).to contain_exactly(
        hash_including(id: user.id, email: 'dean.bachelder@uc.edu')
      )
    end

    it 'prints a manual assignment checklist' do
      user = create(:user, email: 'dean.bachelder@uc.edu', eppn: nil)
      output = StringIO.new

      result = described_class.run(apply: false)
      described_class.print_manual_checklist(result.manual, io: output)

      expect(output.string).to include('MANUAL EPPN ASSIGNMENT REQUIRED (1 users)')
      expect(output.string).to include('dean.bachelder@uc.edu')
      expect(output.string).to include("User.find(#{user.id}).update!")
    end

    it 'skips users who already have an eppn' do
      create(:user, email: 'jsmith@uc.edu', eppn: 'jsmith@uc.edu')

      result = described_class.run(apply: true)

      expect(result.skipped).to contain_exactly(
        hash_including(email: 'jsmith@uc.edu', reason: 'eppn already set')
      )
    end
  end
end
