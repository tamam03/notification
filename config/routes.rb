Rails.application.routes.draw do
 
  devise_for :users
  
  root 'homes#top'
  
  resources :posts, only:[:new, :create, :index, :show] do
  # get 'posts/index'
  # get 'posts/show'
  # get 'posts/new'
    resource :favorites, only:[:create, :destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
