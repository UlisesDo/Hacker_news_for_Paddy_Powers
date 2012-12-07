HackerNewsForPaddyPowers::Application.routes.draw do

  resources :items, only: [:create, :destroy] do
    collection do
      get :welcome, :pull_HN_front_page
    end
  end
  
  root to: 'items#welcome'
  
end
