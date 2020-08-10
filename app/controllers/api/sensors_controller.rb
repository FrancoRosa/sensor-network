require "uri"
require "net/http"
require "json"
class API::SensorsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    if webhook?(params)
      webhook(params)
    elsif params[:sensor][:value].nil?
      if params[:sensor][:id].empty?
        @sensor = Sensor.all
      else
        @sensor = Sensor.where(id: params[:sensor][:id])
      end
      render json: @sensor.map { |sensor| [sensor.id, sensor.value] }
    else
      params[:sensor][:id].each_with_index do |id, index|
        Sensor.find(id).update(value: params[:sensor][:value][index])
      end
      render json: { 'message': 'true' }
    end
  end

  def create
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
  
  def webhook(params)
    if params.keys.inspect.include?('hub.mode' && 'hub.verify_token')
      challenge = params['hub.challenge']
      if params['hub.verify_token'] == ENV['fb_vrfy'] && params['hub.mode'] == 'subscribe'
        render html: challenge
      else
        render status: 403, json: { 'message': 'token error' }
      end
    end
  end

  def webhook?(params)
    params.keys.any?{ |x| x.inspect.include?('hub') } ? true : false
  end

  # // Handles messages events
  def handleMessage(sender_psid, received_message)
    puts '>>>>>>>>> message Handler'
    if received_message[:text]
      response = { text: "You send: #{received_message[:text]}. Now send an image" }
    end
    callSendAPI(sender_psid, response)
  end

  # // Handles messaging_postbacks events
  def handlePostback(sender_psid, received_postback)
    puts '>>>>>>>>> postback Handler'
  end


  # // Sends response messages via the Send API
  def callSendAPI(sender_psid, response)
    uri = "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['fb_key']}"
    body = { recipient: {id: sender_psid}, message: response } 
    x = Net::HTTP.post(URI.parse(uri), body.to_json, "Content-Type" => "application/json")
    puts x.body
  end
end
