RepoDeployer::Application.routes.draw do
  root 'repos#index'
  resources :repos do
    resources :builds
    collection do
      post :add_github_repo
      get  :github
      post :github_hook
    end
  end
  get  'auth/:provider/callback' => 'sessions#create'
  post 'auth/:provider/callback' => 'sessions#create'
  get  'logout' => 'sessions#destroy'
end
