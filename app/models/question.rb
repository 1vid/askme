class Question < ApplicationRecord
  validates :text, :user, presence: true

  validates :text, length: {maximum: 255}, allow_nil: false, on: :create
end
