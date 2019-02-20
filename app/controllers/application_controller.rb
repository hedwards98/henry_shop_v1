class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :categories
	before_action :brands
	helper_method :current_order

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :role])
		# allow user to change below
		devise_parameter_sanitizer.permit(:account_update, keys: [:email, :name, :role])
	end

	def categories
		@categories = Category.all
	end

	def brands
		@brands = Product.pluck(:brand).uniq
	end

	def current_order
		if session[:order_id].nil? == false
			return Order.find(session[:order_id])
		else
			return Order.new
	end

	rescue_from CanCan::AccessDenied do |exception|
		respond_to do |format|
			format.json { head :forbidden }
			format.html { redirect_to main_app.product_url, alert: "Not Authorized" }
		end
	end
	
end
end
