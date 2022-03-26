class UsersController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Ilia',
      username: 'kucherjashka',
      avatar_url: 'https://avatarko.ru/img/kartinka/1/avatarko_anonim.jpg'
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2015')),
      Question.new(text: 'В чем смысл жизни?', created_at: Date.parse('27.03.2015'))
    ]

    @new_question = Question.new
  end
end
