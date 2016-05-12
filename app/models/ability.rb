class Ability
  include CanCan::Ability
  def initialize(user, ip)
    # Allow all logged in users and all anonymous local users to manage all projects
    if user && is_local(ip)
      can :read, :all
    end

    if user && user.admin?
      can :access, :rails_admin          # only allow admin users to access Rails Admin
      can :access, :dashboard            # allow access to dashboard
      can :manage, :all                  # allow admins to do anything
    end
  end

  private

  # This is the list of IP ranges that are on the local subnet
  def local_ip_ranges
    %w{
      127.0.0.1
      140.117.0.0/255.255.0.0
    }
  end

  # This is the method that checks if the given IP is in the above list
  def is_local(ip)
    require 'ipaddr'
    ip = IPAddr.new(ip)
    local_ip_ranges.any? {|range| IPAddr.new(range).include?(ip) }
  end
end