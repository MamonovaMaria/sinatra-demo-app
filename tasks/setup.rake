namespace :hello do

  desc "Здороваемся с Васей"
  task :vasya do
    name = "Вася"
    puts "Привет, #{name}"
  end

  desc "Здороваемся с Петей"
  task :petya do
    name = "Петя"
    puts "Привет, #{name}"
  end

end

namespace :bye do

  desc "Прощаемся с Васей"
  task :vasya do
    name = "Вася"
    puts "Пока, #{name}"
  end

  desc "Прощаемся с Петей"
  task :petya do
    name = "Петя"
    puts "Пока, #{name}"
  end

end

desc "Вася"
task :vasya do
  name = "Вася"
  puts name
end

desc "Петя"
task :petya do
  name = "Петя"
  puts name
end
