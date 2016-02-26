# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  # config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grand badges if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'
  config.add_observer 'ReputationChangeObserver'
end

Merit::Badge.create!({
    id: 1,
    name: "beginner",
    level: 0,
    description: "初來乍到",
    custom_fields: { display_name: "萌芽勳章", image: 'badges/萌芽勳章.gif' }
}, {
    id: 2,
    name: "1000pts",
    level: 1,
    description: "1000分達成",
    custom_fields: { display_name: "1000分達成成就", image: 'badges/陽光熱情勳章.gif' }
})

