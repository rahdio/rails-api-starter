class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def get_error
    all_errors = errors.full_messages
    all_errors ? all_errors[0] : "Invalid Entry. Please try again."
  end
end
