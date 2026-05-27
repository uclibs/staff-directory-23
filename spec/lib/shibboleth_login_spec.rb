# frozen_string_literal: true

require 'rails_helper'
require Rails.root.join('lib/shibboleth_login')

RSpec.describe ShibbolethLogin do
  describe '.enabled?' do
    it 'is enabled only when STADIR_USE_SHIBBOLETH is true' do
      original = ENV.fetch('STADIR_USE_SHIBBOLETH', nil)
      ENV['STADIR_USE_SHIBBOLETH'] = 'true'
      expect(described_class.enabled?).to be(true)
    ensure
      ENV['STADIR_USE_SHIBBOLETH'] = original
    end

    it 'is disabled when STADIR_USE_SHIBBOLETH is not true' do
      original = ENV.fetch('STADIR_USE_SHIBBOLETH', nil)
      ENV.delete('STADIR_USE_SHIBBOLETH')
      expect(described_class.enabled?).to be(false)
    ensure
      ENV['STADIR_USE_SHIBBOLETH'] = original
    end
  end

  describe '.eppn_from' do
    it 'reads HTTP_EPPN from the request environment' do
      request = instance_double(ActionDispatch::Request, env: { 'HTTP_EPPN' => 'bearcat@uc.edu' })

      expect(described_class.eppn_from(request)).to eq('bearcat@uc.edu')
    end
  end
end
