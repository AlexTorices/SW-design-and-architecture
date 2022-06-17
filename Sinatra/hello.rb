require 'sinatra'

get '/hello/:name?' do
    @name = params['name'] || 'mundo'
    @potencias = (0..10).map {|x| 2 ** x}
    erb :hello
end