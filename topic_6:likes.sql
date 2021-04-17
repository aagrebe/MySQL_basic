/* Практическое задание #6. */

/* Задание # 2.
 * Подсчитать общее количество лайков на посты, которые получили пользователи младше 18 лет.
*/

SELECT * FROM users;

SELECT * FROM profiles;

SELECT * FROM posts;

SELECT * FROM posts_likes;

-- выводим пользователей, чей возраст младше 18 лет
SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, CURDATE())< 18;

-- выбираем посты пользователей
SELECT id FROM posts;

-- выбираем посты пользователей младше 18 лет
SELECT id FROM posts 
WHERE user_id IN 
(SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, CURDATE())< 18);

-- посчитаем количество лайков
SELECT COUNT(*) FROM posts_likes;

-- посчитаем количество лайков на посты посты пользователей младше 18 лет
SELECT COUNT(*) FROM posts_likes 
WHERE post_id IN 
(SELECT id FROM posts 
WHERE user_id IN 
(SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, CURDATE())< 18))
AND like_type = 1;