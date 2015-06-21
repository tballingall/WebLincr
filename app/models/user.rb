#
class User < ActiveRecord::Base
  has_secure_password

  validates :email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
            presence: true,
            uniqueness: { case_sensitive: false }

  self.per_page = 6

  # query: Return a user to use as the value for current_user
  #
  # Returns a Null user if no user is found
  #
  # @return [User] User duck
  #
  def self.current_user(id)
    find(id)
  rescue ActiveRecord::RecordNotFound
    null_user
  end

  def self.find_by_email(email)
    user = where(email: email).first
    return NullUser.new unless user.present?
    user
  end

  # query: Return a null user object
  #
  # Returns a Struct which responds to id, email, username, and authenticate
  #
  # @return [User] User duck
  #
  def self.null_user
    NullUser.new
  end

  # User duck type for null user pattern
  #
  class NullUser
    attr_reader :id, :email, :username

    def authenticate(_)
      false
    end
  end
end
