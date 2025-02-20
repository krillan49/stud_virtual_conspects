# Используем официальный образ Ruby
FROM ruby:3.2

# Устанавливаем зависимости для работы с Rails (Node.js)
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Устанавливаем зависимые библиотеки
RUN gem install bundler

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем Gemfile и Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Устанавливаем гемы
RUN bundle install

# Копируем все файлы приложения
COPY . .

# Прокладываем порт, который будет использоваться
EXPOSE 3000

# Команда для запуска приложения
CMD ["rails", "server", "-b", "0.0.0.0"]
