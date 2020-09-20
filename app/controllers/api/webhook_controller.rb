class API::WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    webhook if webhook?
  end

  def create
    webhook_post
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

  def webhook_post
    if params[:object] == 'page'
      params[:entry].each do |entry|
        webhook_event = entry[:messaging][0]
        sender_psid = webhook_event[:sender][:id]
        handlePostback(sender_psid, webhook_event[:postback]) if webhook_event[:postback]
        handleMessage(sender_psid, webhook_event[:message]) if webhook_event[:message]
      end
      render status: 200, html: 'Ok'
    else
      render status: 404, html: 'notOk'
    end
  end

  def handleMessage(sender_psid, received_message)
    puts '>>>>>>>>> message Handler'
    if received_message[:text] == 'Subscribe'
      response = {
        attachment: {
          type: 'template',
          payload: {
            template_type: 'generic',
            elements: [{
              title: 'Subscribe',
              subtitle: 'Would you like to receive automatic messages?',
              buttons: [
                {
                  type: 'postback',
                  title: 'Yes!',
                  payload: 'subs-yes'
                },
                {
                  type: 'postback',
                  title: 'No.',
                  payload: 'subs-no'
                }
              ]
            }]
          }
        }
      }
    end

    callSendAPI(sender_psid, response)
  end

  # // Handles messaging_postbacks events
  def handlePostback(sender_psid, received_postback)
    puts '>>>>>>>>> postback Handler'
  end

  def callSendAPI(sender_psid, response)
    uri = "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['fb_key']}"
    body = { recipient: {id: sender_psid}, message: response } 
    x = Net::HTTP.post(URI.parse(uri), body.to_json, "Content-Type" => "application/json")
    puts x.body
  end
end
