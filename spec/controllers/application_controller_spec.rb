# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      # Simulate a controller action that would hit a FK constraint
      raise ActiveRecord::InvalidForeignKey
    end
  end

  before do
    # Let the anonymous controller use real app routes (for departments_path)
    routes.draw do
      get 'anonymous' => 'anonymous#index'
    end

    # Bypass Devise auth so the action actually runs and triggers the rescue
    allow(controller).to receive(:authenticate_user!).and_return(true)
  end

  describe 'handling ActiveRecord::InvalidForeignKey exceptions' do
    it 'sets the flash error and redirects to departments_path' do
      get :index # hits the anonymous#index above

      expect(response).to redirect_to(departments_path)
      expect(flash[:error]).to eq('Cannot delete department with associated employees.')
    end
  end
end
