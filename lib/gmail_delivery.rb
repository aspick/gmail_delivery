require "gmail_delivery/version"
require 'google/apis/gmail_v1'
require 'signet/oauth_2/client'
require 'gmail_delivery/railtie' if defined?(Rails)

module GmailDelivery
	class Sender
		def initialize(options)
			certs = {}
			[
				:client_id,
				:client_secret,
				:refresh_token
			].each do |key|
				certs[key] = Rails.application.config.gmail_delivery.send(key)
				raise "No #{key.to_s}" if certs[key] == nil and (key != :refresh_token and options[:auto_fetch])
			end

			client = Signet::OAuth2::Client.new(
			  authorization_uri: 		'https://accounts.google.com/o/oauth2/auth',
			  token_credential_uri: 'https://www.googleapis.com/oauth2/v3/token',
			  client_id: 						certs[:client_id],
			  client_secret: 				certs[:client_secret],
			  scope:								'https://mail.google.com/',
				refresh_token:				certs[:refresh_token]
			)

			client.fetch_access_token! unless options[:auto_fetch] == false

			@client = Google::Apis::GmailV1::GmailService.new
			@client.authorization = client
			@client
		end

		attr_accessor :client

		def deliver!(mail)
			unless @client.authorization.expired?
				@client.authorization.update!
			end

			@client.send_user_message('me', gmail_message_object(mail))
		end

		def settings
			Rails.application.config.gmail_delivery
		end


		private

		def gmail_message_object(mail)
			Google::Apis::GmailV1::Message.new(raw: mail.encoded)
		end
	end
end
