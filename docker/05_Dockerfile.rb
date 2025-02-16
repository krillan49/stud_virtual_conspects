puts '                                             Dockerfile'

# Dockerfile (можно без расширений) - фаил содержит описание подключаемых образов, которые уже потом можно исполнить чтобы создать наш образ на их основе, например дополненный чем-то, чтобы не прописывать каждый раз команды в терминале

# Уже готовый вариант срдержания для Dockerfile есть на странице соответсвующего образа в Docker Hub, чтобы создать такой же самому, а не качать ??



puts '                                     Содерание и команды Dockerfile'

# Пример содержания Dockerfile для openjdk и PHP есть в /files

# Dockerfile состоит из разных нескольких команд, из них основные это:

# 1. FROM – указывает какой образ будет использован/скачен (например openjdk). Можно дополнительно указать версию образа (например :11), по умолчанию будет последняя версия. Можно после версии указать еще и сервер(например -apache)
# FROM php:7.2-apache                  - тоесть образ php версии 7.2, сервер apache

# 2. COPY – указывает какие файлы (по их местоположению) из вашего проекта будут скопированы на хост машину. Тоесть, указывает какие файлы будут выполнены за счет возможностей образа. Так мы еще связываем папку и фаилы с образом
# COPY .	/usr/src/myapp               - тут "." путь где будут находиться все фаилы (тут в текущей диретории, тоесть в той где находится Dockerfile, что логично, что весь проект находится там же), а "/usr/src/myapp" указывает в какую папку в нашем образе мы будем это помещать
# COPY . /var/www/html                 - либо можно указать адрес сервера, тоесть фалы скопируются сразу на сервер ???

# 3. WORKDIR – указывает рабочую директорию в образе, на хост машине (?? откуда будет исполнться код)
# WORKDIR /usr/src/myapp
# WORKDIR /var/www/html

# 4. EXPOSE – указывает порт для проекта. Будет работать в том случае, если в образе есть локальный сервер(локалхост)
# EXPOSE 80
# EXPOSE 8001

# 5. RUN – описывает команду, что выполнится один раз при создании образа (?? нужно указать фаилы из рабочей директории образа ??), например добавит в образ что либо (install apache2  и тд.)
# RUN	javac Main.java                  - запускаем компилятор Джавы javac и компилируем исполняемый фаил Main.java

# 6. CMD – описывает команду, что выполняется каждый раз при запуске контейнера (?? нужно указать фаилы из рабочей директории образа ??)
# CMD ["java", "Main"]                 - указываем что будем запускать скомпилированныйпри помощи RUN фаил, тоесть будет исполнена команда "java Main.java", либо ["ruby", "test"] это будет "ruby test.rb".



puts '                                      Сборка образа по Dockerfile'

# build - команда позволяет построить наш образ по инструкции из Dockerfile. Нужно прописать путь к созданному Dockerfile и опционально можно задать имя образу. Потом если выполнить 'docker images' мы увидим новый созданный образ в списке, у которого есть айди и можем далле запустить его при помощи "run" если нужно

# -t   - флаг задает название образа. Нельзя чтоб название образа содержало спец символы и символы в верхнем регистре

# > docker build ./php                   - собираем образ по Dockerfile, который находится по пути "./php"
# > docker build -t my-php-app ./php     - собираем образ и даем ему название "my-php-app"

# Если у вас при вводе команды docker build . - выдает ошибку failed to solve: the Dockerfile cannot be empty - то это значит что вы не сохранили сам файл проекта.


# Запуск созданного образа:
# > docker run -p 0a51b7d194e0                 - запуск по айди образа
# > docker run -p 8001:80 -d my-php-app        - запуск по имени с указанием портов

# Порт который работает на нашем компе (8001) можно указывать каким угодно именно го указываем после локалхосст в адресе. А связываться мы будем с портом который прописали в строке EXPOSE














#
