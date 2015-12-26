module Twilio
  class SMSController < ApplicationController

    def sms
      puts params
      # @sms = SMS.new(body: params[:Body], from: params[:From])
      # @sms.save

      render xml: "<Response><Message>Test response from Twilio#sms.</Message></Response>"
    end

    def create
      puts params
      # @sms = SMS.new(body: params[:Body], from: params[:From])
      # @sms.save

      render xml: "<Response><Message>Test response from Twilio#create.</Message></Response>"
    end

  end
end