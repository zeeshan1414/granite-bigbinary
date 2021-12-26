# frozen_string_literal: true

class User < ApplicationRecord
  has_many :assigned_tasks, foreign_key: :assigned_user_id, class_name: "Task"
  has_secure_password
  has_secure_token :authentication_token

  validates :name, presence: true, length: { maximum: Constants::MAX_NAME_LENGTH }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: Constants::MAX_EMAIL_LENGTH },
                    format: { with: Constants::VALID_EMAIL_REGEX }
  validates :password, length: { minimum: Constants::MIN_PASSWORD_LENGTH }, if: -> { password.present? }
  validates :password_confirmation, presence: true, on: :create

  before_save :to_lowercase

  private

    def to_lowercase
      email.downcase!
    end
end
