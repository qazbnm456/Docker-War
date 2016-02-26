require 'custom_hooks/custom_timeoutable'

module Devise
  module Models
    module CustomTimeoutable
      extend ActiveSupport::Concern

      def self.required_fields(klass)
        []
      end

      # Checks whether the user session has expired based on configured time.
      def timedout?(last_access)
        return false if remember_exists_and_not_expired?
        !timeout_in.nil? && last_access && last_access <= timeout_in.ago
      end

      def timeout_in
        self.class.timeout_in
      end

      private

      def remember_exists_and_not_expired?
        return false unless respond_to?(:remember_created_at) && respond_to?(:remember_expired?)
        remember_created_at && !remember_expired?
      end

      module ClassMethods
        Devise::Models.config(self, :timeout_in)
      end
    end
  end
end