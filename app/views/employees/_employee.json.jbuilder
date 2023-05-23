# frozen_string_literal: true

json.extract! employee, :id, :lastname, :firstname, :email, :phone, :title, :department, :pronouns, :created_at,
              :updated_at
json.url employee_url(employee, format: :json)
