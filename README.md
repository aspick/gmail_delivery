# GmailDelivery

Use Gmail API for ActoinMailer deliver! method


## Installation

Add this line to your application's Gemfile:

    gem 'gmail_delivery', github: 'aspick/gmail_delivery'

And then execute:

    $ bundle install

## Usage

1.Install Initializer file
 


    $ rails g gmail_delivery

2.Create Project on your [Google Developers Console](https://console.developers.google.com/)

3.Enable Gmail API on APIs & auth -> APIs menu

4.Set Email Address and Product Name on APIs & auth -> Consent screen menu 

5.Create Client ID for native applicatoin on APIs & auth -> Credentials menu

6.Set Client ID and Client Secret:



on config/environments/development.rb
    
    ...
    config.gmail_delivery.client_id = # Client ID #
    config.gmail_delivery.client_secret = # Client Secret #
    ...

7.Fetch Refresh Token

	$ rake gmail_delivery:fetch_refresh_token

8.Set Refresh Token

on config/environments/development.rb

	...
	config.gmail_delivery.refresh_token = # Refresh Token #
	...

## Contributing

1. Fork it ( https://github.com/aspick/gmail_delivery/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
