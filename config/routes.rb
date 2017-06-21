Rails.application.routes.draw do
  resources :job_openings
  resources :companies

  root to: "landing#index"
  get "search", to: "landing#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
