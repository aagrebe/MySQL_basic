/* Практическое задание #9. */

/* Задание #2.
* Создайте представление, которое выводит название name товарной позиции из таблицы products 
* и соответствующее название каталога name из таблицы catalogs.
*/

-- создаем представление из таблицы products, объединенное с catalogs через LEFT JOIN
CREATE OR REPLACE VIEW products_from_catalogs AS 
SELECT products.id, products.name AS product_name, catalogs.name AS catalog_name FROM products 
LEFT JOIN catalogs ON products.catalog_id = catalogs.id;

SELECT * FROM products_from_catalogs;