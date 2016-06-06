Dir[File.expand_path('../../../lib/status_page/*.rb', __FILE__)].each { |file| require file }

StatusPage.configure do
  # Cache check status result 10 seconds
  self.interval = 10
  # Use service
  self.use :database
  self.use :cache
  self.add_custom_service CustomRedis, :url => 'redis://redis:6379/1'
  self.use :sidekiq
  self.add_custom_service Docker
end
