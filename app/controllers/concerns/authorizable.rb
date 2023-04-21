# frozen_string_literal: true

module Authorizable
  extend ActiveSupport::Concern

  included do
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    root_path
  end
end
