require 'open3'

class DockerException < StandardError; end

class Docker < StatusPage::Services::Base
  class Configuration
    DEFAULT_SERVER_HOST = 'unix:///var/run/docker.sock'

    attr_accessor :host

    def initialize
      @host = DEFAULT_SERVER_HOST
    end
  end

  def check!
    # Check connection to docker server:
    check_connection!
  rescue Exception => e
    raise DockerException.new(e.message)
  end

  private

  class << self
    private

    def config_class
      Docker::Configuration
    end
  end

  def check_connection!
    cmd = "docker" + " -H #{config.host} " + "ps"
    stdout, stderr, status = Open3.capture3(cmd)
    raise stderr unless status.success?
  end
end
