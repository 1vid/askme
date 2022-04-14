module Questions
  class Update < BaseTransaction
    step :build_model
    step :validation
    step :persistence

    def build_model(input)
      # ** - позволяет все выпрямить в один хэш-кайф
      @question = Question.edit(author: input[:current_user], **input[:params])

      Success(input.merge(question: @question))
    end

    def validation(input)
      if input[:question].valid?
        Success(input)
      else
        Failure(input)
      end
    end

    def persistence(input)
      QuestionUpdate.(input[:question])

      Success(input)
    end
  end
end
