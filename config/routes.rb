Naply::Application.routes.draw do
  resources :friendships

  get 'jit_output' => 'friendships#jit_output'
  get 'network_map' => 'friendships#network_map'

  resources :users

  get "pages/home"
  get "a" => "friendships#a"



  post 'messaging', :controller => 'messaging', :action => 'index'


  root :to => "pages#home"
end
