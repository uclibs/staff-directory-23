# frozen_string_literal: true

class Employee < ApplicationRecord
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :title, presence: true
  validates :working_title, presence: true
  validates :department, presence: true
  # Add validations for other fields

  belongs_to :department
end
