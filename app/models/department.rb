# frozen_string_literal: true

# Department contains application behavior.
class Department < ApplicationRecord
  has_many :employees, dependent: :restrict_with_error
  validates :name, presence: true
end
