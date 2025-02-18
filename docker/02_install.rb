puts '                                            Установка'

# На мак и виндоус просто качать установочник и установить

# https://docs.docker.com/desktop/setup/install/linux/               - инструкция установки на Линукс
# https://docs.docker.com/desktop/setup/install/linux/ubuntu/        - инструкция установки на Убунту

# https://www.youtube.com/watch?v=QF4ZF857m44  (1-08-20   установка докер т докеркомпос на Убунту)



puts "                                  Установка Докер на Ubuntu 20.04"

# (?? Таким способом ставится без Docker Compose, потому его нужно установить отдельно, погуглить ??)

# 1. Обновим пакеты:
# $ sudo apt update

# 2. Установим пакеты, которые назначат право для “apt” пользоваться пакетами по протоколу HTTPS:
# $ sudo apt install apt-transport-https ca-certificates curl software-properties-common

# 3. После чего установим GPG ключ для репозитория Docker в нашу систему:
# $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# 4. Добавим в APT sources репозиторий Docker (ожидании на установку в репозитории Docker для Ubuntu 20.0):
# $ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

# 5. Обновим базу данных пакетами Docker из добавленного нами репозитория:
# $ sudo apt update

# 6. Убедимся, что мы собираемся установить его именно из репозитория Docker:
# $ apt-cache policy docker-ce
#=>
# docker-ce:
# Installed: (none)
# Candidate: 5:19.03.9~3-0~ubuntu-focal
# Version table:
# 5:19.03.9~3-0~ubuntu-focal 500
# 500 https://download.docker.com/linux/ubuntu focal/stable amd64 Packages

# 7. Устанавливаем Docker:
# $ sudo apt install docker-ce

# 8. Docker установлен на вашу машину и процесс для запуска при загрузке включен. Проверим, что Docker работает:
# $ sudo systemctl status docker
#=>
# docker.service - Docker Application Container Engine
# Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
# Active: active (running) since Tue 2020-05-19 17:00:41 UTC; 17s ago
# TriggeredBy: ● docker.socket
# Docs: https://docs.docker.com
# Main PID: 24321 (dockerd)
# Tasks: 8
# Memory: 46.4M
# CGroup: /system.slice/docker.service
# └─24321 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock














#
