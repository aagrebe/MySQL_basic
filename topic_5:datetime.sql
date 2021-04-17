/* Практическое задание #5. */

/* Задание #2.
 * Таблица users была неудачно спроектирована. 
 * Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
 * Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
*/

/* «Операторы, фильтрация, сортировка и ограничение». Для заданий 2, 4. */
CREATE DATABASE lesson;
USE lesson;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Наталья', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('Александр', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('Сергей', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('Иван', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('Мария', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');

 -- создаем новые столбцы типа DATETIME
 ALTER TABLE users
 	ADD COLUMN new_created_at DATETIME;
 	ADD COLUMN new_updated_at DATETIME;
 
 -- перенесем данные из исходных столбцов
UPDATE users
SET 
	new_created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
 	new_updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');
 
 -- удалим старые столбцы
ALTER TABLE users 
	DROP created_at,
	DROP updated_at;

 -- переименуем столбцы в изначальный вид
ALTER TABLE users 
	RENAME COLUMN new_created_at TO created_at,
	RENAME COLUMN new_updated_at TO updated_at; 
     
DESCRIBE users;

SELECT * FROM users;