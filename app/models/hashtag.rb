class Hashtag < ApplicationRecord
  HASH_TAG_REGEX = /#[[:word:]-]+/
  has_many :hashtag_questions, dependent: :destroy
  has_many :questions, through: :hashtag_questions
  validates :text, presence: true, uniqueness: true
end