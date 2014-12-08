Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  resources :landing
  
  # Feed
  get    'feed'           => 'feed#account', as: 'feed'
  get    'feed/:tag'      => 'feed#show', as: 'feed_show'
  get    'recent'         => 'feed#recent', as: 'recent'
  post   'feed/add'       => 'feed#add', as: 'feed_add'
  get    'trending'       => 'feed#trending', as: 'trending'
  get    'gravity/:tag'   => 'feed#gravity', as: 'gravity'
  
  # Account
  get    'account'               => 'account#panel', as: 'account_panel'
  get    'account/verify/:code'  => 'account#verify', as: 'account_verify'
  
  # Member
  get    'member/new'       => 'member#new', as: 'member_new'
  post   'member/new'       => 'member#create', as: 'member_create'
  get    'member/success'   => 'member#success'
  
  # Session
  get    'session/login'        => 'session#login', as: 'session_login'
  post   'session/login'        => 'session#authenticate'
  post   'session/logout'       => 'session#logout', as: 'session_logout'
  get    'session/not_verified' => 'session#not_verified', as: 'session_not_verified'
  
  # Question
  get    'question'             => 'question#index'
  post   'question'             => 'question#ask', as: 'question_ask'
  get    'question/:id'         => 'question#show', as: 'question_show'
  delete 'question/:id/delete'  => 'question#delete', as: 'question_delete'
  
  # Answer
  post   'question/:id/answer'   => 'answer#new', as: 'answer_new'
  delete 'answer/:id/delete'     => 'answer#delete', as: 'answer_delete'
  
  # Vote
  post   'answer/:id/vote'   => 'vote#cast', as: 'vote_cast'

  root   'landing#index'
end
