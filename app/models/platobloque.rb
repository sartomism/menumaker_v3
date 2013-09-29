class Platobloque < ActiveRecord::Base
  
  before_destroy :borrar_dependientes
  
  def condicion_basica
    return "usuario = "+usuario_actual.to_s
  end
  
  def usuario_actual
    #sesion=get_session_data
    #return sesion.user.id

    bloque=Bloquecomida.find(self.bloque)

    return bloque.usuario
  end
  
  
  def get_etiquetas
    etiquetas=Platobloqueetiqueta.find(:all,:conditions => "platobloque = "+self.id.to_s)
    return etiquetas
  end


  
  def get_recetas
    etiquetas=self.get_etiquetas
    recetas=Receta.find(:all,:conditions => condicion_basica,:order => "ultimouso")
    
    ret=[]

     puts self.id.to_s
    
    for receta in recetas
      valida = true
      etiquetas_receta=Etiquetareceta.find(:all,:conditions => "receta = "+receta.id.to_s)
      valida_temporal2 = true
      for etiqueta in etiquetas
        valida_temporal = true
        #que tenga etiqueta
        if etiqueta.valor == 1
          valida_temporal = false
          for etiqueta_receta in etiquetas_receta
            if etiqueta.etiqueta == etiqueta_receta.etiqueta
              valida_temporal = true
            end
          end
        end
        #que no tenga etiqueta
        if etiqueta.valor == 0
          valida_temporal = true
          for etiqueta_receta in etiquetas_receta
            if etiqueta.etiqueta == etiqueta_receta.etiqueta
              valida_temporal = false
            end
          end
        end
        valida_temporal2 = (valida_temporal2 and valida_temporal)
      end
      valida = (valida and valida_temporal2)
      if valida
        ret << receta
        puts receta.nombre+" << pa la saca!"
      end
    end
    return ret
  end
  
  
private
  
  def borrar_dependientes
    pbes=Platobloqueetiqueta.find(:all,:conditions => "platobloque = "+self.id.to_s)
    
    for pbe in pbes
      pbe.destroy
    end
  end
  
end
