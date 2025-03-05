puts '                                         Информационные команды'

# $ service docker status                 - Описание процесса Докера (тк докер это такой же процесс как и остальные), если какая-то команда не работает, то можно посмотреть работает ли процесс


# > docker                                - выдаст список всех возможных команд Докера

# $ docker --version                      - выдаст версию Докера


# > docker run --help                     - флаг --help выдаст полную информацию о конкретной команде (тут run) и ее флагах


# > docker info                           - посмотреть всю информацию: какие контейнеры запущены, какие скачаны, какие остановлены, какие на паузе, какие есть образы


# > docker images                         - детальная информация обо всех скачанных/созданных образах
# $ docker images -q                      - айдишники всех образов, например чтобы удалить

# > docker ps                             - список всех запущенных контейнеров с их именами, айдишниками, образами которые в них используются, портами
# > docker ps -a                          - (all) полный список всех существующих локально контейнеров и запущены ли они
# $ docker ps -a -q                       - выведет список айдишников всех контейнеров, например чтобы скопировать вывод и удалить сразу много контейнеров



puts '                                            Удалить все'

# $ docker system prune -a --volumes      - удалить все остановленные контейнеры, образы и тома, если они не используются в работающх сейчас контейнерах

# --volumes   - флаг для того чтобы удалить и тома



puts '                                     Команды для работы с образами'

# При создании разных образов из частично одних и тех же слоев, Докер сохраняет некоторые слои как отдельные образы без имени, можно их спокойно удалять

# pull - команда скачивает образ из Docker Hub(? по умолчанию ? както из других репозиториев ??). Версии можно посмотреть в разделе "Tag"
# > docker pull openjdk            - по умолчанию будет поставлена последняя версия (тут для образа openjdk)
# > docker pull openjdk:latest     - так же можно задать последнию версию и вручную
# > docker pull openjdk:11         - конкретная версия(В докумментации в хабе указаны другие версии)

# tag - переименование образа (удобно если забыли задать имя при создании через Dockerfile) с возможностью добавить ему тег
# $ docker tag 5ecde7c66384 myimage:v01      - образ с айди 5ecde7c66384 называем myimage:v01

# Удаление образа (?? image rm  и rmi полные алиасы или нет ??):
# > docker image rm 5ecde7c66384               - по айди образа
# $ docker rmi openjdk                         - по имени образа
# $ docker rmi 5ecde7c66384                    - по айди
# $ docker rmi 5e 66 84                        - несколько образов по частям айди
# $ docker rmi $(doсker images -q)             - удаляем все образы

# image inspect - покажет полную информацию об образе в формате JSON, указаны все команды что выполняются при создании(RUN) и при запуске образа(CMD)
# $ docker image inspect myimage:v01



puts '                                                  run'

# run   - команда создает и запускает контейнер на основе указанного образа (если данного образа или образов его составляющих нет, то сначала их скачивает с ДоерХаб). Дополнительно выдаст сообщение если скачивает образ. Контейнер будет в режме running. По умолчанию будет каждый раз создавать новый контейнер с рандомным названием при запуске от образа, так что лучше задать название и потом запускать уже от контейнера через "start". Так же может принимать команду, которая выполнится в контейнере после запуска.

# --name               - флаг задает имя контейнеру, имя пишем после этого флага. Если не указать имя, то Докер сгенерит его сам.
# --rm                 - опция удалит контейнер после того как он прекратит работу (тоесть не сохранит)
# -d (--detached)      - отсоединенный(фоновый) режим: мы возвращаем управление в наш терминал, а не оставляем его внутри контейнера, контейнер бует работать в фоновом режиме и терминал в котором его запускали не будет занят выводом его работы, а будет доступен для новых команд.
# -m (--memory bytes)  - опция позволяет задать лимит выделяемой памяти для данного контейнера

# > docker run openjdk                     - запустить контейнер от образа "openjdk"(и скачать если его нет)
# $ docker run ubuntu:20.04                - запустить/стянуть образ конкретной версии (по умолчанию latest)
# > docker run --name MyJava openjdk       - запускаем и создаем на основе "openjdk" контейнер с именем MyJava
# $ docker run --rm openjdk                - запускаем контейнер и когда он прекратит работу, то контейнер удалится
# > docker run 5ecde7c66384                - запуск по айди

# $ docker run ubuntu sleep 5              - запуск образа ubuntu передаем команду "sleep 5", тоесть контейнер проработает 5 секунд, хть там и нет процессов изначально, но будет исполнять этот процесс
# $ docker run ubuntu:20.04 echo "hui"     - запуск образа ubuntu:20.04, передаем команду echo "hui"
# $ docker run -d ubuntu sleep 5           - во время работы не будет занимать терминал
# $ docker run ubuntu:20.04 ls             - вывести папки рабочей директории контейнера



puts '                                          Интерактивный режим'

# Интерактивный режим - контейнер перейдет в режим running и в терминале(или в другой оболочке) мы будем уже внутри контейнера, там сможем перемещаться по его директориям, выполнять команды, например сможем писать код на языке Джава в джавашелл, если образ openjdk, или если образ Убунту, то попали бы в ее баш шелл

# Флаги интерактивного режима, нужно прописать оба чтобы получить возможность взаимодействия с контейнером через терминал:
# -i (--interactive)  - поток STDIN поддерживается в открытом состоянии даже если контейнер к STDIN не подключён.
# -t (--tty)          - выделяется псевдотерминал, который соединяет используемый терминал с потоками STDIN и STDOUT контейнера.

# > docker run -it --name MyJava openjdk       - запустить образ(тут openjdk) в интерактивном режиме.

# Если работаем с приложением в терминале внутри контейнера, например запускаем Рэилс, то нужно добавить "-b 0.0.0.0" после порта, без этого приложение не будет видно на локальном компьютере
# $ rails server -p 3000 -b 0.0.0.0

# $ exit                                       - выход из интерактивного режима контейнера (?? команда баш ??)

# Ctrl + d    - выход из интерактивного режима(из работы контейнера) в консоли. Контейнер снова переходит в режим Exited



puts '                                   Команды для работы с контейнерами'

# Для команд по работе с существующими контейнерами можно использовать id или название контейнера(если оно есть)

# id контейнера можно найти при помощи "docker ps" либо в приложении Docker Desktop Containers

# inspect - показывает полную информацию о контейнере: порты, как он собирался, в каких сетях находится итд
# $ docker inspect 9cc6a7919e96           - по айди контейнера

# stats - показывает сколько ресурсов железа потребляет данный контейнер (CPU - процессор, MEM - память, NET - нагрузка на сеть, BLOCK - нагрузка на диски)
# $ docker stats 9cc6a7919e96             - по айди контейнера

# start - команда запускает контейнер (? по умолчинию в режиме -d ?)
# > docker start 9cc6a7919e96             - по айди контейнера
# > docker start -i MyJava                - по названию с опцией -i для работы в терминале

# exec - команда позволяет зайти в терминал уже запущеного кнтейнера(нужно указать оболочку, например /bin/bash). В Докер контейнерах есть не все команды той системы на которой они основаны(чаще всего Убунту), тк они получают только самый минимум для того чтобы работала какая-то прога
# $ docker exec -it 9cc6a7919e96 /bin/bash

# logs - команда покажет логи контейнера (что он выводит в терминал), удобно если мы запустили контейнер в -d режиме
# $ docker logs 9cc6a7919e96              - по айди контейнера
# $ docker logs -f 9cc6a7919e96           - с флагом -f будет выводить логи в реальном времени

# pause - команда поставит работу контейнера на паузу (?? в отличие от остановки сохранятся временные фаилы ??). Удобно если например работет много контейнеров и нужно остановить один из них зачем-то. В статусе будет написано "paused"
# > docker pause 9cc6a7919e96             - по айди контейнера
# $ docker pause 9cc                      - по части айди контейнера

# unpause - команда возобновит работу контейнера убрав с паузы (docker pause)
# > docker unpause 9cc6a7919e96           - по айди контейнера

# restart - команда перезапустит работу контейнера (например если возникла проблема)
# > docker restart 9cc6a7919e96           - по айди контейнера

# stop - команда чтобы остановить работу одного или нескольких контейнеров (статус изменится с running на exited)
# > docker stop 9cc6a7919e96              - по айди контейнера
# $ docker stop myapp1 myapp2             - несколько контейнеров по именам
# $ docker stop $(docker ps -q)           - остановит все запущенные контейнеры

# kill - команда зкстренного выхода (выход с ошибкой - exited будет равно уже не 0, а какому-то коду ошибки), например если выход через stop занимает долго времени
# > docker kill MyJava                    - по имени контейнера

# rm - команда удаления контейнера
# $ docker rm MyJava                       - по имени контейнера
# $ docker rm 9cc6a7919e96                 - по айди контейнера
# $ docker rm 9c                           - по нескольим 1м символам айди контейнера (если их достаточно)
# $ docker rm 9c b6 ae                     - удалить несколько контейнеров
# $ docker rm $(docker ps -aq)             - удалить все существующие контейнеры, тк docker ps -aq вернет все айдишники














#
