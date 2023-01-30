require_relative "question"

QUESTION_AMOUNT = 5

class Victorina
  attr_reader :questions
  attr_accessor :right_answers, :user_score, :current_index

  def initialize(file)
    @questions = Question.from_xml(file).sample(QUESTION_AMOUNT)
    @user_score = 0
    @right_answers = 0
    @current_index = 0
  end

  def current_question
    @current_question = questions[current_index]
  end

  def game(user_answer)
    if right_answer?(current_question.answers[user_answer - 1], current_question.right_answer)
      @right_answers += 1
      @user_score += current_question.score
      "Верно!"
    else
      "Неверно! Правильный овтет: #{current_question.right_answer}"
    end
  end

  def next_question!
    @current_index += 1
  end

  def result
    "Правильных ответов дано: #{right_answers} из #{QUESTION_AMOUNT} Кол-во баллов = #{user_score}"
  end

  def right_answer?(user_answer, right_answer)
    user_answer == right_answer
  end

  def over?
    current_index == QUESTION_AMOUNT
  end
end
