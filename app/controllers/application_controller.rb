class ApplicationController < ActionController::Base
      def index
    @employees = Employee.all
  end
end
