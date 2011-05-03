Roundtrip::Engine.routes.draw do
  resources :tickets, :only => [:index, :show, :new, :create] do
    resources :comments, :only => :create
  end
end
