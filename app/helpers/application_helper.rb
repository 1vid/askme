module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def sklonjator(questions)
    number = questions.size 

    one = 'вопрос'
    few = 'вопроса'
    many = 'вопросов'

    with_number = false

    return "Этому челу задали #{number} #{many}" if (number % 100).between?(11, 14)

    word = case number % 10
            when 1 then one
            when 2..4 then few
            else
              many
            end

    "Этому челу задали #{number} #{word}"
  end
end
