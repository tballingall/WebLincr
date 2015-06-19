#
class User < ActiveRecord::Base
  has_secure_password

  validates :email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
            presence: true,
            uniqueness: { case_sensitive: false }
end
