Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  resources :landing
  
  # Community
  get   'community'       => 'community#index'
  post  'community/pick'  => 'community#pick', as: 'pick_community'
  
  # Feed
  get   'feed'  => 'feed#index'
  
  # Account
  get   'account'    => 'account#panel', as: 'account_panel'
  
  # Member
  get   'member/new'       => 'member#new', as: 'member_new'
  post  'member/new'       => 'member#create'
  get   'member/success'   => 'member#success'
  
  # Session
  get   'session/login'    => 'session#login', as: 'session_login'
  post  'session/login'    => 'session#authenticate'
  get  'session/logout'   => 'session#logout', as: 'session_logout'

  root  'landing#index'
end
