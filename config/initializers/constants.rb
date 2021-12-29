# frozen_string_literal: true

module Constants
  is_sqlite_db = ActiveRecord::Base.connection_db_config.configuration_hash[:adapter] == "sqlite3"
  DB_REGEX_OPERATOR = is_sqlite_db ? "REGEXP" : "~*"
  MAX_TASK_TITLE_LENGTH = 125
  MAX_NAME_LENGTH = 255
  MAX_EMAIL_LENGTH = 255
  MIN_PASSWORD_LENGTH = 6
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze
  MAX_COMMENT_CONTENT_LENGTH = 511
end
