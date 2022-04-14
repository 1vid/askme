class QuestionUpdate
  def self.call(question)
    new(question).call
  end

  def call
    question.transaction do
      question.update

      question.hashtags =
        "#{question.text} #{question.answer}"
          .downcase
          .scan(Hashtag::HASH_TAG_REGEX)
          .uniq
          .map { |hashtag| Hashtag.find_or_create_by(text: hashtag.delete('#')) }
    end
  end

  private

  attr_reader :question

  def initialize(question)
    @question = question
  end
end
