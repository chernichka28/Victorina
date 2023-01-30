require_relative "right_form"

class Question
  attr_reader :text_question, :answers, :score, :answer_time, :right_answer

  def self.from_xml(file)
    params = {}
    doc = REXML::Document.new(file)

    all_questions = doc.get_elements("questions/question").map do |item|
      params[:text] = item.elements["text"].text
      params[:time] = item.attributes["sec"]
      params[:points] = item.attributes["points"]
      params[:right_answer] = nil

      answers = item.get_elements("variants/variant").map do |variant|
        params[:right_answer] = variant.text if variant.attributes["right"]
        variant.text
      end

      params[:answers] = answers.shuffle
      new(params)
    end
    all_questions
  end

  def initialize(params)
    @answers = params[:answers]
    @answer_time = params[:time].to_i
    @right_answer = params[:right_answer]
    @score = params[:points].to_i
    @text_question = params[:text]
  end

  def to_s
    scores_word = RightForm.declination(score, "балл", "балла", "баллов")
    string = "#{text_question} (#{score} #{scores_word}). Времени на ответ - #{answer_time} сек.\n"

    answers.each.with_index(1) do |answer, index|
      string += "#{index}) #{answer}\n"
    end

    string
  end
end
