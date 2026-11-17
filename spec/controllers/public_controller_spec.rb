# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicController do
  before do
    # PublicController is not mounted in config/routes.rb. Use a separate route
    # set so drawing this action does not replace the application's routes.
    self.routes = ActionDispatch::Routing::RouteSet.new.tap do |route_set|
      route_set.draw { get 'public' => 'public#index' }
    end
    sign_in create(:user)
  end

  describe 'GET #index' do
    it 'assigns every employee' do
      employee = create(:employee)

      get :index

      expect(assigns(:employees)).to contain_exactly(employee)
    end
  end
end
