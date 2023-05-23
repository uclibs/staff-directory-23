# frozen_string_literal: true

class PublicController < ApplicationController
  def index
    @employees = Employee.all
  end

  def about; end
end
