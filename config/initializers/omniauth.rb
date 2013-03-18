Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'vwzaOnpp3PiVM70KRZSA', 'JksgbPrnpjs6Njt2SA7Oymad7TrwX030WUARgsKt8'
end

Twitter.configure do |config|
  config.consumer_key = 'vwzaOnpp3PiVM70KRZSA'
  config.consumer_secret = 'JksgbPrnpjs6Njt2SA7Oymad7TrwX030WUARgsKt8'
end
