module BloquecomidasHelper
  
  def get_descripcion_plato(pb)
    pbes=pb.get_etiquetas
    if pbes.size > 0
      desc=""
      for pbe in pbes
        etiqueta=Etiqueta.find(pbe.etiqueta)
        if pbe.valor == 0
          desc+="No "
        end
        desc+=etiqueta.nombre.capitalize
        if pbe!=pbes.last
          desc+=", "
        end
      end
    else
      desc="Cualquiera"
    end
    return desc
  end
  
end
