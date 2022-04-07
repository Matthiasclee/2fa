TFA::Engine.routes.draw do
  get '/:id/verify', to: 'tfas#show', as: :tfa_verify
end
