unless defined?(Devise)
  require 'devise'
end

Devise.add_module :custom_timeoutable, :model => 'custom_models/custom_timeoutable'