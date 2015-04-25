Rails.application.routes.draw do
  resources :emergencies, defaults: { format: :json }, param: :code
  resources :responders, defaults: { format: :json }, param: :name
end
