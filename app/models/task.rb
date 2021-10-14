# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: Constants::MAX_TASK_TITLE_LENGTH }
end
