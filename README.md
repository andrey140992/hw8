# README
# Домашнее задание №6 к занятию по Rails Controllers

сервер запускается командой docker-compose up

http://localhost:3000/users   зарегистрироваться и авторизоваться


http://localhost:3000/orders/check?os=windows&cpu=8&ram=4&hdd_type=sata&hdd_capacity=20  Пример запроса и работа метода чек только для аунтифицированных пользователей, в поисковую строку передаются параметры .

# Домашнее задание №7 к занятию по Асинхронным задачам

1.

В одном терминале запускаем сервер docker compose up 

В другом запускаем консоль docker compose run --rm app rails c

В консоли создаем Order

Примерs запроса:
http://localhost:3000/orders/make_report?report_type=highest_price
http://localhost:3000/orders/make_report?report_type=lowest_price
http://localhost:3000/orders/make_report?report_type=VM_with_maximum_number_of_dop_disks
http://localhost:3000/orders/make_report?report_type=VM_with_maximum_vol_of_dop_disks

В консоли с помощью команды Report.all увидим созданные отчеты

2.
 В одном терминале запускаем RabbitMQ   docker-compose up rabbitmq

 В другом запускаем сервер docker compose up sidekiq redis order_performer calc_service app webpacker 

 http://localhost:3000/orders/:id/perform_order
 где :id - это id ордера


 смотрим логи сервиса order_performer, видим как логируется выполнение, в браузере получаем сообщение из order_performer о результате работы
 в консоли находим Order по id и смотрим текущий статус


