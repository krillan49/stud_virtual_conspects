puts '                                        Docker Compose'

# Docker Compose - представляет из себя отдельный файл, в котором можно указать какие образы будут подключены, какие у них будут характеристики, возможности итд.

# Преимуществом Docker Compose является возможность подключения сразу многих образов. Например, можно подключить языки Джава, Python, C++, PHP и к ним дополнительно настроить сервера, среды разработки и все это в одном файле.

# При построении файла Compose нужно указать сервисы(выполняют роль образов) и их характеристики.

# docker-compose.yml - название фаила докер компоста всегда должно быть такое. В этом фаиле можно написать описания различных образов и при запуске проэкта они будут либо скачаны либо сразу запущены.

# Пример: В хабе ищем phpmyadmin и внизу есть описание для фаила docker-compose.yml содержание можно просто скопировать в свой фаил докеркомпоста. Так же там ниже есть список всех переменных которые можно дописать дополнительно(например изменение логина хоста итд)

# docker/docker-compose.yml   - тут пример фаила docker-compose.yml с кодом. Описано 2 сервиса(образа) 1й управление базами данных mariadb:10.3 и 2й графический интерфейс phpmyadmin

# > docker-compose build           - сборка образа/проекта из фаила докеркомпост. Не производит запуск только сборка
# > docker-compose up              - запуск собранного образа, а так же предварительное скачивание и установка тех образов которых нет в наличии
# Теперь мы находимся в режиме работы приложения в консоли
# localhost:8080 - Далее заходим в указаный в фаиле порт(тут 8080) через браузер. Получаем панель входа(имя пользователя по умолчанию root, пароль кторый мы указали в докеркомпост фаиле) и мы в приложении
# Ctrl + c   -выход из режима работы приложения в консоли
# > docker-compose down            - остановить собранный образ


# Изменение сервиса:
# Можно в этом образе поменять mariadb:10.3 на mysql вместо копирования из хаба кода для mysql тк там вместо phpmyadmin указан другой графич интерфейс
# image: mysql - просто меняем на mysql значение характеристики image в docker-compose.yml
# можно поменять и другие данные например пароль на MYSQL_ROOT_PASSWORD: 12345
# Но стоит обратить внимание на наличие в коде хаба команд comand(аналог CMD) и добавить ее(тк она исполняется при каждом запуске):
# command: --default-authentication-plugin=mysql_native_password   (тут это плагин для авторизации)

# Снова выполняем команды
# > docker-compose build
# > docker-compose up
# опять заходим на наш локалхост и получаем новый вариант сборки


# Добавление сервиса:
# Можно написать код для него тк для двух сервисов выше а можно использовать отдельный докерфаил например на докерфаил с php
# docker/docker-compose.yml   - тут пример














# 
