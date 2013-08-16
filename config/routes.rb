MusicLibrary::Application.routes.draw do
  root to: 'homepage#index'
  resources :albums
end
