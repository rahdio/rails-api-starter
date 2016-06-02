Rails.application.routes.draw do
  def api_version_handler(version, &routes_block)
    namespace "v#{version}".to_sym, path: "", &routes_block
  end

  namespace :api, path: "" do
    api_version_handler "1" do
      scope "auth" do
        post "login" => "sessions#login"
        get "logout" => "sessions#logout"
      end

      scope "users" do
        post "new" => "users#create"
      end
    end
  end
end
