# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'eppn' do
    it 'normalizes eppn to lowercase before validation' do
      user = build(:user, eppn: '  Bearcat@UC.edu  ')

      user.valid?

      expect(user.eppn).to eq('bearcat@uc.edu')
    end

    it 'requires eppn to be unique' do
      create(:user, email: 'first@uc.edu', eppn: 'bearcat@uc.edu')

      duplicate = build(:user, email: 'second@uc.edu', eppn: 'bearcat@uc.edu')

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:eppn]).to include('has already been taken')
    end

    it 'allows blank eppn values' do
      user = build(:user, eppn: nil)

      expect(user).to be_valid
    end
  end
end
