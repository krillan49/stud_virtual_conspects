puts '                                             Docker Hub'

# https://hub.docker.com/

# Docker Hub - хранилище образов (один из регистров). Он является официальным и содержит большое количество образов с языками программирования и другими технологиями

# Docker использует различные регистры для хранения образов. Такие регистры хранят все образы на удаленном хосте. Docker может обращаться к регистрам и по необходимости вытягивать из них нужные образы.



puts '                                        Авторизация в терминале'

# Сначала нужно зарегаться на https://hub.docker.com/

# > docker login                   - команда авторизации в терминале - позволит отправлять контейнеры в Докерхаб. Может попросить логин и пароль от акаунта в Докерхаб или предложит авторизироваться через браузер.

# > docker logout                  - разлогин, выход из учетной записи



puts '                                          Скачивание образов'

# Explore - вкладка с образами которые можно использовать. При выборе образа будет ссылка с командой скачивания для терминала

# pull - команда скачивает контейнер из Docker Hub.

# > docker pull openjdk            - по умолчанию будет поставлена последняя версия (тут для openjdk, тоесть Джава)
# > docker pull openjdk:latest     - так же можно задать последнию версию и вручную
# > docker pull openjdk:11         - конкретная версия(В докумментации в хабе указаны другие версии)



puts '                                      Залив образа на Docker Hub'

# Чтобы наши образы могли скачать другие люди, нужно выгрузить их в репозитории на Docker Hub
# Чтобы залить образ на Docker Hub нужно предварительно залогиниться локально
# Можно заливать образы через аккаунт на Докерхаб во вкладке "Repositories" нажав кнопку "Create Repository" либо у себя локально собрать образ и запушить его на ДокерХаб при помощи команд

# 0. Если у нас много сервисов через docker-compose то нужно будет создать для каждого докерфаил, отдельно каждый сбилдить и запушить на Докерхаб и потом если будем использовать тот же docker-compose(например на сервер чтобы задеплоить), то переписать там во всех сервисах build на image, тк теперь у нас есть готовые образы.

# 1. Собираем образ для хаба, указав как название логин_на_докерхаб/имя_репозитория(название_образа) и путь к папке от рабочей директории
# > docker build -t krillan/myphp ./php          - от докерфаила из ./php с названием krillan/myphp

# 2. Загружаем образ на Докерхаб.
# push - команда позволяет загрузить образ на хаб. Теперь в личном кабинете в докерхабе будет новый контейнер. Там же можно добавить описание. Теперь этот образ есть в хабе, откуда его можно его скачать кому-то. По желанию можно указать версию. Если потом запушить с тем же названием, то будет несколько версий
# > docker push krillan/myphp:latest              - пушим образ версии :latest

# 3. Теперь кто-то(или мы сами) может скачать себе наш образ(название есть в нашем репозитории) и запустить
# image pull - команда стягивает  образ из хаба (?? чем отичается от просто docker pull ??)
# > docker image pull krillan/myphp













#
