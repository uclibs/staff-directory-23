# frozen_string_literal: true

# User contains application behavior.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :registerable,
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :lockable
end
