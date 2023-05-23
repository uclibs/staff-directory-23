# frozen_string_literal: true

class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
  end

  def show; end

  def new
    @department = Department.new
  end

  def edit; end
end
