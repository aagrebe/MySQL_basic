/* Практическое задание #11. */

/* Задание #1.
* Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
* catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, 
* идентификатор первичного ключа и содержимое поля name.
*/

-- сделала попытку, разъяснения, к сожалению, не нашла
-- хотелось бы узнать, что я делаю неправильно, так как функция может пригодиться

CREATE TABLE logs (
  time_created DATETIME,
  table_name enum('users', 'catalogs', 'products'),
  name VARCHAR(255)
) ENGINE = ARCHIVE DEFAULT CHARSET = utf8;

SELECT * FROM users;
SELECT * FROM logs;

-- включаем логи
SET global general_log = 1;
-- выводить логи в бд
SET global log_output = table;
-- просматриваем логи
SELECT * FROM mysql.general_log;
-- выключаем логи
SET global general_log = 0;