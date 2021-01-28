Rails.application.routes.draw do
  root 'pages#geo'

  # REST end points for creating and updating a user
  resources :users, only: [:create, :edit, :update]

  # REST end points for creating and destroying a session
  resources :sessions, only: [:new, :create, :destroy]

  # REST end point for a form to sign up a new user
  get 'signup', to: 'users#new', as: 'signup'
  get '/geo/(:country/:state)', to: "pages#geo", as: :location_listings

  # REST end point for a form to log in an existing user
  get 'login', to: 'sessions#new', as: 'login'
  # REST end point for destroying a logged in user's session
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # REST end point for a form to request a new password for an existing user
  get 'forgot_password', to: 'pages#forgot_password', as: 'forgot_password'

  # REST end point for a form to reset the password of an existing user with magic link
  post 'forgot_password_submit', to: 'pages#forgot_password_submit', as: 'forgot_password_submit'

  # REST end points for updating the password of an existing user with magic link
  get 'reset_password/:slug', to: 'users#reset_password', as: 'reset_password'
end
