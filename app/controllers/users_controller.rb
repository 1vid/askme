class UsersController < ApplicationController
  def index
    # Мы создаем массив из двух болванок пользователей. Для создания фейковой
    # модели мы просто вызываем метод User.new, который создает модель, не
    # записывая её в базу.
    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://secure.gravatar.com/avatar/' \
          '71269686e0f757ddb4f73614f43ae445?s=100'
      ),
      User.new(id: 2, name: 'Misha', username: 'aristofun')
    ]
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
