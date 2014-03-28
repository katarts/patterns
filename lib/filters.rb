require "active_support/concern"
require "active_support/callbacks"

module Filters
  extend ActiveSupport::Concern
  include ActiveSupport::Callbacks

  included do
    define_callbacks :process
  end

  module ClassMethods
    def before_action(method)
      set_callback :process, :before, method
    end
    
    def after_action(method)
      set_callback :process, :after, method
    end
   
    # around_action :layout
    #
    # def layout
    #   yield
    # end
    #
    # around_action { |controller, action| action.call }
    def around_action(method = nil, &block)
      set_callback :process, :around, method, &block
    end
  end

  def process(action_name)
    run_callbacks :process do
      super
    end
  end
end


