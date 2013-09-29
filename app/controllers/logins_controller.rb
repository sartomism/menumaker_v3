class LoginsController < ApplicationController
  
  def index
    @sesion=get_session_data
  end

  
  def login_user
    login=params[:login][:login]
    password=params[:login][:password]
    
    if login.size == 0 || password.size == 0
      @error="Login Incorrecto"
      render :action => "index"
    else    
      @error=nil   
      users=User.find(:all,:conditions => "login = '"+login.to_s+"' and status = 'active'")
      
      if users.size > 0 and users[0].password == password
        @sesion=get_session_data
        user=users[0]
        #user=User.new
        #user.login=login
        #user.password=password
        @sesion.set_user(user)
        @sesion=get_session_data
        render :action => "index"
      else
        @error="Login Incorrecto"
        #@login = login
        render :action => "index"
      end
    end
   
  end

  def logout
    @sesion=get_session_data
    @sesion.set_user(nil)
    render :action => "index"
  end

  def check_email(str)
    if str.index("@") == nil or str.size < 3
      return false
    else
      return true
    end
  end

  def get_new_user(login,password,password2,email)
    if password.size < 6
      @error ="La constraseña debe contener al menos 6 carácteres"
      return nil
    end

    if password != password2
      @error ="Las constraseñas no coinciden!"
      return nil
    end
            
    users=User.find(:all,:conditions =>"login = '"+login+"'")
    if users.size > 0
      @error ="El usuario '"+login+"' ya ha sido registrado."
      return nil
    end
    
    if check_email(email) == false
      @error ="El email es incorrecto."
      return nil
    end
    
    u=User.new
    u.status="active" 
    u.accounttype="free"
    
    u.login=login
    u.password=password
    u.mail=email
    
    return u
  end

  def signup
        @login = ""
  end

  def new_user
    @login=params[:newlogin][:login]
    @password=params[:newlogin][:password]
    @password2=params[:newlogin][:password2]
    @email=params[:newlogin][:email]
    
    @u=get_new_user(@login,@password,@password2,@email)

    if @u==nil
      if @error == nil 
        @error="Imposible crear nuevo usuario"
      end
      render :action => "error_at_signup"
    else
      if @u.save
        render :action => "success_at_signup"
      else
        @error="Imposible crear nuevo usuario"
        render :action => "error_at_signup"
      end
    end    
  end
  
end


