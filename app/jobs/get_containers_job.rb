require 'open3'
class GetContainersJob < ActiveJob::Base
  queue_as :get_containers

  def perform(email, controller_name, action_name, subdomain, flag, db)
    cmd = Rails.root.join('script', 'playground.sh').to_s + " -n u--#{email.gsub("@", "-0-").gsub(".", "-")}- -s #{subdomain} -f #{flag.inspect} -b #{(db.nil? || db.empty?) ? ''.inspect : db} -i #{controller_name+"-"+action_name}"
    stdout, stderr, status = Open3.capture3(cmd)
    Rails.logger.info stdout
    Rails.logger.error stderr
  end
end
