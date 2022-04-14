class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions

  validates :text, 
            presence: true,
            length: { minimum: 3, maximum: 255 }

  before_update :nilize_empty_answer

  def nilize_empty_answer
    attributes.each do |column, value|
      self[column].present? || self[column] = nil
    end
  end
end
