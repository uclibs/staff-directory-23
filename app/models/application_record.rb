# frozen_string_literal: true

# ApplicationRecord contains application behavior.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
