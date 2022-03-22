class Question < ApplicationRecord
  
  belons_to :user
  validates :text, :user, presence: true
end
