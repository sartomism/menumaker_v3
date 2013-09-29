class Platobloqueetiqueta < ActiveRecord::Base
 
 def esta_activo(platobloque2,etiqueta2)
    existen=Platobloqueetiqueta.find(:all,:conditions => "platobloque = "+platobloque2.to_s+" and etiqueta = "+etiqueta2.to_s)
    if existen.size == 0
      return false
    else
      return true
    end
  end

 def get_valor(platobloque2,etiqueta2)
    existen=Platobloqueetiqueta.find(:all,:conditions => "platobloque = "+platobloque2.to_s+" and etiqueta = "+etiqueta2.to_s)
    if (existen.size rescue 0)== 0
      return false
    else
      return existen.first
    end
  end
  
  
  def activar(platobloque2,etiqueta2,valor = 1)
    if self.esta_activo(platobloque2,etiqueta2) == false
      pbe=Platobloqueetiqueta.new
      pbe.platobloque=platobloque2
      pbe.etiqueta=etiqueta2
      pbe.valor=valor
      pbe.save
    else
      if self.get_valor(platobloque2,etiqueta2)!=valor
        self.desactivar(platobloque2,etiqueta2)
        pbe=Platobloqueetiqueta.new
        pbe.platobloque=platobloque2
        pbe.etiqueta=etiqueta2
        pbe.valor=valor
        pbe.save
      end
    end
  end

  def desactivar(platobloque2,etiqueta2)
    existen=Platobloqueetiqueta.find(:all,:conditions => "platobloque = "+platobloque2.to_s+" and etiqueta = "+etiqueta2.to_s)
    if existen.size > 0
      for e in existen
        e.destroy
      end
    end
  end

end
