# frozen_string_literal: true

require 'rails_helper'
require Rails.root.join('lib/shibboleth_login')

RSpec.describe ShibbolethLogin do
  describe '.enabled?' do
    it 'is enabled in production' do
      allow(Rails.env).to receive(:production?).and_return(true)

      expect(described_class.enabled?).to be(true)
    end

    it 'is disabled outside production' do
      allow(Rails.env).to receive(:production?).and_return(false)

      expect(described_class.enabled?).to be(false)
    end
  end

  describe '.eppn_from' do
    it 'reads HTTP_EPPN from the request environment' do
      request = instance_double(ActionDispatch::Request, env: { 'HTTP_EPPN' => 'bearcat@uc.edu' })

      expect(described_class.eppn_from(request)).to eq('bearcat@uc.edu')
    end
  end
end
