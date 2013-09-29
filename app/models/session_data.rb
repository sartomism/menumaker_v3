  
class Session_data

  attr_reader :user
  
  # Descripcion:
  # * Inicializa los valores por defecto de una sesion
  # Tipo de Llamada:
  # * Método
  def initialize
    user = nil
    self.set_user(user)
  end

  def set_user(user)
    @user = user
  end
  
  def get_user
    return @user
  end

end