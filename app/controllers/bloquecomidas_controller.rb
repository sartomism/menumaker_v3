class BloquecomidasController < ApplicationController
  # GET /bloquecomidas
  # GET /bloquecomidas.xml
  def index
    @dia_actual = 1
    @layout = 1
    @bloquecomidas = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s+" and dia = "+@dia_actual.to_s,:order => "orden")
    @etiquetas=Etiqueta.find(:all,:conditions => condicion_basica)
    @dias = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s,:order => "dia,orden").map {|b| b.dia.to_s}.uniq
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bloquecomidas }
    end
  end

  # GET /bloquecomidas/1
  # GET /bloquecomidas/1.xml
  def show
    @bloquecomida = Bloquecomida.find(params[:id])
  end

  # GET /bloquecomidas/new
  # GET /bloquecomidas/new.xml
  def new
    @bloquecomida = Bloquecomida.new

    last=Bloquecomida.find(:last,:order => "orden")
    
    @bloquecomida.orden = last.orden+1 
    @bloquecomida.usuario = usuario_actual
  end

  # GET /bloquecomidas/1/edit
  def edit
    @bloquecomida = Bloquecomida.find(params[:id])
  end

  # POST /bloquecomidas
  # POST /bloquecomidas.xml
  def create
    @bloquecomida = Bloquecomida.new(params[:bloquecomida])

    respond_to do |format|
      if @bloquecomida.save
        flash[:notice] = 'Bloquecomida was successfully created.'
        format.html { redirect_to(@bloquecomida) }
        format.xml  { render :xml => @bloquecomida, :status => :created, :location => @bloquecomida }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bloquecomida.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bloquecomidas/1
  # PUT /bloquecomidas/1.xml
  def update
    @bloquecomida = Bloquecomida.find(params[:id])

    respond_to do |format|
      if @bloquecomida.update_attributes(params[:bloquecomida])
        flash[:notice] = 'Bloquecomida was successfully updated.'
        format.html { redirect_to(@bloquecomida) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bloquecomida.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bloquecomidas/1
  # DELETE /bloquecomidas/1.xml
  def destroy
    @bloquecomida = Bloquecomida.find(params[:id])
    @bloquecomida.destroy

    respond_to do |format|
      format.html { redirect_to(bloquecomidas_url) }
      format.xml  { head :ok }
    end
  end

  def eliminar_bloquecomida
    pb=Platobloque.find(params[:bloquecomida])
    pb.destroy
    redirect_to :action => "index"
  end


  def swap_bloquecomida
    bq=Bloquecomida.find(params[:bloquecomida].to_i)
    bqs=Bloquecomida.find(:all,:conditions => condicion_basica+" and orden < "+bq.orden.to_s+" and dia = "+bq.dia.to_s,:order => "orden desc")


    swap=bqs.first
    old=bq.orden
    bq.orden=swap.orden
    swap.orden=old

    swap.save
    bq.save
      
     @dia_actual = bq.dia
     @layout=bq.menulayout
     @dias = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s,:order => "dia,orden").map {|b| b.dia.to_s}.uniq
     @bloquecomidas = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s+" and dia = "+@dia_actual.to_s,:order => "orden")
     @etiquetas=Etiqueta.find(:all,:conditions => condicion_basica)
     
    
  render(:partial => "bloquecomida_dia_visualizar",
    :locals => {
      :bloquecomidas => @bloquecomidas,
      :dias => @dias,
      :dia_actual => @dia_actual,
      :layout => @layout })  
 end

  def borrar_bloquecomida
    bq=Bloquecomida.find(params[:bloquecomida].to_i)
    bq.destroy
      
     @dia_actual = bq.dia
     @layout=bq.menulayout
     @dias = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s,:order => "dia,orden").map {|b| b.dia.to_s}.uniq
     @bloquecomidas = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s+" and dia = "+@dia_actual.to_s,:order => "orden")
     @etiquetas=Etiqueta.find(:all,:conditions => condicion_basica)
     
    
  render(:partial => "bloquecomida_dia_visualizar",
    :locals => {
      :bloquecomidas => @bloquecomidas,
      :dias => @dias,
      :dia_actual => @dia_actual,
      :layout => @layout })  
 end

  def nuevoplato_bloquecomida
    bq=Bloquecomida.find(params[:bloquecomida].to_i)
      
      pb=Platobloque.new
      pb.bloque=bq.id
      pb.save
      
     @dia_actual = bq.dia
     @layout=bq.menulayout
     @dias = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s,:order => "dia,orden").map {|b| b.dia.to_s}.uniq
     @bloquecomidas = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s+" and dia = "+@dia_actual.to_s,:order => "orden")
     @etiquetas=Etiqueta.find(:all,:conditions => condicion_basica)
     
    
  render(:partial => "bloquecomida_dia_visualizar",
    :locals => {
      :bloquecomidas => @bloquecomidas,
      :dias => @dias,
      :dia_actual => @dia_actual,
      :layout => @layout })  
 end
  
 
  def modificar_bloquecomidaetiquetas
    
    pb=Platobloque.find(params[:bloquecomida][:platobloque].to_i)
    etiquetas=Etiqueta.find(:all,:conditions => condicion_basica)
    pbe=Platobloqueetiqueta.new
    accion=params[:bloquecomida]["accion_"+pb.id.to_s].to_i
    if accion == 0 or accion== 1
      personas=params[:bloquecomida][:personas].to_i
      if personas < 1
        personas = 1
      end
      pb.personas=personas
      pb.save
      for e in etiquetas
        dato="bloque_"+pb.id.to_s+"_"+e.id.to_s
        estado=params[:bloquecomida][dato].to_i
        if estado == 1
          valor="valor_"+pb.id.to_s+"_"+e.id.to_s
          valor=params[:bloquecomida][valor].to_i
          pbe.activar(pb.id,e.id,valor)
        else  
          pbe.desactivar(pb.id,e.id)
        end
      end
    end
    if accion == 0
      render(:partial => "plato_editar",:locals => {:platobloque => pb,:etiquetas => etiquetas})
    else
      render(:partial => "plato_visualizar",:locals => {:platobloque => pb})
    end
  end




  def borrar_editar_bloquecomida
    
     pb=Platobloque.find(params[:platobloque].to_i)
     bq=Bloquecomida.find(pb.bloque)
     etiquetas=Etiqueta.find(:all,:conditions => condicion_basica)

     @dia_actual = bq.dia
     @layout=bq.menulayout
     @dias = ["Lunes","Martes","MIercoles"]
     @dias = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s,:order => "dia,orden").map {|b| b.dia.to_s}.uniq
     @bloquecomidas = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s+" and dia = "+@dia_actual.to_s,:order => "orden")
     @etiquetas=Etiqueta.find(:all,:conditions => condicion_basica)

     pb.destroy
         
    render(:partial => "bloquecomida_dia_visualizar",
      :locals => {
        :bloquecomidas => @bloquecomidas,
        :dias => @dias,
        :dia_actual => @dia_actual,
        :layout => @layout })  
  end


  def editar_editar_bloquecomida
    
    pb=Platobloque.find(params[:platobloque].to_i)
    etiquetas=Etiqueta.find(:all,:conditions => condicion_basica)


    render(:partial => "plato_editar",:locals => {:platobloque => pb,:etiquetas => etiquetas})
  end

  def editar_bloque
    bloque=Bloquecomida.find(params[:bloquecomida].to_i)
    render(:partial => "bloquecomida_editar",:locals => {:bloquecomida => bloque})
  end

  def guardar_bloque
    bloque=Bloquecomida.find(params[:bloque][:bloque].to_i)
    
    bloque.nombre=params[:bloque][:nombre]
    bloque.save
    
    render(:partial => "bloquecomida_visualizar",:locals => {:bloquecomida => bloque})
  end

  def nuevo_bloque
    bloque=Bloquecomida.new
    @layout = 1
    bloque.dia=params[:dia]
    bloque.menulayout=params[:layout]
    bloque.usuario=usuario_actual
    lastbq = Bloquecomida.find(:last,:conditions => condicion_basica+" and menulayout = "+@layout.to_s+" and dia = "+bloque.dia.to_s,:order => "orden")
    bloque.orden= (lastbq.orden+1 rescue 1)
    bloque.nombre="comida_"+bloque.orden.to_s
    bloque.save

    @dias = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s,:order => "dia,orden").map {|b| b.dia.to_s}.uniq
    @bloquecomidas = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s+" and dia = "+bloque.dia.to_s,:order => "orden")
    @etiquetas=Etiqueta.find(:all,:conditions => condicion_basica)
    @dia_actual = bloque.dia
    
  render(:partial => "bloquecomida_dia_visualizar",
    :locals => {
      :bloquecomidas => @bloquecomidas,
      :dias => @dias,
      :dia_actual => @dia_actual,
      :layout => @layout })  
    
  end

  def cambiar_dia
    @layout = params[:layout]
    @dia_actual = params[:dia].to_i
    @dias = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s,:order => "dia,orden").map {|b| b.dia.to_s}.uniq
    @bloquecomidas = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s+" and dia = "+@dia_actual.to_s,:order => "orden")
    @etiquetas=Etiqueta.find(:all,:conditions => condicion_basica)
    
  render(:partial => "bloquecomida_dia_visualizar",
    :locals => {
      :bloquecomidas => @bloquecomidas,
      :dias => @dias,
      :dia_actual => @dia_actual,
      :layout => @layout })  
    
  end

  def borrar_dia

    @layout = params[:layout]
    @dia_actual = params[:dia].to_i
    @bloquecomidas = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s+" and dia = "+@dia_actual.to_s,:order => "orden")

    for bq in @bloquecomidas
      bq.destroy
    end

    @dias = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s,:order => "dia,orden").map {|b| b.dia.to_s}.uniq
    @dia_actual=@dias.first.to_i
    @bloquecomidas = Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+@layout.to_s+" and dia = "+@dia_actual.to_s,:order => "orden")
    @etiquetas=Etiqueta.find(:all,:conditions => condicion_basica)
    
  render(:partial => "bloquecomida_dia_visualizar",
    :locals => {
      :bloquecomidas => @bloquecomidas,
      :dias => @dias,
      :dia_actual => @dia_actual,
      :layout => @layout })  
    
  end

  
  def listo_editar_bloquecomida
    
    pb=Platobloque.find(params[:platobloque].to_i)
    render(:partial => "plato_visualizar",:locals => {:platobloque => pb})
  end


  def generar_menu
    usuario=params[:generar_menu][:usuario]
    dias=params[:generar_menu][:dias].to_i
    
    ahora=DateTime.now
    
    #creamos un nuevo menu
    menu=Menu.new
    menu.usuario = usuario_actual
    menu.nombre=ahora.strftime("%d/%m/%Y %H:%M")
    menu.save

    layout=1
    dias_bloque=Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+layout.to_s).map {|bc| bc.dia }.uniq



    #para cada dia
    for dia in (1..dias)

      current_dia = dias_bloque[(dia-1)%dias_bloque.size]

      #obtengo los bloques de comida para cada día
      bloques=Bloquecomida.find(:all,:conditions => condicion_basica+" and menulayout = "+layout.to_s+" and dia = "+current_dia.to_s)
      
      platobloques=[]
  
      #obtengo los platos por cada bloque
      for bloque in bloques
        pb=Platobloque.find(:all,:conditions => "bloque = "+bloque.id.to_s)
        platobloques+=pb
      end
      
      #para cada platobloque busco su receta
      for pb in platobloques
        #creo una nueva receta para el menu
        recetamenu=Recetamenu.new

        bloque=Bloquecomida.find(pb.bloque)
  
        #lo asocio con el menu y el platobloque
        recetamenu.menu=menu.id
        recetamenu.platobloque=pb.id
        recetamenu.dia=dia
        recetamenu.bloque=bloque.id
        recetamenu.orden=bloque.orden
        recetamenu.nombrebloque=bloque.nombre
        if pb.personas.to_i < 1
          pb.personas = 1
          pb.save
        end
        recetamenu.personas=pb.personas
        #busco una receta
        recetas=pb.get_recetas
    
        if recetas.size > 0
          #la marco como usada
          recetas[0].ultimouso=DateTime.now
          
          recetamenu.receta=recetas[0].id
          recetamenu.save
          recetas[0].save
        end
      end
    end    
    redirect_to :action => "menus",:id => "ALL"
  end

  def menus
    
    @menus = Menu.find(:all,:conditions => condicion_basica,:order => "created_at desc")
    
  end
  
  def ver_recetas_menu
    @menu=Menu.find(params[:id].to_i)
    @dias=@menu.dias
    @bloques=Bloquecomida.find(:all,:conditions => condicion_basica,:order => "orden")
  end

  def eliminar_menu
    menu=Menu.find(params[:id].to_i)
    menu.destroy
    redirect_to :action => "menus",:id => "ALL"
  end
  
  def editar_recetamenu
    recetamenu=Recetamenu.find(params[:recetamenu])
    platobloque=Platobloque.find(recetamenu.platobloque)   
    
    menu=Menu.find(recetamenu.menu)
    cantidad_ingredientes = menu.cantidad_ingredientes_lista
    
    render(:partial => "recetamenu_editar",
          :locals => {
            :cantidad_ingredientes => cantidad_ingredientes,
            :recetamenu => recetamenu 
          }) 
  end

  def guardar_recetamenu
    recetamenu=Recetamenu.find(params[:recetamenu][:recetamenu])
    platobloque=Platobloque.find(recetamenu.platobloque)   

    recetamenu.personas=params[:recetamenu][:personas]
    recetamenu.save
    
    menu=Menu.find(recetamenu.menu)
    cantidad_ingredientes = menu.cantidad_ingredientes_lista
    
    render(:partial => "recetamenu_visualizar",
          :locals => {
            :cantidad_ingredientes => cantidad_ingredientes,
            :recetamenu => recetamenu 
          }) 
  end

  
  def recalcular_recetamenu

    recetamenu=Recetamenu.find(params[:id])
    platobloque=Platobloque.find(recetamenu.platobloque)   
    recetas=platobloque.get_recetas
    
    menu=Menu.find(recetamenu.menu)
    
    if recetas.size > 0
      #la marco como usada
      recetas[0].ultimouso=DateTime.now
      recetamenu.receta=recetas[0].id
      recetamenu.save
      recetas[0].save
    end

    cantidad_ingredientes = menu.cantidad_ingredientes_lista
    
    render(:partial => "recetamenu_visualizar",
          :locals => {
            :cantidad_ingredientes => cantidad_ingredientes,
            :recetamenu => recetamenu 
          }) 
  end

  def insertar_ingredientelista(lista,ingredientelista)
    sumado=false
    for i in lista
      if ingredientelista.ingrediente==i.ingrediente and ingredientelista.unidad==i.unidad
        sumado=true
        i.cantidad+=ingredientelista.cantidad
      end
    end
    if sumado==false
      lista << ingredientelista  
    end
    return lista  
  end

  def eliminar_lista_compra
    menu=Menu.find(params[:eliminar_lista_compra][:menu])
    menu.borrar_lista_compra
    redirect_to :action => "ver_recetas_menu",:id => menu.id
  end

  def ver_lista_compra
    menu=Menu.find(params[:ver_lista_compra][:menu])
    @ingredientes=Ingredientelista.find(:all,:conditions => "menu = "+menu.id.to_s,:order => "tipo,ingrediente,unidad")
  end


  def generar_lista_compra
    menu=Menu.find(params[:generar_lista_compra][:menu])

    menu.borrar_lista_compra
    
    recetamenus=Recetamenu.find(:all,:conditions => "menu = "+menu.id.to_s)

    lista=[]

    for recetamenu in recetamenus
      receta=Receta.find(recetamenu.receta)
      ingredientesreceta=receta.get_ingredientes
      for ingredientereceta in ingredientesreceta
        unidadmedidaingrediente=Unidadmedidaingrediente.find(ingredientereceta.ingrediente)
        ingrediente=Ingrediente.find(unidadmedidaingrediente.ingrediente)
        etiquetaing=Etiquetaing.find(ingrediente.tipo)
        unidadmedida=Unidadmedida.find(unidadmedidaingrediente.unidadmedida)
        cantidad=(ingredientereceta.cantidad*recetamenu.personas)/receta.personas
        
        ingredientelista=Ingredientelista.new
        ingredientelista.ingrediente=ingrediente.nombre
        ingredientelista.unidad=unidadmedida.nombre
        ingredientelista.cantidad=cantidad
        ingredientelista.tipo=etiquetaing.nombre
        ingredientelista.menu=menu.id

        lista=insertar_ingredientelista(lista,ingredientelista)

#        
#        existen=Ingredientelista.find(:all,:conditions => "menu = "+ingredientelista.menu.to_s+" and ingrediente = '"+ingredientelista.ingrediente+"' and unidad = '"+ingredientelista.unidad+"'")
#        
#        if existen.size > 0
#          existe=existen[0]
#          existe.cantidad+=ingredientelista.cantidad
#          existe.save
#        else
#          ingredientelista.save
#        end
      end
    end

    for l in lista
      l.save
    end
    
    redirect_to :action => "ver_recetas_menu",:id => menu.id

  end
  
end
