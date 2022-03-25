class Question < ApplicationRecord
  belongs_to :user

  validates :text, 
            presence: true,
            length: { minimum: 3, maximum: 255 }
end
