puts '                                       Ошибки разное'

# Если есть какието проблемы то нужно зайти в BIOS и проверить стоит ли та флажок на "virtualization" он должн быть "enabled"



# Способы Исправить маленькое разрешение экрана:

# Если все равно не смог нормальной адаптации добиться, например на ноуте с фул эйч ди то можно поставить пакет - Guest Additions:
# Before installing  VirtualBox Guest Additions on Ubuntu 22.04 we need to install some required packages. So open the terminal and run the following command.
# 1) sudo apt install linux-headers-$(uname -r) build-essential dkms
# Then you need to reboot your system.
# 2) sudo apt update
# 3) sudo apt install -y build-essential linux-headers-$(uname -r)
# Then you need to reboot your system
