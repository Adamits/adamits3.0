require 'helio/version'

module Helio
  class << self
    def load!
      register_rails_engine
    end

    private

    def register_rails_engine
      require 'helio/engine'
    end
  end
end

Helio.load!
