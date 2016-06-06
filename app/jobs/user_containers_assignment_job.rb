require 'open3'
class UserContainersAssignmentJob < ActiveJob::Base
  queue_as :docker_assignment

  def perform(email, port)
    cmd = Rails.root.join('script', 'playground.sh').to_s + " -n u--#{email.gsub("@", "-0-").gsub(".", "-")}- -p #{port}"
    stdout, stderr, status = Open3.capture3(cmd)
    Rails.logger.info stdout
    Rails.logger.error stderr
  end
end
