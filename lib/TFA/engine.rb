module TFA
  class Engine < ::Rails::Engine
    isolate_namespace TFA

    initializer 'local_helper.action_controller' do
      ActiveSupport.on_load :action_controller do
        helper TFA::Engine.helpers
      end
    end
  end
end
