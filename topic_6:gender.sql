/* Практическое задание #6. */

/* Задание #3.
* Определить, кто больше поставил лайков (всего) - мужчины или женщины?
*/

-- выведем пользователей, которые поставили лайки
SELECT user_id FROM posts_likes WHERE like_type = 1;

-- выведем пользователей, которые мужского и женского пола
SELECT user_id FROM profiles WHERE gender = 'f'; -- женщины
SELECT user_id FROM profiles WHERE gender = 'm'; -- мужчины

-- мой запрос получился таким, может он громоздкий, но мне понятней
SELECT 'women', COUNT(*) AS total FROM posts_likes
	WHERE like_type =1 AND user_id IN
	(SELECT user_id FROM profiles WHERE gender = 'f')
UNION 
SELECT 'men', COUNT(*) AS total FROM posts_likes
	WHERE like_type =1 AND user_id IN
	(SELECT user_id FROM profiles WHERE gender = 'm');