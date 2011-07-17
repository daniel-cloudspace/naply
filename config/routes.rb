Naply::Application.routes.draw do
  resources :friendships

  resources :users

  get "pages/home"



  get 'messaging', :controller => 'messaging', :action => 'index'


  root :to => "pages#home"
  post 'messaging', :controller => 'messaging', :action => 'index'
end
