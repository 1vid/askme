module Questions
  class Create < BaseTransaction
    step :build_model
    step :validation
    step :persistence

    def build_model(input)
      # ** - позволяет все выпрямить в один хэш-кайф
      @question = Question.new(author: input[:current_user], **input[:params])

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
      input[:question].save

      Success(input)
    end
  end
end