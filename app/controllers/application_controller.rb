class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
		# allow user to change below
		devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email])

	end
end
