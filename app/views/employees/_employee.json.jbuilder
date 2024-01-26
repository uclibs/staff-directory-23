# frozen_string_literal: true

json.extract! employee, :id, :lastname, :firstname, :email, :phone, :title, :created_at,
              :updated_at, :department_id # Add department_id to the JSON output
json.url employee_url(employee, format: :json)
