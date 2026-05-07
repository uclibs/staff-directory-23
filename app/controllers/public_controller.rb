# frozen_string_literal: true

# PublicController contains application behavior.
class PublicController < ApplicationController
  def index
    @employees = Employee.all
  end
end
