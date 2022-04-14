class QuestionSave
  def self.call(question)
    new(question).call
  end

  def call
    question.transaction do
      question.save

      question.hashtags =
        "#{question.text} #{question.answer}"
          .downcase
          .scan(Hashtag::HASH_TAG_REGEX)
          .uniq
          .map { |hashtag| Hashtag.find_or_create_by(text: hashtag.delete('#')) }
          # .map { |hashtag| Hashtag.where(text: hashtag.delete('#')) || answer: hashtag.delete('#')) }
    end
  end

  private

  attr_reader :question

  def initialize(question)
    @question = question
  end
end
