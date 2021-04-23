/* Практическое задание #9. */

/* Задание #1.
* В базе данных shop и sample присутствуют одни и те же таблицы, 
* учебной базы данных. Переместите запись id = 1 из таблицы shop.users 
* в таблицу sample.users. Используйте транзакции.
*/

START TRANSACTION; -- начало транзакции

-- SELECT @last_user_id := last_insert_id(); - так выдает только 1

SELECT @last_user_id := (SELECT MAX(id) FROM users) + 1;

INSERT INTO sample.users SELECT @first_one := @last_user_id, name, birthday_at, created_at, updated_at FROM users WHERE id = 1;

INSERT INTO sample.users SELECT * FROM users WHERE id=@last_user_id;

COMMIT; -- завершение транзакции