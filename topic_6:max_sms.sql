/* Практическое задание #6. */

/* Задание #1.
* Пусть задан некоторый пользователь. 
* Найдите человека, который больше всех общался с нашим пользователем, иначе, 
* кто написал пользователю наибольшее число сообщений. (можете взять пользователя с любым id).
*/

SELECT * FROM users;

-- выбираем данные пользователя с id = 6
SELECT 
	first_name,
	last_name
FROM users 
WHERE id = 6;

-- находим id тех, кто писал нашему пользователю и сгруппируем по id
SELECT from_user_id FROM messages WHERE to_user_id = 6 GROUP BY from_user_id;

-- для вычисления количества сообщений добавим count
SELECT from_user_id, COUNT(from_user_id) sms_number 
	FROM messages 
	WHERE to_user_id = 6 
	GROUP BY from_user_id;

-- найдем максимальное количество сообщений
SELECT from_user_id, COUNT(from_user_id) sms_number 
	FROM messages 
	WHERE to_user_id = 6 
	GROUP BY from_user_id 
	ORDER BY sms_number DESC LIMIT 1;

-- получили, что юзер под номером 11 написал больше всего сообщений юзеру 6
-- добавила имя пользователя
SELECT (SELECT first_name FROM users WHERE id = messages.from_user_id), from_user_id, COUNT(from_user_id) sms_number 
	FROM messages 
	WHERE to_user_id = 6 
	GROUP BY from_user_id 
	ORDER BY sms_number DESC LIMIT 1;