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
-- 5 -- comment - оценки ресторанам 1:n
-- 6 -- oredrs - заказы
-- 7 -- sales - акции
-- 8 -- categories_of_dishes - категории блюд 1:n
-- 9 -- dishes - блюда - связано с меню и корзиной
-- 10 -- basket - корзина - здесь можно добавить продукты только одного ресторана

CREATE DATABASE project;
USE project;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(145) NOT NULL,
  last_name VARCHAR(145) NOT NULL,
  email VARCHAR(145) NOT NULL,
  phone CHAR(11) NOT NULL,
  password_hash CHAR(65) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE INDEX email_unique (email),
  UNIQUE INDEX phone_unique (phone)
) ENGINE=InnoDB;


INSERT INTO users
  (first_name, last_name, email, phone, password_hash)
VALUES
  ('Люда','Людовна', 'luda@mail.ru', '89091112233', 'd53c7664fb54b3b20b44dd9d11177d274ba51ea9'),
  ('Геннадий','Геннадьевич', 'gena@mail.ru', '89101112233', '5d3a8a3d2368017f95b47b09c78050a43f2ba445'),
  ('Олег','Олегович', 'oleg@mail.ru', '89121112233', 'd929cbadec935ec22a90d9bd0ed7240d8c2a421b'),
  ('Анна','Анновна', 'anna@mail.ru', '89131112233', '7454047004038414af2da270c34067a9513470a3'),
  ('Борис','Борисович', 'boris@mail.ru', '89141112233', '4e8bf9b310fb0f42d9fe32f4bf7a95128a8686fd'),
  ('Карина', 'Кариновна', 'karina@mail.ru', '89151112233', '1a8514b145d6c0acec1f2840d93832ef81f00c9f')
;

SELECT * FROM users;

DROP TABLE IF EXISTS category_of_delivers;
CREATE TABLE category_of_delivers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  category varchar(45),
  PRIMARY KEY (id)
);

INSERT INTO category_of_delivers
  (category)
VALUES
  ('Суши'), ('Пицца'), ('Русская'), ('Десерты'), ('Бургеры'), ('Фастфуд'), ('Азиатская'), ('Завтраки'), ('Другое')
;

SELECT * FROM category_of_delivers;

DROP TABLE IF EXISTS delivers;
CREATE TABLE delivers (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(145) NOT NULL,
  email VARCHAR(145) NOT NULL,
  url VARCHAR(250) NOT NULL,
  phone CHAR(11) NOT NULL,
  password_hash CHAR(65) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  city VARCHAR(30) NOT NULL,
  street VARCHAR(50) NOT NULL,
  house_number TINYINT UNSIGNED NOT NULL, -- 0/255
  category_of_delivers_id INT UNSIGNED NOT NULL, 
  UNIQUE INDEX name_unique (name),
  UNIQUE INDEX email_unique (email),
  PRIMARY KEY (id),
  KEY category_of_delivers_idx (category_of_delivers_id),
  CONSTRAINT fk_delivers_category_of_delivers FOREIGN KEY (category_of_delivers_id) REFERENCES category_of_delivers (id)
) ENGINE=InnoDB;

INSERT INTO delivers
  (name, url, email, phone, password_hash, city, street, house_number, category_of_delivers_id)
VALUES
  ('Япоша','https://yaposha.com', 'yaposha@mail.ru', '89161112233', '04d31b653c0af9e3797b493e9cdcb88a2f20e816', 'Москва', 'ул. Ясеневская', '11', '1'),
  ('Бест-Пицца','https://best-pizza.ru', 'pizza@mail.ru', '89171112233', 'c1d59b8ddc32136abe074f319a7383c21fea5cf8', 'Санкт-Петербург', 'Невский пр-т', '22', '2'),
  ('Караваевы','https://karavaev.ru', 'brkaravaev@mail.ru', '89181112233', '6ee02b5104c1083a7e66fa34e18ac3eb4c736a93', 'Краснодар', 'ул. Первомайская', '33', '3'),
  ('Shoko','https://desserts.ru', 'shoko-desserts@mail.ru', '89191112233', '23d9f5d91ff477a260e39c9aefbdb9af829d8dc5', 'Самара', 'ул. Ленина', '44', '4'),
  ('Big-burgers','https://bburgers.com', 'bburgers@mail.ru', '89201112233', '64cab9b56259616cc3a6bf2027a63e1ca4d3e3e8','Сочи', 'ул. Приморская', '55', '5'),
  ('Шаурма №1','https://shaurma_n1.com', 'shaurma_n1@mail.ru', '89211112233', 'e5e9f9121a403aba8506f00f348b769abbf6d150','Ростов-на-Дону', 'ул. Пушкинская', '66', '6')
;

SELECT * FROM delivers;

DROP TABLE IF EXISTS adresses; 
CREATE TABLE adresses (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  city VARCHAR(30) NOT NULL,
  street VARCHAR(50) NOT NULL,
  house_number TINYINT UNSIGNED NOT NULL, -- 0/255
  flat_number SMALLINT UNSIGNED DEFAULT NULL, -- 0/65535
  floor_number TINYINT DEFAULT NULL, -- -127/128
  intercom VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY adresses_users_idx (user_id),
  CONSTRAINT fk_adresses_users FOREIGN KEY (user_id) REFERENCES users (id)
 );

INSERT INTO adresses
  (user_id, city, street, house_number, flat_number, floor_number, intercom)
VALUES
  ('1','Сочи', 'ул. Речная', '8', '16', '12', '1121771'),
  ('2','Москва', 'ул. 1905 года', '103', '189', '20', 'в221в334'),
  ('2','Москва', 'ул. Селигерская', '3', NULL, NULL, NULL),
  ('3','Сургут', 'ул. Северная', '9', '15', '2', 'dl45d4545'),
  ('4','Санкт-Петербург', 'Литейный пр-т', '27', '234', '9', '0030073'),
  ('6','Ростов-на-Дону', 'ул. Любая', '8', '1', NULL, NULL)
;

SELECT * FROM adresses;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  deliver_id BIGINT UNSIGNED NOT NULL,
  txt TEXT,
  date_start DATETIME,
  date_end DATETIME,
  sales_type enum('Скидки', 'Счастливые часы', 'Блюдо в подарок', 'Еда за баллы', 'Комбо') NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_sales_delivers FOREIGN KEY (deliver_id) REFERENCES delivers (id)
 );

INSERT INTO sales
  (deliver_id, txt, date_start, date_end, sales_type)
VALUES 
  ('4', 'При покупке десерта кофе в подарок!', '2021-05-01 10:00:00', '2021-05-31 22:00:00', 'Блюдо в подарок'),
  ('6', 'Скидка 20% с 10 до 13!', '2021-07-15 10:00:00', '2021-08-15 23:00:00', 'Счастливые часы'),
  ('1', 'Скидка 10% при покупке большого сета в подарок', '2021-06-02 18:00:00', '2021-06-10 22:00:00', 'Скидки')
;

SELECT * FROM sales;

DROP TABLE IF EXISTS category_of_dishes;
CREATE TABLE category_of_dishes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  deliver_id BIGINT UNSIGNED NOT NULL,
  category VARCHAR(45),
  PRIMARY KEY (id),
  CONSTRAINT fk_category_of_dishes_delivers FOREIGN KEY (deliver_id) REFERENCES delivers (id)
);

INSERT INTO category_of_dishes
  (deliver_id, category)
VALUES
  ('1','Суши'),('1', 'Роллы'), ('1','Сеты'), ('1','Напитки'),
  ('2','Пицца на тонком тесте'),('2', 'Пицца на толстом тесте'),('2', 'Закуски'), ('2','Напитки'),
  ('3','Заврак'), ('3', 'Обед'),('3', 'Ужин'),
  ('4','Кофе'),('4', 'Чай'), ('4','Десерты'), ('4','Другое'),
  ('5','Бургеры'), ('5', 'Картошка'), ('5','Закуски'), ('5', 'Напитки'),
  ('6','Шаурма'),('6', 'Закуски'), ('6', 'Напитки')
;


SELECT * FROM category_of_dishes;

DROP TABLE IF EXISTS dishes;
CREATE TABLE dishes (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  deliver_id BIGINT UNSIGNED NOT NULL,
  name VARCHAR(145) NOT NULL,
  category_of_dishes_id INT UNSIGNED NOT NULL, 
  price SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX deliver_category (deliver_id, category_of_dishes_id),
  CONSTRAINT fk_dishes_category_of_dishes FOREIGN KEY (category_of_dishes_id) REFERENCES category_of_dishes (id),
  CONSTRAINT fk_delivers_id FOREIGN KEY (deliver_id) REFERENCES delivers (id)
);

INSERT INTO dishes
  (deliver_id, name, category_of_dishes_id, price)
VALUES 
  ('1', 'Калифорния', '1', '350'),
  ('2', 'Барбекю', '5', '699'),
  ('3', 'Запеканка', '9', '170'),
  ('4', 'Тарталетка с черникой', '9', '170'),
  ('5', 'Чизбургер', '16', '330'),
  ('6', 'Шаурма с курицей', '20', '140')
;

SELECT * FROM dishes;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  dish_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_basket_users FOREIGN KEY (user_id) REFERENCES users (id),
  CONSTRAINT fk_basket_dishes FOREIGN KEY (dish_id) REFERENCES dishes (id)
 );

INSERT INTO orders
  (user_id, dish_id)
VALUES 
  ('1', '3'), ('2', '5'), ('3', '6'), ('4', '2'), ('5', '1'), ('6', '4')
 ;

SELECT * FROM orders;

DROP TABLE IF EXISTS comment;
CREATE TABLE comment ( 
  id BIGINT UNSIGNED AUTO_INCREMENT,
  deliver_id BIGINT UNSIGNED NOT NULL,
  auther_id BIGINT UNSIGNED NOT NULL,
  txt TEXT DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  stars_type enum('0','1', '2', '3', '4', '5') DEFAULT '0',
  KEY stars_idx (stars_type),
  PRIMARY KEY (id),
  CONSTRAINT fk_comment_delivers FOREIGN KEY (deliver_id) REFERENCES delivers (id),
  CONSTRAINT fk_comment_users FOREIGN KEY (auther_id) REFERENCES users (id)
);

INSERT INTO comment
(deliver_id, auther_id, txt, stars_type)
VALUES 
('3', '1', 'Было невкусно', '2'),
('5', '2', 'Неплохо, но все остыло :(', '3'),
('1', '5', 'Все супер! приду сюда снова!', DEFAULT)
;

SELECT * FROM comment;
