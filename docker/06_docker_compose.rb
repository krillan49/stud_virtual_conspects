puts '                                            Docker Compose'

# Docker Compose позволяет подключить к проету сразу множество образов, указывать связь между ними и добавлять к ним характеристики и настройки. Например, можно подключить языки Джава, Python, C++, PHP и к ним дополнительно настроить сервера, среды разработки и все это в одном файле.

# docker-compose.yml - файл, в котором можно указать описание образов которые будут подключены, какие у них будут характеристики, возможности итд. При запуске проэкта эти образы будут либо скачаны либо сразу запущены.

# В Докер Хабе на странице образа внизу есть описание для фаила docker-compose.yml его содержание можно просто скопировать в свой фаил docker-compose.yml. Так же там ниже есть список всех переменных которые можно дописать дополнительно(например изменение логина, хоста итд)

# При построении файла Compose нужно указать сервисы(выполняют роль образов) и их характеристики.

# files/docker-compose.yml   - пример фаила docker-compose.yml с кодом, где описано 2 сервиса: 1й с образом с СУБД mariadb:10.3 и 2й с образом графического интерфейса phpmyadmin



puts '                                       Сборка и спользование образа'

# > docker-compose build       - сборка проекта из всех сервисов фаила докеркомпост.

# > docker-compose up          - запуск собранного проекта(тоесть запускает все сервисы), а так же предварительное скачивание и установка тех образов которых нет в наличии.
# Теперь мы находимся в режиме работы приложения в консоли
# localhost:8080 - Далее заходим в указаный в docker-compose.yml порт(тут 8080) через браузер. Получаем панель входа phpmyadmin(имя пользователя по умолчанию root, пароль тот, кторый мы указали в докеркомпост фаиле) и мы в приложении

# Ctrl + C                         - выход из режима работы приложения в консоли

# > docker-compose down            - остановить все сервисы (останавливая ваш проект)



puts '                                   Модификация и добавление нового сервиса'

# (Тут изменения будут files/docker-compose(mod).yml льносительно старого files/docker-compose.yml)

# 1. Модифицируем сервис:
# Можно в этом сервисе поменять образ mariadb:10.3 на образ mysql вместо копирования из хаба кода для mysql (тк там вместо phpmyadmin указан другой графический интерфейс) для этого просто заменим имя образа в разделе image: в docker-compose
# Можно поменять и другие данные, например пароль на MYSQL_ROOT_PASSWORD: 12345
# Но стоит обратить внимание на наличие в коде хаба команд "comand"(аналог CMD из докерфаила) и добавить ее(тк она исполняется при каждом запуске):
# command: --default-authentication-plugin=mysql_native_password   (тут это плагин для авторизации)


# 2. Добавление нового сервиса:
# Можно написать код для него так же как и для двух сервисов выше, а можно использовать отдельный Dockerfile например наш докерфаил с php


# Снова выполняем команды
# > docker-compose build
# > docker-compose up
# Опять заходим на наш локалхост уже в 2х вкладках в разных портах для разных сервисов и получаем новый вариант сборки














#
