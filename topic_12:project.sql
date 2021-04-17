/* Курсовой проект Delivery Club
 * 
 * Задание 1
 * Составить общее текстовое описание БД и решаемых ею задач;
 */

/*
 * Delivery Club - сервис доставки еды. 
 * Сервис связывает покупателей и ресторанах - формирует заказы и обеспечивает поддержкой обе стороны.
*/

-- 1 -- users - покупатели
-- 2 -- category_of_delivers - категории ресторанов 1:1
-- 3 -- delivers - рестораны
-- 4 -- adresses - адреса пользователей и ресторанов 1:n
-- 5 -- stars - оценки ресторанам 1:n
-- 6 -- sales - акции
-- 7 -- categories_of_dishes - категории блюд 1:n
-- 8 -- dishes - блюда - связано с меню и корзиной
-- 9 -- basket - корзина - здесь можно добавить продукты только одного ресторана

CREATE DATABASE project;
USE project;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(145) NOT NULL,
  last_name VARCHAR(145) NOT NULL,
  email VARCHAR(145) NOT NULL,
  phone INT UNSIGNED NOT NULL,
  password_hash CHAR(65) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  adress VARCHAR(250) NOT NULL,
  UNIQUE INDEX email_unique (email),
  UNIQUE INDEX phone_unique (phone)
) ENGINE=InnoDB;


DROP TABLE IF EXISTS category_of_delivers;
CREATE TABLE category_of_delivers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  category varchar(45),
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS delivers;
CREATE TABLE delivers (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(145) NOT NULL,
  email VARCHAR(145) NOT NULL,
  phone INT UNSIGNED NOT NULL,
  password_hash CHAR(65) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  adress VARCHAR(250) NOT NULL,
  category_of_delivers_id INT UNSIGNED NOT NULL, 
  UNIQUE INDEX name_unique (name), -- думаю, что в имени тоже должен быть юник
  UNIQUE INDEX email_unique (email),
  UNIQUE INDEX phone_unique (phone),
  PRIMARY KEY (id),
  KEY category_of_delivers_idx (category_of_delivers_id),
  CONSTRAINT fk_delivers_category_of_delivers FOREIGN KEY (category_of_delivers_id) REFERENCES category_of_delivers (id)
) ENGINE=InnoDB;


DROP TABLE IF EXISTS adresses; -- здесь сомневаюсь насчет корретности, потому что не совсем понимаю, 
-- как это реализовать, хочу чтобы адреса накапливались от юзеров и деливеров
CREATE TABLE adresses (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  deliver_id BIGINT UNSIGNED NOT NULL,
  adress VARCHAR(250) NOT NULL,
  PRIMARY KEY (id),
  KEY adresses_users_idx (user_id),
  KEY adresses_delivers_idx (deliver_id),
  CONSTRAINT fk_adresses_users FOREIGN KEY (user_id) REFERENCES users (id),
  CONSTRAINT fk_adresses_delivers FOREIGN KEY (deliver_id) REFERENCES delivers (id)
 );

DROP TABLE IF EXISTS stars;
CREATE TABLE stars ( -- здесь решила отказаться от сохранения информации, кто поставил звездочку, потому что обычно
-- это не доступно для просмотра и вынесла это в отдельную таблицу, тк часто есть поиск по звездам
  deliver_id BIGINT UNSIGNED NOT NULL,
  stars_type enum('1', '2', '3', '4', '5') DEFAULT '1',
  PRIMARY KEY (deliver_id),
  KEY stars_idx (stars_type),
  CONSTRAINT fk_stars_delivers FOREIGN KEY (deliver_id) REFERENCES delivers (id)
);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  deliver_id BIGINT UNSIGNED NOT NULL,
  txt TEXT,
  date_start DATETIME,
  date_end DATETIME,
  sales_type enum('Скидки', 'Счастливые часы', 'Блюдо в подарок', 'Еда за баллы', 'Комбо'),
  PRIMARY KEY (id),
  CONSTRAINT fk_sales_delivers FOREIGN KEY (deliver_id) REFERENCES delivers (id)
 );

DROP TABLE IF EXISTS category_of_dishes;
CREATE TABLE category_of_dishes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  category varchar(45),
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS dishes;
CREATE TABLE dishes (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  deliver_id BIGINT UNSIGNED NOT NULL,
  name VARCHAR(145) NOT NULL,
  category_of_dishes_id INT UNSIGNED NOT NULL, 
  PRIMARY KEY (id, deliver_id),
  CONSTRAINT fk_dishes_category_of_dishes FOREIGN KEY (category_of_dishes_id) REFERENCES category_of_dishes (id),
  CONSTRAINT fk_delivers_id FOREIGN KEY (deliver_id) REFERENCES delivers (id)
);

DROP TABLE IF EXISTS basket; -- здесь не знаю как добавить, что можно добавить продукты только одного ресторана
CREATE TABLE basket (
  user_id BIGINT UNSIGNED NOT NULL,
  dish_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (user_id),
  CONSTRAINT fk_basket_users FOREIGN KEY (user_id) REFERENCES users (id),
  CONSTRAINT fk_basket_dishes FOREIGN KEY (dish_id) REFERENCES dishes (id)
 );
