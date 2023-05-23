# frozen_string_literal: true

class Employee < ApplicationRecord
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  # Add validations for other fields

  belongs_to :department
end
