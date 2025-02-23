puts '                                         Информационные команды'

# > docker                                - выдаст список всех возможных команд Докера

# > docker run --help                     - флаг --help выдаст полную информацию о конкретной команде (тут run) и ее флагах


# > docker info                           - посмотреть всю информацию: какие контейнеры запущены, какие скачаны, какие остановлены, какие на паузе, какие есть образы


# > docker images                         - детальная информация обо всех скачанных/созданных образах
# $ docker images -q                      - айдишники всех образов, например чтобы удалить

# > docker ps                             - список всех запущенных контейнеров с их именами, айдишниками, образами которые в них используются, портами
# > docker ps -a                          - (all) полный список всех существующих локально контейнеров, дополнительно показывает запущен ли(STATUS) сейчас
# $ docker ps -a -q                       - выведет список айдишников всех контейнеров, например чтобы скопировать вывод и удалить сразу много контейнеров



puts '                                                  run'

# run   - команда создает и запускает контейнер на основе указанного образа (если данного образа или образов его составляющих нет, то сначала их скачивает с ДоерХаб). Выдаст сообщение если скачивает образ; или ничего не выдаст, если такой образ уже существует локально. Контейнер будет в режме running. По умолчанию будет каждый раз создавать новый контейнер с рандомным названием при запуске от образа, так что лучше задать название и потом запускать уже от контейнера через "start".

# --name               - флаг задает имя контейнеру, имя пишем после этого флага. Если не указать имя, то Докер сгенерит его сам.
# --rm                 - опция удалит контейнер после того как он прекратит работу (тоесть не сохранит)
# -d (--detached)      - отсоединенный(фоновый) режим: мы возвращаем управление в наш терминал, а не оставляем его внутри контейнера, контейнер бует работать в фоновом режиме и терминал в котором его запускали не будет занят выводом его работы, а будет доступен для новых команд.
# -m (--memory bytes)  - опция позволяет задать лимит выделяемой памяти для данного контейнера
# -e                   - опция позволяет задать переменные окружения

# > docker run openjdk                     - запустить контейнер от образа "openjdk"(и скачать если его нет)
# > docker run --name MyJava openjdk       - запускаем и создаем на основе "openjdk" контейнер с именем MyJava
# $ docker run --rm openjdk                - запускаем контейнер и когда он прекратит работу, то контейнер удалится
# > docker run 5ecde7c66384                - запуск по айди
# $ docker run -e TZ=Europe/Moscow openjdk - запускаем и создаем контейнер с переменной окружения TZ=Europe/Moscow openjdk



puts '                                        Порты для веб приложений'

# Тк контейнер собирается в полностью изолированном окружении, это значит, что изолированы и сетевые подключения, тоесть если внутри контейнера приложение слушает какой-то порт, то все равно нихрена не услышит. Потому нам нужно явно указать какой порт контейнера пробрасывается в какой-то порт снаружи.

# Порты контейнера которые хотим пробрасываь можно прописать(заделарировать) в Dockerfile (?? хз зачем)

# -p (--publish list)  - опция команды run, позволяющая соединить порты. Например 8001:80 (HOST:CONTAINER), тут 8001 это порт связанный с нашим компом, а 80 это порт приложения пробрасываемый из контейнера. Те мы связываем по порту 8001 наш комп с портом 80 контейнера/проекта. Или по другому делаем доступным порт сервера в контейнере (80) на нашем локальном компьютере по адресу «localhost:8001»

# > docker run -d -p 80:80 docker/getting-started    - запускаем образ docker/getting-started и устанвливаем для него связанные порты 80:80

# Далее запустим приложение в браузере по дресу http://localhost:80



puts '                                          Интерактивный режим'

# Интерактивный режим - контейнер перейдет в режим running и в терминале мы будем уже внутри контейнера. Например сможем писать код на языке Джава в джавашелл, если образ openjdk, или если образ Убунту, то попали бы в ее баш шелл

# Флаги интерактивного режима, нужно прописать оба чтобы получить возможность взаимодействия с контейнером через терминал:
# -i (--interactive)  - поток STDIN поддерживается в открытом состоянии даже если контейнер к STDIN не подключён.
# -t (--tty)          - выделяется псевдотерминал, который соединяет используемый терминал с потоками STDIN и STDOUT контейнера.

# > docker run -it --name MyJava openjdk       - запустить образ(тут openjdk) в интерактивном режиме.

# Ctrl + d    - выход из интерактивного режима(из работы контейнера) в консоли. Контейнер снова переходит в режим Exited



puts '                               Работа с приложением в терминале контейнера'

# (?? Это только с докеркомпост или везде ??)

# Если работаем с приложением в терминале внутри контейнера, например запускаем Рэилс, то нужно добавить "-b 0.0.0.0" после порта, без этого приложение не будет видно на локальном компьютере
# $ rails server -p 3000 -b 0.0.0.0

# ctrl+d     - остановить сервер

# $ exit     - команда в терминале bash контейнера выйдет из контейнера



puts '                                     Команды для работы с образами'

# При создании разных образов из частично одних и тех же слоев, Докер сохраняет некоторые слои как отдельные образы без имени, можно их спокойно удалять

# Удаление образа (?? image rm  и rmi полные алиасы или нет ??):
# > docker image rm 5ecde7c66384               - по айди образа
# $ docker rmi openjdk                         - по имени образа
# $ docker rmi $(doсker images -q)             - удаляем все образы



puts '                                   Команды для работы с контейнерами'

# Для команд по работе с существующими контейнерами можно использовать id или название контейнера(если оно есть)

# id контейнера можно найти при помощи "docker ps" либо в приложении Docker Desktop Containers

# start - команда запускает контейнер (? если контейнер пустой и в нем только образ просто вернет имя контейнера и перейдет в режим Running ?)
# > docker start 9cc6a7919e96             - по айди контейнера
# > docker start -i MyJava                - по названию с опцией -i для работы в терминале

# pause - команда поставит работу контейнера на паузу (?? в отличие от остановки сохранятся временные фаилы ??)
# > docker pause 9cc6a7919e96             - по айди контейнера

# unpause - команда возобновит работу контейнера убрав с паузы
# > docker unpause 9cc6a7919e96           - по айди контейнера

# restart - команда перезапустит работу контейнера (например если возникла проблема)
# > docker restart 9cc6a7919e96           - по айди контейнера

# stop - команда чтобы остановить работу одного или нескольких контейнеров (статус изменится с running на exited)
# > docker stop 9cc6a7919e96              - по айди контейнера
# $ docker stop $(docker ps -q)           - остановит все запущенные контейнеры

# kill - команда зкстренного выхода (выход с ошибкой - exited будет равно уже не 0, а какому-то коду ошибки)
# > docker kill MyJava                    - по имени контейнера

# rm - команда удаления контейнера
# $ docker rm MyJava                       - по имени контейнера
# $ docker rm 9cc6a7919e96                 - по айди контейнера
# $ docker rm $(docker ps -aq)             - удалить все существующие контейнеры, тк docker ps -aq вернет все айдишники














#
