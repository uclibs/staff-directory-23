# frozen_string_literal: true

class CreateAddData < ActiveRecord::Migration[6.1]
  def change
    create_table :add_data, &:timestamps
  end
end
