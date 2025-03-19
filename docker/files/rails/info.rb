puts "                                                Rails"

# https://lamphanqg.github.io/2019/01/20/dockerized-capybara.html

# https://dev.to/amree/introduction-to-ruby-on-rails-and-dockerfile-5a29
# https://dev.to/amree/ruby-on-rails-development-using-docker-o1d
# https://dev.to/amree/ruby-on-rails-and-docker-for-testing-4n8a

# https://nicolasiensen.github.io/2022-03-11-running-rails-system-tests-with-docker/

# https://dev.to/hint/rails-system-tests-in-docker-4cj1

# https://gist.github.com/nav-mike/660712caebe6f6173e067781427d9025  - Использование docker compose с rails + postgresql



puts "                                    Проект на Rails 8 (silver-palm-tree)"

# https://github.com/krillan49/silver-palm-tree/tree/a%23docker_add

# Dockerfile.dev
# docker_compose.dev
# capybara.rb
# rails_helper.rb
# README.md

# Весь проект норм работает в контейнере, но тесты идут медленно и несколько тестов Сapybara не проходит, хотя локально все проходят (после одного теста точно такой же не проходит, не видит поля формы, хз где проблема в Хотвайр или настройках Капибары)



puts "                                      Проект на Rails 8 (от чатбота)"

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










#
