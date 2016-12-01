require 'sqlite3'
require 'sinatra'
require 'slim'
require 'rack'
require 'rake'
require 'hash_dot'
require 'dotenv'
require 'faker'
require 'pony'
require 'letter_opener'
# используем все необходимые гемы, подробное описание есть в Gemfile

# в блоке before используется код, который будет выполнен ДО того как будет обработан
# любой роут соответственно глобальные переменные лучше всего задавать именно тут
before do
  @hello = "Привет, мир!"
end

# собственно, корневой роут, который отдается при запуске приложения
get '/' do
  slim  :index,                           # задаем индексную страницу и указываем шаблонизатор
        :layout => :application,          # указываем через какой лэйаут она пройдет
        :locals => {:hello => @hello}     # задаем локальные переменные
end
