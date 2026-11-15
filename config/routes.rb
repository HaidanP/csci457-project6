#Haidan Parajuli csci 457

Rails.application.routes.draw do
  #member route so the url carries the source movie id, gives us similar_movie_path
  resources :movies do
    member do
      get :similar
    end
  end
  root to: redirect("/movies")
  get "up" => "rails/health#show", as: :rails_health_check
end
