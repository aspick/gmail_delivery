module GmailDelivery
	class GmailDeliveryGenerator < Rails::Generators::Base
		desc "Initialize GmailDelivery"
		def create_initializer_file
			initializer "gmail_delivery.rb" do
				<<-FILE.strip_heredoc
					ActionMailer::Base.add_delivery_method :gmail, GmailDelivery::Sender
				FILE
			end
		end
	end
end