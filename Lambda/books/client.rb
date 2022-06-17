require "json"
require "faraday"

URL = 'https://l6i1z5o6b3.execute-api.us-east-2.amazonaws.com/default/books'

data = {
  Author: "Suzanne Collins",
  Title: "Catching Fire",
  Year: 2009
}

res = Faraday.post(URL, JSON.dump(data))

if res.success?
  puts "Status: #{res.status}. Resource created!"
end

res = Faraday.get(URL)

if res.success?
  data = JSON.parse(res.body)
  p data
end