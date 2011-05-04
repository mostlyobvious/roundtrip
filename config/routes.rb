Roundtrip::Engine.routes.draw do
  resources :tickets, :only => [:index, :show, :new, :create] do
    resources :comments, :only => :create
  end

  namespace :admin do
    resources :tickets, :only => [:index, :show, :close] do
      resources :comments, :only => :create
    end
  end
end
