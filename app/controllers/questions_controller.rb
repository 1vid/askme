class QuestionsController < ApplicationController
  before_action :load_question, only: %i[ show edit update destroy ]
  before_action :authorize_user, except: [:create]
  
  def edit
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to user_path(@question.user), notice: 'Ты задал свой вопрос'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to user_path(@question.user), notice: 'Вопрос обновлен и засейвлен в великую базу тупых вопросов'
    else
      render :new
    end
  end

  def destroy
    user = @question.user
    @question.destroy

    redirect_to user_path(user), notice: 'Вопрос уничтожен'
  end

  private
  def load_question
    @question = Question.find(params[:id])
  end

  def authorize_user
    reject_user if @question.user != current_user
  end

  def question_params
    params.require(:question).permit(:user_id, :text, :answer)
  end
end
