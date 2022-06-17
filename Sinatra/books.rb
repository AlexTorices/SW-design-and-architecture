require "sinatra"
require "json"
require "faraday"

URL = 'https://l6i1z5o6b3.execute-api.us-east-2.amazonaws.com/default/books'

get '/' do
    response = Faraday.get(URL)
    @info = []
    if response.success?
        @info = JSON.parse(response.body)
    end
    erb :books
end