# frozen_string_literal: true

# auto_register: false

require 'dry-validation'

module Api
  module Resource
    def self.included(klass)
      klass.extend Dry::Core::ClassAttributes

      klass.defines :default_page_size
      klass.defines :filterable_fields
      klass.defines :request_schema

      klass.extend ClassInterface
      klass.include InstanceInterface
    end

    module ClassInterface
      def request_schema(&block)
        if block_given?
          schema = Dry::Validation.Form(nil, &block)
          super(schema)
        else
          super()
        end
      end
    end

    module InstanceInterface
      def filterable_fields(params = {})
        params.select do |k, _|
          self.class.filterable_fields.include? k
        end
      end

      def request_schema
        self.class.request_schema
      end
    end
  end
end
