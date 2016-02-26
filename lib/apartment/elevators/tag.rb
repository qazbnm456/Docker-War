require 'apartment/elevators/generic'

module Apartment
  module Elevators
    class Tag < Generic

      def parse_tenant_name(request)
        if Indicator.first.can_go?
          Indicator.first.cant_go
          @s = Setting.find_by_active(true)
          tenant = (@s.nil?) ? (Rails.env.production?) ? ENV['DATABASE_NAME'] : Rails.env : @s.tag

          User.all.update_all('score = 0')
          cmd = Rails.root.join('script', 'playground.sh').to_s + " -n _0_ -d"
          stdout, stderr, status = Open3.capture3(cmd)
          p stdout
          p stderr

          p "Don't forget database:convert_to_utf8mb4."
          tenant.presence
        else
          nil
        end
      end
    end
  end
end
