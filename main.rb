require "rexml/document"
require "timeout"
require_relative "lib/victorina"

file_path = File.join(__dir__, "data", "questions.xml")
file = File.new(file_path)

victorina = Victorina.new(file)
file.close

puts "Привет, это мини-викторина! На каждый вопрос отводится время - не тяните с ответом!!!"

until victorina.over?
  puts victorina.current_question
  user_choice = nil

  begin
    Timeout::timeout(victorina.current_question.answer_time) do
      user_choice = $stdin.gets.to_i
    end
  rescue Timeout::Error
    break puts "Время вышло!"
  end

  puts victorina.game(user_choice)
  puts
  victorina.next_question!
  sleep(0.5)
end

puts victorina.result
