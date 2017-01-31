require 'sequel'
require 'sqlite3'
require 'sinatra'
require 'slim'
require 'rack'
require 'rake'
require 'hash_dot'
require 'dotenv'
require 'pony'
require 'letter_opener'
# используем все необходимые гемы, подробное описание есть в Gemfile

# задаем БД
DB = Sequel.connect("sqlite://#{YAML.load_file("config/database.yml").to_dot.db_file_path}")

# в блоке helpers задаются методы-помощники Синатры, которые могут быть использованы
# везде, в том числе за пределами роутов, например во вьюхах
helpers do
  # метод, собственно проверяющий авторизован ли пользователь и если нет, выдающий 401
  # восклицательный знак в конце имени метода обычно обозначает т.н. "Опасный метод",
  # то есть метод, меняющий объект на который он воздействует, что в нашем случае
  # означает что мы вместо объекта страницы отдаем ошибку и подменяем заголовок запроса
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  # метод, присваивающий авторизацию через Rack с заданными значениями логин/пароль
  # методы, оканчивающиеся на вопросительный знак в имени обычно возвращают только значения true/false
  def authorized?
    @secrets = YAML.load_file("config/secrets.yml").to_dot
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == %W(#{@secrets.auth.login} #{@secrets.auth.pass})
  end
end

# в блоке before используется код, который будет выполнен ДО того как будет обработан
# любой роут соответственно глобальные переменные лучше всего задавать именно тут
before do
  # выводим параметры запроса для каждого запроса в целях дебага
  p params
  @global_settings = DB[:settings].first.to_dot
  @pages = DB[:pages]
  @published_pages = @pages.where(published: true).all
end

# собственно, корневой роут, который отдается при запуске приложения
get '/' do
  slim  :index,                                 # задаем индексную страницу и указываем шаблонизатор
        :layout => "layouts/app".to_sym,        # указываем через какой лэйаут она пройдет
        :locals => {:hello => "Привет, мир!"}   # задаем локальные переменные
end

# роут для админки, закрытый на базовыю HTTP-авторизацию средствами Rack
get '/admin' do
  # через этот метод закрываем роут на HTTP-авторизацию
  protected!
  slim  :dashboard,
        :layout => "layouts/admin".to_sym
end

post '/admin/destroy' do
  protected!

  @pages.where(id: params[:destroy]).delete

  redirect '/admin'
end

get '/admin/new' do
  protected!

  slim  :new_page,
        :layout => "layouts/admin".to_sym
end

post '/admin/new' do
  protected!

  @pages.insert( {
    :page_url => params[:page_url] ,
    :page_title => params[:page_title] ,
    :page_description => params[:page_description] ,
    :page_keywords => params[:page_keywords] ,
    :page_content => params[:page_content] ,
    :published => params[:published] || false ,
    :parent_id => if params[:parent_id].to_s.length > 0 then params[:parent_id].to_i else nil end
  } )

  redirect '/admin'
end

get '/admin/edit/:id' do
  protected!

  @page = @pages.where(id: params[:id]).first

  slim  :edit_page,
        :layout => "layouts/admin".to_sym
end

post '/admin/edit/:id' do
  protected!

  @pages.where(id: params[:id]).update( {
    :page_url => params[:page_url] ,
    :page_title => params[:page_title] ,
    :page_description => params[:page_description] ,
    :page_keywords => params[:page_keywords] ,
    :page_content => params[:page_content] ,
    :published => params[:published] || false ,
    :parent_id => if params[:parent_id].to_s.length > 0 then params[:parent_id].to_i else nil end
  } )

  redirect '/admin'
end

# роут для отображения отдельных страниц
get '/:page_url' do
  @page = @pages.where(page_url: params[:page_url]).first
  slim  :page,
        :layout => "layouts/app".to_sym
end
