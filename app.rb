require 'sinatra'

before do
@db = ['первый','второй','третий','четвертый','пятый','шестой']
@hello = "Здравствуйте, ребята!"
end

get '/' do
  html = "<h2>Заголовок</h2>"
  slim :index, :layout => :application, :locals => {:hello => @hello, :counter => @db, :html => html}
end
