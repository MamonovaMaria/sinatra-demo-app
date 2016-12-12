# в этом файле мы через транзакции последовательно заполняем БД случайными данными

# подключаем гем фейкер
require 'faker'

DB.transaction do

  DB[:settings].insert( {
    :site_name => Faker::Company.name ,
    :site_title => "#{Faker::Company.name} #{Faker::Company.suffix} official website" ,
    :site_description => Faker::Company.catch_phrase ,
    :site_keywords => Faker::Company.bs
  } )

  5.times do |n|
    DB[:pages].insert( {
      :page_url => "page_#{n + 1}" ,
      :page_title => "Page #{n + 1} | #{Faker::Company.name} #{Faker::Company.suffix} official website" ,
      :page_description => Faker::Company.catch_phrase ,
      :page_keywords => Faker::Company.bs ,
      :page_content => Faker::Lorem.paragraph(20)
    } )
  end

  DB[:settings].insert( {
    :logo_url => Faker::Company.logo
  } )

end
