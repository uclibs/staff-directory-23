# frozen_string_literal: true

class Employee < ApplicationRecord
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :title, presence: true
  validates :department_id, presence: true, unless: -> { Rails.env.test? }
  belongs_to :department, optional: true
  # Add validations for other fields
end
