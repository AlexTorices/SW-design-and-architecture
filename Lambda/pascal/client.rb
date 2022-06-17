require "json"
require "faraday"

URL = "https://pdwao82ulb.execute-api.us-east-2.amazonaws.com/default/pascal"

connection = Faraday.new(url: URL)
res = connection.get do |req|
    req.params['n'] = 4
end

if res.success?
    data = JSON.parse(res.body)
    p data
end