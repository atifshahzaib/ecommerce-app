# frozen_string_literal: true

module DeviseParams
  extend ActiveSupport::Concern

  included do
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |u|
        u.permit(:full_name, :email, :password, :image)
      end

      devise_parameter_sanitizer.permit(:account_update) do |u|
        u.permit(:full_name, :email, :password, :current_password, :image)
      end
    end
  end
end
