Rails.application.routes.draw do
  def api_version_handler(version, &routes_block)
    namespace "v#{version}".to_sym, path: "", &routes_block
  end

  namespace :api, path: "" do
    api_version_handler "1" do
      resources :sessions, only: [:create] do
        delete '/', on: :collection, action: 'destroy'
      end
      resources :users, only: [:create]
    end
  end
end
