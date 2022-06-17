# Final Project: Quiz Application with Microservices
# Date: 10-Jun-2022
# Authors:
#          A01377744 Alejandro Torices Oliva
#          A01376544 Mariana Paola Caballero Cabrera
# File: lambda_function.rb

require 'json'

def lambda_handler(event:, context:)
    number = event.dig('queryStringParameters', 'number') || '1'
    file = File.read('./questions.json')
    questions = JSON.parse(file)

    samp = questions['data'].sample(number.to_i)

    {
        statusCode: 200,
        body: JSON.generate(samp)
    }
end
