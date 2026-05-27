# frozen_string_literal: true

# User contains application behavior.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :registerable,
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :lockable

  before_validation :normalize_eppn

  validates :eppn, uniqueness: true, allow_nil: true

  private

  def normalize_eppn
    self.eppn = ShibbolethLogin.normalize_eppn(eppn)
  end
end
