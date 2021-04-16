/* Практическое задание #5. */

/* Задание #5.
 * Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2);
 * Отсортируйте записи в порядке, заданном в списке IN.
*/

/* «Операторы, фильтрация, сортировка и ограничение». Для задания 5. */
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');
  
SELECT * FROM catalogs WHERE id IN (5, 1, 2);
 
-- здесь нашла сочентание ORDER BY с FIELD, который возвращает позицию значения в списке
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(ID,5,1,2);