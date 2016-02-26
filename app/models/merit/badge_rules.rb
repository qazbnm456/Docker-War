# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badges (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badges to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badges is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # If it creates user, grant badges
      # Should be "current_user" after registration for badges to be granted.
      # Find badges by badge_id, badge_id takes presidence over badges
      # grant_on 'users#create', badge_id: 7, badges: 'just-registered', to: :itself

      # If it has 10 comments, grant commenter-10 badges
      # grant_on 'comments#create', badges: 'commenter', level: 10 do |comment|
      #   comment.user.comments.count == 10
      # end

      # If it has 5 votes, grant relevant-commenter badges
      # grant_on 'comments#vote', badges: 'relevant-commenter',
      #   to: :user do |comment|
      #
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', badges: 'autobiographer',
      #   temporary: true, model_name: 'User' do |user|
      #
      #   user.name.length > 4
      # end
      grant_on 'registrations#records_assign', badge: 'beginner'
      grant_on 'omniauth_callbacks#records_assign', badge: 'beginner'
    end
  end
end
