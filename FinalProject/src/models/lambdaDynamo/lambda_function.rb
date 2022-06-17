# Final Project: Quiz Application with Microservices
# Date: 10-Jun-2022
# Authors:
#          A01377744 Alejandro Torices Oliva
#          A01376544 Mariana Paola Caballero Cabrera
# File: lambda_function.rb

require 'json'
require 'aws-sdk-dynamodb'

DYNAMODB = Aws::DynamoDB::Client.new
TABLE_NAME = 'Leaderboard'

class HttpStatus
  OK = 200
  CREATED = 201
  BAD_REQUEST = 400
  METHOD_NOT_ALLOWED = 405
end

def make_response(code, body)
  {
    statusCode: code,
    headers: {
      "Content-Type" => "application/json; charset=utf-8"
    },
    body: JSON.generate(body)
  }
end

#--------------------------------------------------------------------
def make_result_list(items)
  items.map do |item| {
      'initials' => item['initials'],
      'score' => item['score'].to_i
    }
  end
end

#--------------------------------------------------------------------
def sort_items(items)
  items.sort! {|a, b| a['initials'] <=> b['initials']}
  items.sort! {|a, b| b['score'] <=> a['score']}
end

#--------------------------------------------------------------------
def get_table
  items = DYNAMODB.scan(table_name: TABLE_NAME).items
  sort_items(items)
  make_result_list(items)
end

#--------------------------------------------------------------------
def parse_body(body)
  if body
    begin
      data = JSON.parse(body)
      data.key?('initials') and data.key?('score') ? data : nil
    rescue JSON::ParserError
      nil
    end
  else
    nil
  end
end

#--------------------------------------------------------------------
def store_book_item(body)
  data = parse_body(body)
  if data
    DYNAMODB.put_item(table_name: TABLE_NAME, item: data)
    true
  else
    false
  end
end

#--------------------------------------------------------------------
def handle_get
  make_response(HttpStatus::OK, get_table)
end

#--------------------------------------------------------------------
def handle_post
  make_response(HttpStatus::CREATED,
    {message: 'Resource created or updated'})
end

#--------------------------------------------------------------------
def handle_bad_request
  make_response(HttpStatus::BAD_REQUEST,
    {message: 'Bad request (invalid input)'})
end

#--------------------------------------------------------------------
def handle_bad_method(method)
  make_response(HttpStatus::METHOD_NOT_ALLOWED,
    {message: "Method not supported: #{method}"})
end

#--------------------------------------------------------------------
def lambda_handler(event:, context:)
  method = event['httpMethod']
  case method
  when 'GET'
    handle_get

  when 'POST'
    if store_book_item(event['body'])
      handle_post
    else
      handle_bad_request
    end

  else
    handle_bad_method(method)
  end
end