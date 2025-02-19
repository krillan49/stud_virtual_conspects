puts "                                          Проект на Rails 8"

# 1. Создайте новый Rails проект (если еще не создан):
# $ rails new myapp --database=postgresql
# $ cd myapp

# 2. Выполните `bundle install`, создав зависимости в Gemfile.lock

# 3. (?? Только для версии с Постгесс) Настройте базу данных в файле `config/database.yml` (тут просто database.yml) обновите конфигурацию для соответствия вашему docker-compose.yml:

# 4. Необходимо установить Node.js, который включен в `Dockerfile`

# 5. Соберите и запустите контейнеры (приложение):
# $ docker-compose up --build
# Либо
# $ docker-compose build
# $ docker-compose up


# 6. Создайте базу данных (?? Постгре ??):
# $ docker-compose exec web rails db:create
# Либо выполнить миграции базы данных
# $ docker-compose run web rails db:migrate

# 7. Открыть приложени по адресу http://localhost:3000