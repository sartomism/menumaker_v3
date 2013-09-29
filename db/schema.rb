# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130408102542) do

  create_table "bloquecomidas", :force => true do |t|
    t.string   "nombre"
    t.integer  "orden"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario"
    t.integer  "dia"
    t.integer  "menulayout"
    t.integer  "personas"
  end

  create_table "etiquetaings", :force => true do |t|
    t.integer  "usuario"
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "etiquetarecetas", :force => true do |t|
    t.integer  "etiqueta"
    t.integer  "receta"
    t.integer  "usuario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "etiquetas", :force => true do |t|
    t.integer  "usuario"
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredientelistas", :force => true do |t|
    t.string   "ingrediente"
    t.string   "unidad"
    t.float    "cantidad"
    t.integer  "menu"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tipo"
  end

  create_table "ingredientes", :force => true do |t|
    t.string   "nombre"
    t.integer  "unidadmedia"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario"
    t.integer  "tipo"
  end

  create_table "ingredientesrecetas", :force => true do |t|
    t.integer  "receta"
    t.integer  "ingrediente"
    t.float    "cantidad"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menulayouts", :force => true do |t|
    t.string   "nombre"
    t.integer  "usuario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", :force => true do |t|
    t.integer  "usuario"
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packs", :force => true do |t|
    t.integer  "ingrediente"
    t.float    "cantidad"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "platobloqueetiquetas", :force => true do |t|
    t.integer  "platobloque"
    t.integer  "etiqueta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "valor"
  end

  create_table "platobloques", :force => true do |t|
    t.integer  "bloque"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "personas"
  end

  create_table "platorecetas", :force => true do |t|
    t.integer  "receta"
    t.integer  "plato"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "platos", :force => true do |t|
    t.integer  "usuario"
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recetamenus", :force => true do |t|
    t.integer  "platobloque"
    t.integer  "receta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "menu"
    t.integer  "dia"
    t.integer  "bloque"
    t.integer  "orden"
    t.string   "nombrebloque"
    t.integer  "personas"
  end

  create_table "recetas", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario"
    t.datetime "ultimouso"
    t.integer  "personas"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "unidadmedidaingredientes", :force => true do |t|
    t.integer  "ingrediente"
    t.integer  "unidadmedida"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unidadmedidas", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password"
    t.string   "mail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "accounttype"
  end

end
