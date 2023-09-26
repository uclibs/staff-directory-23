# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      raise ActiveRecord::InvalidForeignKey
    end
  end

  describe 'handling ActiveRecord::InvalidForeignKey exceptions' do
    it 'sets the flash error and redirects to departments_path' do
      get :index

      expect(response).to redirect_to(departments_path)
      expect(flash[:error]).to eq('Cannot delete department with associated employees.')
    end
  end
end
