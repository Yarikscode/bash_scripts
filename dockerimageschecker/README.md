# 🎓 Dockerimageschecker


## 📌 Описание проекта

Запуск скрипта verison_image.sh <имя репозитория 1> <имя репозитория 2> <имя репозитория n>

Пример ./verison_image.sh nginx hello-world

Скрипт также можно запустить как systemd-deamon и systemd-timer

- **findImage.timer** в качестве примера запускается раз в 5 минут
- **findImage.service**

## Systemd

### 🚀 Запуск от root
Если у вас Ubuntu server и подобные ОС:

Расположите файлы в папке /etc/systemd/system/

Запуск осуществляется от root:

systemctl start findImage.timer


### 🚀 Запуск от user

Расположите файлы в папке /home/{user}/.config/systemd/ust/

Запуск осуществляется от вашего user:

*Не забудьте включить linger для вашего пользователя*

systemctl --user start findImage.timer
