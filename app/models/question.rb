class Question < ApplicationRecord
  
  belongs_to :user
  validates :question, :user, presence: true
 
end
