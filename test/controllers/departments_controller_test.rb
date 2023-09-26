# frozen_string_literal: true

require 'test_helper'

class DepartmentsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get departments_path
    assert_response :success
  end

  test 'should get show' do
    # Replace `department_id` with an actual department ID
    get department_path(16)
    assert_response :success
  end

  test 'should get edit' do
    # Replace `department_id` with an actual department ID
    get edit_department_path(16)
    assert_response :success
  end

  test 'should get update' do
    # Replace `department_id` with an actual department ID
    get department_path(16)
    assert_response :success
  end
end
