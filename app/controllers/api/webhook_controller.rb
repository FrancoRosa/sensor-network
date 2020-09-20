class API::WebhookController < ApplicationController
  def index
    webhook if webhook?
  end

  def create
    puts 'XXXXXXXXXXXXXXXXXXXXXXX'
    puts 'POST'
    puts 'XXXXXXXXXXXXXXXXXXXXXXX'
    render json: { 'message': 'true' }
  end
  
  def webhook
    if params.keys.inspect.include?('hub.mode' && 'hub.verify_token')
      challenge = params['hub.challenge']
      if params['hub.verify_token'] == ENV['fb_vrfy'] && params['hub.mode'] == 'subscribe'
        render html: challenge
      else
        render status: 403, json: { 'message': 'token error' }
      end
    end
  end

  def webhook?
    params.keys.any?{ |x| x.inspect.include?('hub') } ? true : false
  end
end
