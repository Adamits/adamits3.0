module Helio
  module Rails
    class Engine < ::Rails::Engine
      initializer 'helio.assets.precompile' do |app|
        %w(stylesheets).each do |sub|
          app.config.assets.paths << root.join('assets', sub).to_s
        end
      end
    end
  end
end
