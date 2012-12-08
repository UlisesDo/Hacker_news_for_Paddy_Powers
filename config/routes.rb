HackerNewsForPaddyPowers::Application.routes.draw do

  resources :items, only: [:create] do
    collection do
      get :welcome, :pull_HN_front_page
      post :send_HN_by_email
    end
  end
  
  root to: 'items#welcome'
  
end
