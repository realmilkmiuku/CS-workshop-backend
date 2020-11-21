CREATE USER 'dbuser'@localhost IDENTIFIED BY '12345678’;

GRANT ALL PRIVILEGES ON *.* TO 'dbuser'@localhost IDENTIFIED BY '12345678’; 
//ชื่อ DB และสามารถทำอะไรได้บ้าง

/*
คำสั่ง GRANT และ REVOKE ได้รับการใช้เพื่อให้และถอนสิทธิกับผู้ใช้ MySQL ด้วยสิทธิ 4 ระดับ คือ

Global
Database
Table
Column
คำสั่ง GRANT ใช้สร้างผู้ใช้และให้สิทธิ รูปแบบทั่วไปของคำสั่ง GRANT คือ

GRANT privileges [ column ]
ON item
TO user_name [IDENTIFIED BY ‘ password ' ]
[WITH GRANT OPTION]
*/

FLUSH PRIVILEGES;
/*
คำสั่ง flush privileges คือการสั่งให้ MySQL update ข้อมูลใหม่ที่เราเพิ่ง update เข้าไป

เพียงเท่านี้เราก็สามารถเพิ่มความปลอดภัยให้กับ MySQL Database ของเราได้แล้ว
*/

SELECT user();

system mysql -u dbuser -p

SELECT user();

CREATE DATABASE example;

use example;
// เข้า db example

//รอบ 1
CREATE TABLE products (
    ->  products_id int primary key ถ้ามีหลายอัน ก็ใส่ , 
    -> );

DROP TABLE products; //ลบตาราง
show tables; //โชว์ตาราง

//รอบ 2
CREATE TABLE products (
    -> product_id int Primary key,
    -> product_name varchar(50)
    -> );

#var(50) string 0 - 49  ใส่ข้อมูล
#char 50 String 50 ห้ามขาดห้ามเกิน  
    
show tables;
SELECT * FROM products;
show columns from products;

ALTER TABLE products 
    -> ADD COLUMN product_quantity int,
    -> ADD COLUMN product_price decimal(10,4);
#ALTER การเปลี่ยนแปลงโครงสร้างของ table products

CREATE TABLE product_types (
    -> product_type_id int primary key,
    -> product_type_name varchar(50)
    );

INSERT INTO product_types (product_type_id, product_type_name)
VALUES (1,'Food'), (2, 'Drink');

ALTER TABLE products ADD COLUMN product_product_type_id int 
REFERENCES product_types (product_type_id);
#สร้าง column product_product_type_id เป็น foreign key(คีย์เชื่อมอีกตารางหนึ่ง) อ้างอิงค่าจาก
ตาราง product_types column (product_type_id)

show columns from products;

INSERT INTO products (product_id, 
product_name, 
product_quantity, 
product_price, 
product_product_type_id)

VALUES 
(1, 'Apple' ,5, 12.5, 1),
(2, 'Pine' ,15, 60, 1),
(3, 'Jeally' ,25, 5.5, 1),
(4, 'Cola' ,5, 18, 2),
(5, 'Tea' ,7, 125, 2),
(6, 'Coffee' ,10, 85, 2);

การ JOINT 
SELECT product_name, product_type_name
FROM products
JOIN product_types ON product_product_type_id = product_type_id;

//กรณีไม่แสดงข้อมูล ทำ FK ใหม่ ทำ FKตามนี้
ALTER TABLE products 
ADD CONSTAINT fk_product_product_types
FOREIGN KEY (product_product_type_id)
    REFERENCES product_types (product_type_id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT;

SELECT product_type_name, SUM(product_quantity)
    -> FROM products
    -> JOIN product_types ON product_product_type_id = product_type_id
    -> GROUP BY product_type_name;

//การ แก้ไขข้อมูล
UPDATE products
    -> SET product_name = 'Apple Pine' 
    -> WHERE product_id = 3 ;

