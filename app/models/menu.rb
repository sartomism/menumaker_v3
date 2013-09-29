class Menu < ActiveRecord::Base
  
  before_destroy :borrar_dependientes
  
  def dias
    recetas=Recetamenu.find(:all,:conditions => "menu = "+self.id.to_s)
    dias=recetas.map {|r| r.dia }.uniq.size
    return dias
  end
  
  def borrar_lista_compra
    Ingredientelista.delete_all("menu = "+self.id.to_s)
  end
  
  def cantidad_ingredientes_lista
    cantidad=Ingredientelista.find(:all,:conditions => "menu = "+self.id.to_s).size
    return cantidad
  end
  
  
private
  
  def borrar_dependientes
    Recetamenu.delete_all("menu = "+self.id.to_s)
    Ingredientelista.delete_all("menu = "+self.id.to_s)
  end
  
end
