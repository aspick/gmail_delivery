require 'rails/railtie'
require 'gmail_delivery'

module GmailDelivery
	class Railtie < ::Rails::Railtie
		config.gmail_delivery = ActiveSupport::OrderedOptions.new
		config.eager_load_namespaces << GmailDelivery

		generators do
			require 'gmail_delivery/generator'
		end

		rake_tasks do
			load 'tasks/gmail_delivery_tasks.rake'
		end
	end
end