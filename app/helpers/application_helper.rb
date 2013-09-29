# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def get_receta_menu(menu,dia,platobloque)
    puts menu.to_s
    puts dia.to_s
    puts platobloque.to_s
    puts "---"
    menureceta=Recetamenu.find(:first,:conditions => "menu = "+menu.to_s+" and dia = "+dia.to_s+" and platobloque = "+platobloque.to_s)
    receta=(Receta.find(menureceta.receta) rescue nil)
    return receta
  end
  
  def get_recetamenu(menu,dia,platobloque)
    recetamenu=Recetamenu.find(:first,:conditions => "menu = "+menu.to_s+" and dia = "+dia.to_s+" and platobloque = "+platobloque.to_s)
    return recetamenu
  end

  def get_paginas(ingredientes,ingredientes_por_pagina)
    
    listado_links=[]
    
    i=0
    while i<ingredientes.size do
      iinicial=ingredientes[i]
      if (i+ingredientes_por_pagina)>=ingredientes.size
        ifinal=ingredientes.last
      else
        ifinal=ingredientes[i+ingredientes_por_pagina-1]
      end
      listado_links << iinicial.nombre.capitalize[0].chr+"-"+ifinal.nombre.capitalize[0].chr

      i+=ingredientes_por_pagina
    end
    
    return listado_links    
  end
    
end
