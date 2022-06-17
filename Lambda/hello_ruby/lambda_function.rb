
require 'json'

def lambda_handler(event:, context:)
    nombre = event.dig('queryStringParameters', 'nombre') || 'Ruby'
    # TODO implement
    {
        statusCode: 200,
        body:
            JSON.generate({
                'code' => 'OK',
                'message' => "Hello #{nombre}!",
                'httpMethod' => event['httpMethod'] || 'No tiene',
                'path' => event['path'] || 'No tiene',
                'qryStrParams' => event['queryStringParameters'] || 'No hay',
                # 'headers' => event['headers'],
                'memory' => context.memory_limit_in_mb
        }),
        headers: {
            'Content-Type' => 'text/plain',
            'X-Mi-Mensaje' => 'Yo soy Juan Camaney'
        }
    }
end