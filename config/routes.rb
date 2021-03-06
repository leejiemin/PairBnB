Rails.application.routes.draw do

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password, controller: "clearance/passwords", only: [:create, :edit, :update]
  end


  get "/search" => "listings#search"
  post "/search_title" => "listings#autocomplete_title"
  post "/search_city" => "listings#autocomplete_city" 

  
  resources :listings do
    resources :reservations
  end


  # routes not nested more than 2
  # resources with s - gives :id
  
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  # this is for home
  get "/" => "clearance/users#testing", as: "root"

  get 'braintree/new/reservation/:id' => "braintree#new", as: "braintree_new"
  post 'braintree/checkout/reservation/:id' => "braintree#checkout", as: "braintree_checkout"

end
