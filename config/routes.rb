Rails.application.routes.draw do
  mount ApplicationAPI => "/"
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
end
