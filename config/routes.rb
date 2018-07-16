Rails.application.routes.draw do
  # devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root                   'static_pages#home'

  
  get    'about'      => 'static_pages#about'
  get    'contact'    => 'static_pages#contact'
  get    'help'       => 'static_pages#help'
  get    'users'      => 'users#index' 
  delete 'users'      => 'users#destroy'
  get 'create_user'   => 'users#new'
  get 'create_reservation'   => 'reservations#new'
  post 'hotels_search'       => 'hotels#search'
  post 'confirm'      => 'rooms#confirm'
  post 'reserve'        => 'payments#new'
  # delete 'rooms'      =.'rooms#destroy'
  resources :hotels, only: [:show,:index,:new,:create,:destroy]
  resources :rooms, only: [:show,:index, :new, :destroy,:create]
  post 'check_in'     => 'hotels#check_in'
  get 'my_bookings'   => 'reservations#my_bookings'
  post 'check_out_reservation' => 'reservations#check_out'
  resources :reservations
  resources :payments, only: [:create,:new]
  resources :registrations
  get 'user'          => 'users#show'
  # get 'users/:id'    => 'users#show'
  # resources :users, only: [:show]

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
    devise_for :users, controllers: { sessions:      "users/sessions",
                                      registrations: "users/registrations",
                                      passwords:     "users/passwords",
                                      unlocks:       "users/unlocks",
                                      confirmations: "users/confirmations",
                                      mailer:        "users/mailer",
                                      shared:        "users/shared"
                                        }
  post 'user_add'       => 'users#create'
  get "*path", to: redirect('/')
end
