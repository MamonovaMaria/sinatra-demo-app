require 'sinatra'

before do
@db = ['первый','второй','третий','четвертый','пятый','шестой']
@hello = "Здравствуйте, ребята!"
end

get '/:url' do
  html = "<h2>Заголовок</h2>"
  erb :index, :layout => :default, :locals => {:hello => @hello, :counter => @db, :html => html}
end

get '/new' do
  erb :new, :layout => :default, :locals => {:hello => @hello, :counter => @db}
end
