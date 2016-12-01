# Демо-приложение на Ruby/Sinatra

Демонстрационное приложение, написанное для примера фреймворка Sinatra и основных гемов, которые наиболее часто с ним используются для решения типовых задач.

Для запуска необходимы установленные в системе:
- ruby
- bundler
- sqlite3

## Установка зависимостей для OS X
```
brew install rbenv ruby-build
rbenv install 2.3.1
rbenv global 2.3.1
gem install bundler
brew install sqlite3
```

## Установка зависимостей для Debian/Ubuntu
```
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
rbenv install 2.3.1
rbenv global 2.3.1
gem install bundler
apt-get install sqlite3 libsqlite3-dev
```

В обоих случаях при установке не забываем добавлять инициализацию rbenv в профиль пользователя.

## Запуск приложения

Перед первым запуском не забываем делать bundle install

```
bundle exec ruby app.rb
```

По-умолчанию ваше приложение должно быть доступно по http://localhost:4567
