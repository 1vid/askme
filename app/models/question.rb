class Question < ApplicationRecord
  belongs_to :user

  validates :question, presence: true
  validates :question, length: { minimum: 3, maximum: 255 }, allow_nil: false
