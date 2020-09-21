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
      render status: 200, html: 'EVENT_RECEIVED'
    else
      render status: 404, html: '404 Not Found'
    end
  end

  def handleMessage(sender_psid, received_message)
    options = {
      title: 'Subscribe',
      subtitle: 'Would you like to receive automatic messages?',
      id: 'subs',
      buttons: [
        ['Yes', 'yes'],
        ['No', 'no']]
    }
    callSendMenu(options, sender_psid)
  end

  # // Handles messaging_postbacks events
  def handlePostback(sender_psid, received_postback)
    if received_postback[:payload].starts_with?('subs-')
      subs_postback(sender_psid, received_postback)
    elsif received_postback[:payload].starts_with?('dev-')
      dev_postback(sender_psid, received_postback)
    elsif received_postback[:payload].starts_with?('sen-')
      sen_postback(sender_psid, received_postback)
    end
  end

  def subs_postback(sender_psid, received_postback)
    if received_postback[:payload].ends_with?('yes')
      options = {
        title: 'Devices',
        subtitle: 'Select the device you want to receive news from',
        id: 'dev',
        buttons: Device.all.pluck(:name, :id)
      }
      callSendMenu(options, sender_psid)
    else received_postback[:payload].ends_with?('no')
      puts 'code'
      response = { text: 'You where unsubscribed' }
      callSendAPI(sender_psid, response)
        # List all available devices
    end
  end

  def dev_postback(sender_psid, received_postback)
    device_id = received_postback[:payload].sub('dev-', '').to_i
    @device = Device.find(device_id)
    options = {
      title: 'Sensors',
      subtitle: 'Select the sensor you want to receive updates from',
      id: 'sen',
      buttons: @device.sensors.map { |s| [s.variable.name, s.id] }
    }
    callSendMenu(options, sender_psid)
  end

  def sen_postback(sender_psid, received_postback)
    sensor_id = received_postback[:payload].sub('sen-', '').to_i
    @sensor = Sensor.find(sensor_id)
    @variable = @sensor.variable
    response = { text: "#{@variable.name}: #{@sensor.value}#{@variable.unit}" }
    callSendAPI(sender_psid, response)
  end

  def callSendMenu(options, sender_psid)
    buttons = []

    options[:buttons].each do |button|
      buttons.push(
        {
          type: 'postback',
          title: button[0],
          payload: "#{options[:id]}-#{button[1]}"
        }
      )
    end
      
    if options[:buttons].size <= 3
      response = {
        attachment: {
          type: 'template',
          payload: {
            template_type: 'generic',
            elements: [{
              title: options[:title],
              subtitle: options[:subtitle],
              buttons: buttons
            }]
          }
        }
      }
      callSendAPI(sender_psid, response)
    else
      groups = []
      until buttons.empty?
        groups.push(buttons.shift(3))
      end
      puts 'ZZZZZZZZZZZZZZZZZZZZZZZZZZ'
      puts groups.inspect
      puts 'ZZZZZZZZZZZZZZZZZZZZZZZZZZ'
      response = {
        attachment: {
          type: 'template',
          payload: {
            template_type: 'generic',
            elements: [{
              title: options[:title],
              subtitle: options[:subtitle],
              buttons: groups.shift
            }]
          }
        }
      }
      callSendAPI(sender_psid, response)
      
      groups.each do |group|
        puts group.inspect
        response = {
          attachment: {
            type: 'template',
            payload: {
              template_type: 'generic',
              elements: [{
                title: '...',
                buttons: group
              }]
            }
          }
        }
        callSendAPI(sender_psid, response)
      end
    end
  end

  def callSendAPI(sender_psid, response)
    uri = "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['fb_key']}"
    body = { recipient: {id: sender_psid}, message: response } 
    x = Net::HTTP.post(URI.parse(uri), body.to_json, "Content-Type" => "application/json")
    puts x.body
  end


end
