/* Практическое задание #5. */

/* Задание #1.
 * Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
 * Заполните их текущими датой и временем.
*/

/* «Операторы, фильтрация, сортировка и ограничение». Для задания 1. */
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', NULL, NULL),
  ('Наталья', '1984-11-12', NULL, NULL),
  ('Александр', '1985-05-20', NULL, NULL),
  ('Сергей', '1988-02-14', NULL, NULL),
  ('Иван', '1998-01-12', NULL, NULL),
  ('Мария', '2006-08-29', NULL, NULL);
 
-- обновляем данные, используя предопределенную функцию NOW() 
UPDATE users
SET 
created_at = NOW(),
updated_at = NOW();


SELECT * FROM users;