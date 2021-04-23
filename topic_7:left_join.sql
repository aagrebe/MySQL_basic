/* Практическое задание #7. */

/* Задание # 2.
* Выведите список товаров products и разделов catalogs, который соответствует товару.
*/

-- LEFT JOIN
SELECT products.id, products.name, products.desсription, catalogs.name FROM products 
LEFT JOIN catalogs ON products.catalog_id = catalogs.id;