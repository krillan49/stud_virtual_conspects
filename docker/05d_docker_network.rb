puts '                                    Docker Network / Сети Докера'

# Все контейнеры Докера создаются в какой либо из сетей Докера и могут взаимодействовать друг с другом только в рамках этой сети, таким образом контейнеры одного приложения могут быть в своей сети и изолированы от контейнеров других приложений

# Можно подключить один контейнер ко многим сетям одновременно(?? сети одного типа или разных тоже)

# Для связи приложений, контейнеры которых изолированы отдельной сетью для каждого приложения, можно подключить контейнеры еще одного приложения ко всем этим сетям (прокси-сервер), так эти приложения смогут общаться друг с другом или пользователями только через этот прокси сервер. Это лучше в плане безопасности, чем если бы они все находились в одной сети


# $ ip a                      =>
# ...
# 5: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default
#     link/ether 6e:4f:23:62:67:d3 brd ff:ff:ff:ff:ff:ff
#     inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0

# docker0         - сетевая карта Докера на нашей хост машине
# 172.17.0.1/16   - ip-адрес и маска сети(??обозначает максимум адресов в последнем параметре??) сетевой карточки Докера


# Докер предоставляет для контейнеров 3 основные типа сетей и несколько дополнительных:
# 1. Bridge  - выход наружу через port mapping
# 2. Host    - ServerIP, тоесть с адресом сервера(хост машины), например 10.15.11.12
# 3. None
# 4. Macvlan
# 5. IPvlan
# 6. Overlay - нужен когда Докер запускается в кластере, например Docker Swarm Cluster

# По умолчанию уже существуют сети каждого основного типа (bridge, host, none)
# $ docker network ls               =>
# NETWORK ID     NAME                       DRIVER    SCOPE
# d4dc498e1033   bridge                     bridge    local
# 04c941da0498   host                       host      local
# fff49c747023   none                       null      local



puts '                                          Основные команды'

# network ls - команда выведет все существующие сети, их типы, айдишники
# $ docker network ls

# network create - команда создания новой сети
# -d (--driver) - параметр задает тип сети, если его не указать, то автоматически создастся сеть типа Bridge
# --subnet      - параметр указывающи адрес сети с маской сети
# --gateway     - параметр указывает ?откуда начинаются адреса сети ?? куда идут наши пакеты
# $ docker network create --driver bridge myNet1    - создаем новую Bridge-сеть с названием myNet1
# $ docker network create myNet1                    - создаем новую Bridge-сеть (выбирается по умолчанию) myNet1
# $ docker network create -d bridge --subnet 192.168.10.0/24 --gateway 192.168.10.1 myNet192

# network inspect - команда выдает подробную информацию о конкретной сети в виде JSON, в том числе ?айдишники? этой сети.
# $ docker network inspect myNetwork                - по имени сети
# $ docker network inspect 5ecde7c66384             - по айдишнику сети
#=>
# ...
# "Subnet": "172.21.0.0/16",
# "Gateway": "172.21.0.1"

# network rm - команда для удаления сети, принимает имя сети или ее айди
# $ docker network rm myNet192                       - удалим по имени
# $ docker network rm 388510fd38c9                   - удалим по айди
# $ docker network rm myNet192 e87eba15f6c5          - удалим сразу 2 сети


# --net (--network)  - параметр (?? только команды run или и других ??) для указания сети (по типу или имени), к которой будет подключен помещен созданный/запущенный контейнер. Значение можно задавать 2мя способами `--network` и `--network=`, оба варианта имеют одинаковый эффект. Сеть в которую помещаем должна быть создана заранее. Если не указать то поместит в Bridge-default-сеть
# $ docker run nginx                              - создаем и запускаеи контейнер в сети default типа Bridge
# $ docker run nginx --network=host               - создаем и запускаеи контейнер в сети host
# $ docker run nginx --network=none               - контейнер попадет в сеть None
# $ docker run --network my_network my_image      - ?? почему тут перед образом, а выше после ??
# $ docker run --network=my_network my_image      - ?? почему тут перед образом, а выше после ??
# $ docker run --net myNet1 nginx                 - помещаем контейнер в Bridge-сеть с названием myNet1

# Чтобы посмотреть в каких сетях находятся контейнер с айдишниками и айпи и прочей инфой, можно проинспектировать контейнер
# $ docker inspect some_container



puts '                                              Bridge'

# Bridge - тип сети по умолчанию и наиболее используемый. Если при создании контейнера не указать никакие доп параметры, то он по умолчанию попадает сеть default типа Bridge. Контейнеры находящиеся в сети этого типа имеют доступ наружу и могут подключаться к локальному серверу хоста, к другим серверам, интернету итд. Чтобы подключиться к контейнерам из этой сети извне - нужно пробросить мост/bridge, который соединит ip-адрес контейнера с ip-адресом хоста/сервера и чтобы его создать нужно использовать параметр "-p"(port mapping), например "-p 80:80" так мы сединим порт хоста с портом контейнера.

# Может существовать множество сетей типа Bridge. Контейнеры внутри одной Bridge-сети могут общаться друг с другом. Но контейнеры из разных Bridge-сетей общаться друг с другом уже не могут

# default - сеть типа Bridge, существующая по умолчанию, запуская Докер контейнер, он по умолчанию получаем дефоллтный Bridge серевой интерфейс(сетевую карточку) с адресом вроде "docker0: 172.17.0.1/16". Контейнеры в этой сети могут общаться между собой по ip-адресом которые они получают автоматически в этой сети (172.17.0.2, 172.17.0.3 итд), но они не могут общаться между собой, используя свои имена (DNS)

# $ docker run nginx             - при запуске контейнера, он, по умолчанию, попадает в Bridge docker0:172.17.0.1/16

# Кастомные Bridge-сети - это любые сети типа Bridge созданные вручную, они в отличие от default сети позволяют обращаться контейнерам друг к другу не только по ip-адресом, но и по DNS-именам (используются имена контейнеров). Нужно создать новую, кастомную Bridge-сеть и потом создать эти контейнеры в ней. Айпишники таких сетей будут идти после default, например: 172.18.0.1/16, 172.19.0.1/16 итд

# $ docker network create --driver bridge myNet1    - создаем новую Bridge-сеть с названием myNet1
# $ docker network create myNet1                    - создаем новую Bridge-сеть (выбирается по умолчанию) myNet1

# $ docker run --net myNet1 nginx           - помещаем созданный контейнер в Bridge-сеть с названием myNet1
# $ docker run --net myNet1 mysql           - помещаем еще один контейнер в Bridge-сеть с названием myNet1



puts '                                               Host'

# Host - тип сети в которой контейнеры получают ip-адрес хоста/сервера и отличаются от него только портами. Контейнеры находящиеся в сети этого типа имеют доступ наружу и могут подключаться к локальному серверу хоста, к другим серверам, интернету итд. Чтобы подключиться к контейнеру в сети Host достаточно указать ip-адрес хоста/сервера и порт, если он отличается от порта браузера по умолчанию(80 и 443), например 10.15.11.12:8001.

# Контейнеры в хост сети могут общаться между собой, но они не имеют своего ip-адреса и получают адрес самого хоста.

# Чтобы контейнер был создан в сети Host, нужно задать значение "host" для параметра "--network"
# $ docker run nginx --network=host     - контейнер попадет в сеть Host

# Невозможо создать больше 1й host-сети, тк контейнер будет использовать сетевую карточку сервера ??, потому выдаст ошибку (?? потому просто создавать бессмысленно или можно удалить ту что уже создана по умолчанию ??)
# $ docker network create --driver host myNet1   => Error response from daemon: only one instance of "host" network is allowed

# Использование режима сети `host` может иметь свои риски с точки зрения безопасности, так как контейнер будет иметь полный доступ к сети хост



puts '                                               None'

# None - тип сети в которой контейнеры не получают ip-адреса и к ним невозможно подключиться извне ни локально ни через интернет, тоесть контейнеры из этой сети можно использовать только локально. Каждый контейнер в None-сети изолирован не только от подключений извне, но и от других контейнеров в None-сети

# Чтобы контейнер был создан в сети None, нужно задать значение "none" для параметра "--network"
# $ docker run nginx --network=none     - контейнер попадет в сеть None

# Невозможо создать больше 1й None-сети, потому выдаст ошибку (?? потому просто создавать бессмысленно или можно удалить ту что уже создана по умолчанию ??)
# $ docker network create -d null myNet1   => Error response from daemon: only one instance of "null" network is allowed



puts '                                          Macvlan и IPvlan'

# Используются для работы с сетью, фаерволами, прокси итд

# Macvlan и IPvlan - тип сети в которых контейнеры получают свои собственные сетевые карточки и ip-адреса, что позволяет подключаться извне к контейнеру напрямую через его ip-адрес. Например серврер с сетевой карточкой "eth0:" c ip-адресом "172.16.10.2", каждый контейнер в сети *vlan на этом сервере получает свои сетевые карточки и ip-адреса, например "eth0:172.16.10.21" и "eth0:172.16.10.22"

# Macvlan - сетнвая карточка имеет свой mac-адрес, например "15:4a:bc:13:d2:12", а сетевая карта каждого контейнера в сети Macvlan олучает свой отдельный mac-адрес, что намного упрощает маршрутизацию

# IPvlan - сетевая карта каждого контейнера получает тот же самый mac-адрес как у сервера



puts '                                       Тестирование Bridge сетей'

# Для того чтобы протестировать сети стоит использовать специальный контейнер в котором будут работать сетевые команды Линукс, например https://hub.docker.com/r/nicolaka/netshoot, тк в обычных вырезается все лишнее, не нужное для работы соответсвующих технологий

# Создадим и запустим терминалы 2х контейнеров в Bridge-сети default
# $ docker run --rm -it --name netTest1 nicolaka/netshoot /bin/bash      - создадим и запустим с командой /bin/bash
# $ docker run --rm -it --name netTest2 nicolaka/netshoot /bin/bash      - создадим 2й контейнер

# Проверим какие сетевые карточки есть в 1м контейнере
# $ ip a
#=>
# ...
# 2: eth0@if10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
#     link/ether 6a:c3:bf:9e:e9:a7 brd ff:ff:ff:ff:ff:ff link-netnsid 0
#     inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0

# Проверим какие сетевые карточки есть в 1м контейнере
# $ ip a
#=>
# ...
# 2: eth0@if11: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
#     link/ether 92:a8:88:a7:5a:6c brd ff:ff:ff:ff:ff:ff link-netnsid 0
#     inet 172.17.0.3/16 brd 172.17.255.255 scope global eth0

# Проверим через команду "ping" что эти 2 контейнера могут общаться в общей сети
# $ ping 172.17.0.3                 - проверим по ip-адресу, что первый контейнер может подключиться ко 2му

# Проверим в какой сети находится контейнер
# $ docker inspect netTest2
#=>
# "NetworkSettings": {
#   ...
#   "Networks": {
#     "bridge": {
# ...


# Создадим сеть чтобы в ней контейнеры могли общаться по DNS
# $ docker network create mynet1

# Создадим и запустим контейнеры в Bridge-сети mynet1
# $ docker run --rm -it --name netTest1 --net mynet1 nicolaka/netshoot /bin/bash
# $ docker run --rm -it --name netTest2 --net mynet1 nicolaka/netshoot /bin/bash

# Проверим через команду "ping" что эти 2 контейнера могут общаться в сети и по айпи и по по DNS имени
# $ ping 172.18.0.3                 - проверим по ip-адресу, что первый контейнер может подключиться ко 2му
# $ ping netTest2                   - проверим по DNS имени, что первый контейнер может подключиться ко 2му


# Перенести контейнер из одной сети в другую

# Создадим и запустим контейнер в Bridge-сети default
# $ docker run --rm -it --name netTest1 nicolaka/netshoot /bin/bash

# $ ip a
#=>
# ...
# 2: eth0@if18: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
#     link/ether 36:3a:fe:c6:d7:53 brd ff:ff:ff:ff:ff:ff link-netnsid 0
#     inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
#        valid_lft forever preferred_lft forever


# network connect - команда чтобы подкдключить контейнер к другой сети (1 контейнер может находиться в нескольких сетях одновременно). Можно подключить контейнер прямо во время его работы
# $ docker network connect mynet1 netTest1           - подключаем контейнер netTest1 к сети mynet1

# Проверим, что наш контейнер находится теперпь в 2х сетях
# $ ip a
#=>
# ...
# 2: eth0@if18: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
#     link/ether 36:3a:fe:c6:d7:53 brd ff:ff:ff:ff:ff:ff link-netnsid 0
#     inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
#        valid_lft forever preferred_lft forever
# 3: eth1@if20: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
#     link/ether 52:90:90:49:5e:85 brd ff:ff:ff:ff:ff:ff link-netnsid 0
#     inet 172.18.0.2/16 brd 172.18.255.255 scope global eth1
#        valid_lft forever preferred_lft forever

# Посмотрим теперь инфу о нашем контейнере и найдем там айдишники сетей
# $ docker inspect netTest1
#=>
# ...
# "Networks": {
#     "bridge": {
#         ...
#         "NetworkID": "d4dc498e103315d7875e79b26171ff898b433767fd6ec63871209017936f39e3",
#         "EndpointID": "4b90b002a98b59ec763215a19014473ae11074f24445e35b2fa26801d5d92752",
#         "Gateway": "172.17.0.1",
#         "IPAddress": "172.17.0.2",
#         ...
#     },
#     "mynet1": {
#         ...
#         "NetworkID": "f72d94f10a06da2ecdaa1a73045bafc9892804feb2271b342811b2e0547d5958",
#         "EndpointID": "e5cc9cfd4918ed755be8b00476992f53cfef6123112895adb50c4036e4e53c9f",
#         "Gateway": "172.18.0.1",
#         "IPAddress": "172.18.0.2",
#         ...
#         "DNSNames": [
#            "netTest1",
#            "7e7140560741"
#         ]
#     }
# ...

# network disconnect - команда дл того чтобы отключить контейнер от сети, для этого можно использовать NetworkID сети
# $ docker network disconnect d4dc498e103315d7875e79b26171ff898b433767fd6ec63871209017936f39e3 netTest1     - отключим контейнер netTest1 от первой сети используя ее NetworkID

# Теперь помимо локалхоста у этого контейнера осталась одна сетевая карточка, тоесть он принадлежит только одной сети
# $ ip a
#=>
# ...
# 3: eth1@if20: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
#     link/ether 52:90:90:49:5e:85 brd ff:ff:ff:ff:ff:ff link-netnsid 0
#     inet 172.18.0.2/16 brd 172.18.255.255 scope global eth1
#        valid_lft forever preferred_lft forever



puts '                                       Тестирование Host и None сетей'

# $ docker run --rm -it --name netTest1 --net host nicolaka/netshoot /bin/bash

# И если мы используем коменду "ip a" то увидим в контейнере точно те же самые сетевые интефейсы, что и на нашей хост-машине.

# Соединение по имени контейнера (DNS) мжду двумя контейнерами в host-сети не работает. Можно проверить через команду "ping" (??а по айпи как там же один и тот же тоесть мы будем пинговать саму хост машину??)


# $ docker run --rm -it --name netTest1 --net none nicolaka/netshoot /bin/bash

# Проверим контейнер в none сети, где у него будет только сетевая карточка локалхоста
# $ ip a
#=>
# 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
#     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
#     inet 127.0.0.1/8 scope host lo
#        valid_lft forever preferred_lft forever
#     inet6 ::1/128 scope host
#        valid_lft forever preferred_lft forever



puts '                                      Тестирование Macvlan и IPvlan сетей'

# Создадим Macvlan сеть. При создании такой сети создается DHTP-сервер, тоесть при запуске контейнера ему выдается какой-то рандомеый ip-адрес от этой сети
# --ip-range       - флаг указывает ??диапазон/макситмально возможный адрес?? ip-адресов или только этот конкретный адрес ??
# -o parent=       - опция указывает с какой сетевой карточкой на сервере (значение это имя сетевой карточки, его можно посмотреть через "ip a" на сервере) будет спарена
# $ docker network create -d macvlan --subnet 192.168.100.0/24 --gateway 192.168.100.1 --ip-range 192.168.100.99/32 -o parent=wlp0s20f3 myMACvlan

# Создадим и запустим контейнер в этой сети
# $ docker run --rm -it --name netTest1 --net myMACvlan nicolaka/netshoot /bin/bash

# В итоге контейнер имеет айпи адрес заданный в --ip-range
# $ ip a
#=>
# ...
# 23: eth0@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
#     link/ether 26:31:bb:38:35:7e brd ff:ff:ff:ff:ff:ff link-netnsid 0
#     inet 192.168.100.99/24 brd 192.168.100.255 scope global eth0
#        valid_lft forever preferred_lft forever


# Но мы можем создать не просто рандомную сеть, а соответсвующую нашей сетеой карточке хост машины, адрес которой 192.168.1.36/24, тоесть адрес 192.168.1.35 точно свободен
# $ ip a
#=>
# ...
# 3: wlp0s20f3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
#     link/ether 80:b6:55:5a:1c:e3 brd ff:ff:ff:ff:ff:ff
#     inet 192.168.1.36/24 brd 192.168.1.255 scope global dynamic noprefixroute wlp0s20f3

# $ docker network create -d macvlan --subnet 192.168.1.0/24 --gateway 192.168.1.1 --ip-range 192.168.1.35/32 -o parent=wlp0s20f3 myMACvlan

# Создадим и запустим контейнер в этой сети
# $ docker run --rm -it --name netTest1 --net myMACvlan nicolaka/netshoot /bin/bash

# Так же можем запустить контейнер в этой сети и с другим конкретным айпи адресом дополнительно указав его через флаг --ip
# $ docker run --rm -it --name netTest2 --ip 192.168.1.34 --net myMACvlan nicolaka/netshoot /bin/bash

# $ ip a
#=>
# ...
# 24: eth0@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
#     link/ether d6:4d:49:0e:40:6e brd ff:ff:ff:ff:ff:ff link-netnsid 0
#     inet 192.168.1.35/24 brd 192.168.1.255 scope global eth0
#        valid_lft forever preferred_lft forever

# (!!?? Но почемуто связь от сервера, через команду ping в эту сеть не проходит хотя в видосе проходила ??)






















#
