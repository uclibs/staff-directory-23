# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#sort_arrow' do
    context 'when current_sort is nil and column is the default sort column' do
      it "returns the default sort arrow '↑'" do
        expect(helper.sort_arrow('lastname', nil, 'asc')).to include('↑')
      end
    end

    # Add other contexts and tests for different scenarios
  end
end
