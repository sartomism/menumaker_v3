class Bloquecomida < ActiveRecord::Base
    before_destroy :borrar_dependientes
    
    
    
private

  
  
  def borrar_dependientes
    pbs=Platobloque.find(:all,:conditions => "bloque = "+self.id.to_s)
    
    for pb in pbs
      pb.destroy
    end
  end

end
