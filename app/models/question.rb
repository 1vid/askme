class Question < ApplicationRecord
  belongs_to :user

  validates :question, presence: true
  validates :question, length: {maximum: 255}, allow_nil: false, on: :create
end
