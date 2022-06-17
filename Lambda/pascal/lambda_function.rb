require 'json'
require 'pascal'

def lambda_handler(event:, context:)
    n_str = event.dig('queryStringParameters', 'n') || '0'
    n = n_str.to_i
    resultado = triangulo(n)
    # TODO implement
    { statusCode: 200, body: JSON.generate({
        message: 'Ok',
        result: resultado
    }) }
end