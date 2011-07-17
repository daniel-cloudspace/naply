Naply::Application.routes.draw do
  get "pages/home"



  get 'messaging', :controller => 'messaging', :action => 'index'


  root :to => "pages#home"
end
