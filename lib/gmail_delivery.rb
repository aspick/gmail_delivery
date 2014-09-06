require "gmail_delivery/version"
require 'google/api_client'

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
				raise "No #{key.to_s}" unless certs[key]
			end
			client_id = Rails.application.config.gmail_delivery

			@client = Google::APIClient.new(
				application_name: 'Gmail Delivary',
				application_version: VERSION
			)

			@client.authorization.client_id = certs[:client_id]
			@client.authorization.client_secret = certs[:client_secret]
			@client.authorization.refresh_token = certs[:refresh_token]
			@client.authorization.fetch_access_token! unless options[:auto_fetch] == false

			@gmail = @client.discovered_api('gmail','v1')
		end

		attr_accessor :client

		def deliver!(mail)
			unless @client.authorization.expired?
				@client.authorization.update!
			end

			result = @client.execute(
				api_method: gmail_send_method,
				parameters: {'userId' => 'me'},
				body_object:{
					raw: encode_mail(mail)
				}
			)

			result
		end

		def settings
			Rails.application.config.gmail_delivery
		end

		private

		def gmail_send_method
			@gmail.users.messages.discovered_methods.find{|m| m.name == 'send'}
		end

		def encode_mail(mail)
			Base64.urlsafe_encode64(mail.to_s)
		end
	end
end
