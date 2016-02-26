class Ability
  include CanCan::Ability
  def initialize(user)
    can :read, :all                      # allow everyone to read everything
    if user && user.admin?
      can :access, :rails_admin          # only allow admin users to access Rails Admin
      can :access, :dashboard            # allow access to dashboard
      can :manage, :all                  # allow admins to do anything
    end
  end
end