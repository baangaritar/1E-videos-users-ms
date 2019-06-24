Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, param: :_username
  post 'login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
  post 'verify_token' => 'authentication#verify' # Verify if JWT is true or not

  
end
