Rails.application.routes.draw do
 
  devise_for :users
  
  root 'homes#top'
  
  resources :users, only:[:index, :show] do
    resource :relationships, only:[:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  resources :posts, only:[:new, :create, :index, :show] do
  # get 'posts/index'
  # get 'posts/show'
  # get 'posts/new'
    resource :favorites, only:[:create, :destroy]
    resources :comments, only:[:create]
  end
  
  resources :notices, only:[:index]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
