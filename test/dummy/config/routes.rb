Rails.application.routes.draw do
  root :to => "home#index"
  devise_for :users
  mount Roundtrip::Engine => "/support", :as => "support"
end
