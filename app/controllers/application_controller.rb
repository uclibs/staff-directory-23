class ApplicationController < ActionController::Base
    before_action :config_devise_params, if: :devise_controller?
    ...  
    protected
      def config_devise_params
          devise_parameter_sanitizer.permit(:sign_up, keys: [ 
              :first_name,
              :last_name,
              :username,
              :email,
              :password,
              :password_confirmation
              ])
      end
      def index
    @employees = Employee.all
     #added below for devise
      layout :layout_by_resource
              
        private
         def layout_by_resource
             devise_controller? ? "session" : "application"
         end     
              
  end
end
