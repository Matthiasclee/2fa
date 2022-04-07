module TFA
  class Engine < ::Rails::Engine
    isolate_namespace TFA

    initializer 'local_helper.action_controller' do
      ActiveSupport.on_load :action_controller do
        helper TFA::Engine.helpers
      end
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end
  end
end
