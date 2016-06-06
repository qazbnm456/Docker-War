require 'redis/namespace'

class CustomRedisException < StandardError; end

class CustomRedis < StatusPage::Services::Base
  class Configuration
    DEFAULT_SERVER_HOST = 'redis://127.0.0.1:6379/1'

    attr_accessor :url

    def initialize
      @url = DEFAULT_SERVER_HOST
    end
  end

  def check!
    time = Time.now.to_s(:db)

    redis = ::Redis.new(url: config.url)
    redis.set(key, time)
    fetched = redis.get(key)

    raise "different values (now: #{time}, fetched: #{fetched})" if fetched != time
  rescue Exception => e
    raise CustomRedisException.new(e.message)
  ensure
    redis.disconnect!
  end

  private

  class << self
    private

    def config_class
      CustomRedis::Configuration
    end
  end

  def key
    @key ||= ['status-redis', request.try(:remote_ip)].join(':')
  end
end
