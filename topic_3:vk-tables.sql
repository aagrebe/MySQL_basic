/* Практическое задание #3. */

/* Задание #2.
 * Придумать 2-3 таблицы для БД vk, которую мы создали на занятии (с перечнем полей, указанием индексов и внешних ключей). 
 * Прислать результат в виде скрипта *.sql.
*/

/*
 *Таблица типов объявлений.
 *Создаем типы объявлений, чтобы подтянуть их к объявлениям.
*/

CREATE TABLE ads_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(30) NOT NULL UNIQUE -- животные,вещи,автотовары
) ENGINE=InnoDB;
/*
 * Таблица объявлений.
 * У каждого объявления может быть только один создатель, но пользователь может создать много объявлений.
 * Связь от одного (пользователь) к многим (объявлениям). Добавляем в многие (chats) ссылку на пользователя (users),
 * то есть foreign key на users.
*/

CREATE TABLE ads (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id объявления
	name VARCHAR(145) NOT NULL, -- название объявления
	author_id BIGINT UNSIGNED NOT NULL, -- id создателя
	ads_types_id INT UNSIGNED NOT NULL,
	price DECIMAL(20,2) UNSIGNED NOT NULL,
	description TEXT(3000), -- объявление можно добавить без описания 
	call_access BOOLEAN DEFAULT TRUE, -- если переключим на разрешение, будет TRUE, необязательно
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- когда создали
	updated_at DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP, -- когда обновили
	INDEX author_idx (author_id), -- индекс для быстрого поиска создателя
	INDEX ads_ads_types_idx (ads_types_id),
	CONSTRAINT ads_types_ads_fk FOREIGN KEY (ads_types_id) REFERENCES ads_types (id),
	CONSTRAINT users_ads_fk FOREIGN KEY (author_id) REFERENCES users (id)
);

/*
 * Таблица места работы.
 * Дополнение к таблице профиля с дополнительной привязкой к сообществу.
 * Привязка к сообществу является единственным обязательным аргументом.
*/

CREATE TABLE city (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(30) NOT NULL UNIQUE -- животные,вещи,автотовары
) ENGINE=InnoDB;

CREATE TABLE career (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(145), -- название должности
	communities_id BIGINT UNSIGNED NOT NULL,
	career_start YEAR,
	career_end YEAR,
	career_city INT UNSIGNED,
	city_id INT UNSIGNED,
	CONSTRAINT community_carreer_fk FOREIGN KEY (communities_id) REFERENCES communities (id),
	CONSTRAINT city_career_fk FOREIGN KEY (city_id) REFERENCES city (id)
);
	
ALTER TABLE profiles ADD COLUMN career_id INT UNSIGNED;
	
ALTER TABLE profiles ADD CONSTRAINT profile_career_fk FOREIGN KEY (career_id) REFERENCES career(id);