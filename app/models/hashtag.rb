class Hashtag < ApplicationRecord
  HASH_TAG_REGEX = /#[[:word:]-]+/
  validates :text, presence: true, uniqueness: true
end