require 'gmail_delivery'

namespace :gmail_delivery do
	desc "Fetch Refresh Token"
	task fetch_refresh_token: :environment do
		require 'google/api_client/auth/installed_app'
		gmail = GmailDelivery::Sender.new(auto_fetch: false)
		client = gmail.client
		flow = Google::APIClient::InstalledAppFlow.new(
			client_id: client.authorization.client_id,
			client_secret: client.authorization.client_secret,
			scope: 'https://mail.google.com/'
		)
		client.authorization = flow.authorize
		puts "refresh_token: #{client.authorization.refresh_token}"
	end
end