# Final Project: Quiz Application with Microservices
# Date: 10-Jun-2022
# Authors:
#          A01377744 Alejandro Torices Oliva
#          A01376544 Mariana Paola Caballero Cabrera
# File: quiz.rb

require 'sinatra'
require 'json'
require 'faraday'

# Display the starting screen.
get '/' do
    erb :index
end

enable :sessions


# Start the quiz with the required number of questions.
get '/start' do
    URL = 'https://exrrk9t6z9.execute-api.us-east-2.amazonaws.com/default/quiz'
    @number = params[:questions]
    @initials = params[:initials]
    @current = 0

    session[:points] = 0
    session[:current] = @current
    session[:initials] = @initials
    session[:number] = @number

    res = Faraday.get(URL, :number=>@number)

    if res.success?
        data = JSON.parse(res.body)
        @quiz = data.to_enum
        session[:questions] = data
        session[:id] = @quiz.peek['id']
        session[:answer] = @quiz.peek['answer']
        erb :quiz
    else
        puts(res.status)
    end
end

# Check if the answer is correct or not and display the feedback.
get '/check' do

    URL = 'https://57oidngf7b.execute-api.us-east-2.amazonaws.com/default/check_answer'

    data = {
        id: session[:id].to_i,
        correct: session[:answer],
        option: params[:option]
    }

    res = Faraday.post(URL, JSON.dump(data))

    if res.success?
        info = JSON.parse(res.body)
        @result = info['result']
        if @result == 'Correct!'
            @answer = ''
            session[:points] += 1
        else
            @answer = info['answer']['text']
        end
        erb :feedback
    end

end

# Display the next question or display the final screen with the results.
get '/nextquestion' do
    URL = 'https://8tcqzpe41b.execute-api.us-east-2.amazonaws.com/default/access_leaderboard'
    @quiz = session[:questions].to_enum
    @current = session[:current] += 1
    @number = session[:number]
    if (@current.to_i == @number.to_i)
        @points = session[:points]

        data = {
            initials: session[:initials],
            score: session[:points]
        }
        Faraday.post(URL, JSON.dump(data))
        res = Faraday.get(URL)
        if res.success?
          @info = JSON.parse(res.body)
        end
        session.clear
        erb :results
    else
        @current.to_i.times do
            @quiz.next
        end
        session[:id] = @quiz.peek['id']
        session[:answer] = @quiz.peek['answer']
        erb :quiz
    end
end