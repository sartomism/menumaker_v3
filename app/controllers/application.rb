# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  helper_method :usuario_actual # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => 'f0fa52418c540b3a325cab4bd22d53e3'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  #################################################################################################
  # Descripcion
  #################################################################################################
  # Parametros
  #################################################################################################
  def condicion_basica
    return "usuario = "+usuario_actual.to_s
  end
  
  def usuario_actual
    sesion=get_session_data
    return sesion.user.id
  end

  def get_session_data
    return session[:session_data] ||= Session_data.new
  end


end
