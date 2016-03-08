DockerWar::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pages#index'

  match '/home', to: 'pages#home', via: 'get'
  match '/qna', to: 'pages#qna', via: 'get'
  match '/new_q', to: 'pages#new_q', via: 'post'
  match '/qna_ans', to: 'pages#qna_ans', via: 'patch'
  match '/qna_edit', to: 'pages#qna_edit', via: 'patch'
  match '/rule', to: 'pages#rule', via: 'get'
  match '/about', to: 'pages#about', via: 'get'
  match '/wargame', to: 'pages#wargame', via: 'get'
  match '/rank', to: 'pages#rank', via: 'get'
  match '/trend', to: 'pages#trend', via: 'get'
  match '/completed_records', to: 'pages#completed_records', via: 'get'
  match '/timeline', to: 'pages#timeline', via: ['get', 'options']

  match '/wargame/basic', to: 'basic#index', via: 'get'
  match '/wargame/basic/level1', to: 'basic#level1', via: [ 'get', 'post' ]
  match '/wargame/basic/level2', to: 'basic#level2', via: [ 'get', 'post' ]
  match '/wargame/basic/level3', to: 'basic#level3', via: [ 'get', 'post' ]
  match '/wargame/basic/level4', to: 'basic#level4', via: [ 'get', 'post' ]
  match '/wargame/basic/level5', to: 'basic#level5', via: [ 'get', 'post' ]
  match '/wargame/web', to: 'web#index', via: 'get'
  match '/wargame/web/level1', to: 'web#level1', via: [ 'get', 'post' ]
  match '/wargame/web/level2', to: 'web#level2', via: [ 'get', 'post' ]
  match '/wargame/web/level3', to: 'web#level3', via: [ 'get', 'post' ]
  match '/wargame/web/level4', to: 'web#level4', via: [ 'get', 'post' ]
  match '/wargame/web/level5', to: 'web#level5', via: [ 'get', 'post' ]
  match '/wargame/reverse', to: 'reverse#index', via: 'get'
  match '/wargame/reverse/level1', to: 'reverse#level1', via: [ 'get', 'post' ]
  match '/wargame/reverse/level2', to: 'reverse#level2', via: [ 'get', 'post' ]
  match '/wargame/reverse/level3', to: 'reverse#level3', via: [ 'get', 'post' ]
  match '/wargame/reverse/level4', to: 'reverse#level4', via: [ 'get', 'post' ]
  match '/wargame/reverse/level5', to: 'reverse#level5', via: [ 'get', 'post' ]
  match '/wargame/crypto', to: 'crypto#index', via: 'get'
  match '/wargame/crypto/level1', to: 'crypto#level1', via: [ 'get', 'post' ]
  match '/wargame/crypto/level2', to: 'crypto#level2', via: [ 'get', 'post' ]
  match '/wargame/crypto/level3', to: 'crypto#level3', via: [ 'get', 'post' ]
  match '/wargame/crypto/level4', to: 'crypto#level4', via: [ 'get', 'post' ]
  match '/wargame/crypto/level5', to: 'crypto#level5', via: [ 'get', 'post' ]

  match '/user/:id', to: 'users#show', via: 'get', as: :show_user

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations', sessions: 'sessions' }
  devise_scope :user do
    get "register", :to => "registrations#new"
    get "login", :to => "sessions#new"
    get "logout", :to => "sessions#destroy"
  end
end
