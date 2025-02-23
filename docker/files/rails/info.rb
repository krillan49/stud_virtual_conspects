puts "                                          Проект на Rails 8"

# ( !!! пройти  https://gist.github.com/nav-mike/660712caebe6f6173e067781427d9025)

# 1. Создайте новый Rails проект (если еще не создан):
# $ rails new myapp --database=postgresql
# $ cd myapp

# 2. Выполните `bundle install`, создав зависимости в Gemfile.lock

# 3. (?? Только для версии с Постгесс) Настройте базу данных в файле `config/database.yml` (тут просто database.yml) обновите конфигурацию для соответствия вашему docker-compose.yml:

# 4. Необходимо установить Node.js, который включен в `Dockerfile`

# 5. Соберите и запустите контейнеры (приложение):
# $ docker compose up --build

# 6. Создайте базу данных (?? Постгре ??):
# $ docker compose exec web rails db:create
# Либо выполнить миграции базы данных
# $ docker compose run web rails db:migrate
# web - имя сервиса в docker-compose.yml

# 7. Открыть приложени по адресу http://localhost:3000

# 8. Команды, которые могут использоваться для работы с rails-проектом, в котором используется docker. В качестве примера используется контейнер(сервис ??) web
# $ docker compose run web rake db:drop	           - Удалить базу данных проекта
# $ docker compose run web rake db:create	         - Создать базу данных проекта
# $ docker compose run web rake db:migrate	       - Запустить миграции
# $ docker compose run web rake db:seed	           - Заполнение базы данных сидами
# $ docker compose run web bundle	                 - Установка gem-ов. Эта команда добавит gem в Gemfile.lock. После этой команды нужно выполнить сборку контейнера
# $ docker compose run web rspec spec	             - Запуск тестов rspec
