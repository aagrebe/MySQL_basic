/* Практическое задание #7. */

/* Задание # 1.
 * Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
*/

-- хотя бы одно соответствие подразумевает INNER JOIN
SELECT users.id, orders.user_id, users.name FROM users 
INNER JOIN orders ON users.id = orders.user_id GROUP BY users.id;