# Final Project: Quiz Application with Microservices
# Date: 10-Jun-2022
# Authors:
#          A01377744 Alejandro Torices Oliva
#          A01376544 Mariana Paola Caballero Cabrera
# File: lambda_function.rb

require 'json'

def lambda_handler(event:, context:)
    h = {"a." => 0, "b." => 1, "c." => 2}
    body = JSON.parse(event['body'])
    file = File.read('./questions.json')
    questions = JSON.parse(file)

    if body['correct'] == body['option']
        res = 'Correct!'
    else
        res = 'Incorrect'
    end

    ans = questions['data'][body['id'].to_i-1]['options'][h[body['correct']]]

    data = {
        result: res,
        answer: ans
    }

    {
        statusCode: 200,
        body: JSON.generate(data)
    }
end
