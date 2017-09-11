require 'casting'
require 'active_support'

module DCI
  module Context
    extend ActiveSupport::Concern

    included do
      def self.perform(*args)
        self.new.perform(*args)
      end
    end

    def characterize(*args, &_block)
      yield
      args.each do |item|
        item.uncast unless item.nil?
      end
    end
  end
end
