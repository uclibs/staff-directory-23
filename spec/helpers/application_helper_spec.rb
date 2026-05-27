# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#user_login_path' do
    it 'returns the Shibboleth login path in production' do
      allow(ShibbolethLogin).to receive(:enabled?).and_return(true)

      expect(helper.user_login_path).to eq(helper.shibboleth_login_path)
    end

    it 'returns the Devise sign-in path outside production' do
      allow(ShibbolethLogin).to receive(:enabled?).and_return(false)

      expect(helper.user_login_path).to eq(helper.new_user_session_path)
    end
  end

  describe '#sort_arrow' do
    context 'when current_sort is nil and column is the default sort column' do
      it "returns the default sort arrow '↑'" do
        expect(helper.sort_arrow('lastname', nil, 'asc')).to include('↑')
      end
    end

    # Add other contexts and tests for different scenarios
  end
end
