class API::WebhookController < ApplicationController
  def index
    puts 'XXXXXXXXXXXXXXXXXXXXXXX'
    puts 'GET'
    puts 'XXXXXXXXXXXXXXXXXXXXXXX'
    render json: { 'message': 'true' }
  end

  def create
    puts 'XXXXXXXXXXXXXXXXXXXXXXX'
    puts 'POST'
    puts 'XXXXXXXXXXXXXXXXXXXXXXX'
    render json: { 'message': 'true' }
  end
end
