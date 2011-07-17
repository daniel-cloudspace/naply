Naply::Application.routes.draw do
<<<<<<< HEAD
  resources :friendships

  resources :users

  get "pages/home"



  get 'messaging', :controller => 'messaging', :action => 'index'


  root :to => "pages#home"
=======
  post 'messaging', :controller => 'messaging', :action => 'index'
>>>>>>> 3bca9c7a1fc340d34b772461972ce3c120a7a92c
end
