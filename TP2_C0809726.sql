--UDAI SHANKAR RARIA, STUDENT NUMBER: C0809726
-- PROFESSOR: JIM COOPER
-- DATABASE TERM PROJECT-1 : Dextrous Popcorn Makers



-----------DROP TABLES-----------------
DROP TABLE PRODUCTS;
DROP TABLE ORDERS;
DROP TABLE WAREHOUSES;
DROP TABLE WAREHOUSE_PRODUCTS;
DROP TABLE BRANDS;
DROP TABLE COLORS;
DROP TABLE ASSOCIATES;
DROP TABLE CUSTOMERS;
DROP TABLE MODELS;
DROP TABLE ADDRESSES;
DROP SEQUENCE order_id_seq;
DROP TABLE MATERIAL;
DROP TABLE TECHNOLOGY;
DROP TABLE INVOICE;

------- CREATE SEQUENCE------------
CREATE OR REPLACE SEQUENCE order_id_seq
START WITH 1000
INCREMENT BY 1
MAXVALUE 999999
NO CACHE 
NO CYCLE ;

------ CREATE TABLES----------
CREATE TABLE PRODUCTS(
product_id INTEGER NOT NULL,          --PK
type_id VARCHAR(50) NOT NULL,
brand_id VARCHAR(50) NOT NULL,        --FK
model_id VARCHAR (50) NOT NULL ,      --FK
color_id VARCHAR(50) NOT NULL         --FK
);

CREATE TABLE ORDERS(
product_id INTEGER NOT NULL,         --PK/FK
customer_id INTEGER NOT NULL,        --PK/FK
order_id INTEGER NOT NULL,           --FK
order_date DATE NOT NULL,
quantity INTEGER NOT NULL,           
associate_id INTEGER NOT NULL         --FK
);

CREATE TABLE WAREHOUSES(
warehouse_id INTEGER NOT NULL,        --PK
warehouse_location VARCHAR (50) NOT NULL,
stock_availability INTEGER NOT NULL);

CREATE TABLE WAREHOUSE_PRODUCTS(
warehouse_id INTEGER NOT NULL,       --PK/FK
product_id INTEGER NOT NULL);        --PK/FK

CREATE TABLE BRANDS(
brand_id VARCHAR(50) NOT NULL );      --PK

CREATE TABLE COLORS(
color_id VARCHAR (50) NOT NULL,       --PK
product_color VARCHAR (50) NOT NULL);

CREATE TABLE ASSOCIATES(
associate_id INTEGER NOT NULL,        --PK
associate_name VARCHAR (50) NOT NULL);

CREATE TABLE CUSTOMERS(
customer_id INTEGER NOT NULL
GENERATED ALWAYS AS IDENTITY 
(START WITH 100 INCREMENT BY 10),     --PK
customer_name VARCHAR (50) NOT NULL,
address_id INTEGER NOT NULL);         --FK

CREATE TABLE MODELS(
model_id VARCHAR (50) NOT NULL,       --PK
blade_span DECIMAL(5,2),
motor VARCHAR (50) NOT NULL, 
speed VARCHAR (50) DEFAULT '2000',
serial_num INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY 
(START WITH 9000 INCREMENT BY 1),     --UK
unit_price DECIMAL(5,2) NOT NULL,
warranty VARCHAR (50) NOT NULL,
rating INTEGER NOT NULL,
description VARCHAR (500));

CREATE TABLE ADDRESSES(
address_id INTEGER NOT NULL,          --PK
house_num INTEGER NOT NULL, 
street_name VARCHAR(50) NOT NULL,
state VARCHAR(50) NOT NULL,
zip VARCHAR(50) NOT NULL);

CREATE TABLE INVOICE 
(invoice_id INTEGER NOT NULL,         --PK
start_date VARCHAR(50) NOT NULL,
end_date VARCHAR(50) NOT NULL
);

CREATE TABLE MATERIAL 
(material_id VARCHAR (40) NOT NULL,   --PK
build_material VARCHAR (40) NOT NULL,
kettle_material VARCHAR (40) NOT NULL);

CREATE TABLE technology
(technology_id INTEGER NOT NULL,
name VARCHAR (40) NOT NULL);

------Primary keys--------------
ALTER TABLE PRODUCTS 
ADD CONSTRAINT products_pk
PRIMARY KEY (product_id);

ALTER TABLE WAREHOUSES 
ADD CONSTRAINT warehouses_pk
PRIMARY KEY (warehouse_id);

ALTER TABLE BRANDS 
ADD CONSTRAINT brands_pk
PRIMARY KEY (brand_id);

ALTER TABLE COLORS 
ADD CONSTRAINT colors_pk
PRIMARY KEY (color_id);

ALTER TABLE ASSOCIATES 
ADD CONSTRAINT associates_pk
PRIMARY KEY (associate_id);

ALTER TABLE CUSTOMERS 
ADD CONSTRAINT customers_pk
PRIMARY KEY (customer_id);

ALTER TABLE MODELS 
ADD CONSTRAINT models_pk
PRIMARY KEY (model_id);

ALTER TABLE ADDRESSES 
ADD CONSTRAINT addresses_pk
PRIMARY KEY (address_id);

ALTER TABLE ORDERS 
ADD CONSTRAINT orders_pk
PRIMARY KEY (product_id, customer_id);

ALTER TABLE WAREHOUSE_PRODUCTS 
ADD CONSTRAINT warehouse_products_pk
PRIMARY KEY (warehouse_id, product_id);

----------Unique keys------------------------------------
ALTER TABLE MODELS 
ADD CONSTRAINT models_serial_num_uk
UNIQUE (serial_num);

------------Foreign keys------------------------------------
ALTER TABLE PRODUCTS 
ADD CONSTRAINT products_brand_id_fk
FOREIGN KEY (brand_id) REFERENCES BRANDS(brand_id);

ALTER TABLE PRODUCTS 
ADD CONSTRAINT products_model_id_fk
FOREIGN KEY (model_id) REFERENCES MODELS(model_id);

ALTER TABLE PRODUCTS 
ADD CONSTRAINT products_color_id_fk
FOREIGN KEY (color_id) REFERENCES COLORS(color_id);

ALTER TABLE ORDERS 
ADD CONSTRAINT orders_associate_id_fk
FOREIGN KEY (associate_id) REFERENCES associates(associate_id);

ALTER TABLE CUSTOMERS 
ADD CONSTRAINT customers_address_id_fk
FOREIGN KEY (address_id) REFERENCES addresses(address_id);

--------------Adding concatenated keys--------------
ALTER TABLE ORDERS 
ADD CONSTRAINT orders_product_id_fk
FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE ORDERS 
ADD CONSTRAINT orders_customer_id_fk
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE WAREHOUSE_PRODUCTS 
ADD CONSTRAINT warehouse_products_warehouse_id_fk 
FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id);

ALTER TABLE WAREHOUSE_PRODUCTS 
ADD CONSTRAINT warehouse_products_product_id_fk 
FOREIGN KEY (product_id) REFERENCES products(product_id);


-------------------CHECK constraints--------------------

ALTER TABLE WAREHOUSES 
ADD CONSTRAINT warehouses_stock_availability_ck
CHECK (stock_availability > 50);


ALTER TABLE ADDRESSES 
ADD CONSTRAINT addresses_state_ck
CHECK (state NOT IN ('Hawaii'));


ALTER TABLE COLORS 
ADD CONSTRAINT colors_product_color_ck
CHECK (product_color IN ('Black','White','Gold','Blue','Brown'));


---------------------INSERT VALUES------------------
--populate warehouse table
INSERT INTO WAREHOUSES VALUES
(101,'Delaware',55),
(102,'georgia',70),
(103,'Colarado',80),
(104,'California',125),
(105,'Texas',100);

--populate brand table
INSERT INTO BRANDS VALUES
('kedar'),
('Dextrous'),
('Infrared'),
('cooljet'),
('Bigblade');

--populate color table
INSERT INTO COLORS VALUES
('#00416A','Black'),
('#bdc3c7','White'),
('#ee9ca7','Gold'),
('#2193b0', 'Blue'),
('#FBD786','Brown');

--populate associate table
INSERT INTO ASSOCIATES VALUES
(201,'John curtis'),
(202,'Harry Joshua'),
(203,'Stipe Miocic');


--populate model table
INSERT INTO MODELS VALUES
('DX-908',53,'150 watts','2500 rpm',DEFAULT ,98.00,'2 years',4,'Good performance with low wattage best suited for indoor use'),
('DX-328',60,'200 watts','3200 rpm',DEFAULT,120.00,'3 years',4,'Speed and style at medium wattage best for medium usage'),
('DX-329',70,'220 watts','3500 rpm',DEFAULT,180.00,'4 years',5,'powerful with high wattage, usage suits bigger rooms'),
('DX-330',75,'320 watts','4100 rpm',DEFAULT,220.00,'4 years',5,'speedy and smart tech, used mostly for commercial purpose'),
('DX-331',80,'231 watts','3800 rpm',DEFAULT,380.00,'5 years',5,'Powerful and smart tech, used in very huge rooms');

--populate product table
INSERT INTO PRODUCTS VALUES
(701,'bpa material','kedar','DX-908','#00416A' ),
(702,'kettle material','Dextrous','DX-328','#bdc3c7'),
(703,'aluminum material','Infrared','DX-329','#bdc3c7'),
(704,'dextrous batteries','cooljet','DX-330','#ee9ca7'),
(705,'koolaid','cooljet','DX-330','#ee9ca7'),
(706,'Popcorn kettles','Bigblade','DX-331','#2193b0'),
(707,'Popcorn trays','kedar','DX-331','#2193b0'),
(708,'Cables','Dextrous','DX-908','#FBD786'),
(709,'Oilless cookers','cooljet','DX-331','#FBD786'),
(710,'Cooler fan','Dextrous','DX-908','#00416A');


--populate warehouse_product table
INSERT INTO WAREHOUSE_PRODUCTS VALUES
(101,701),
(102,701),
(103,701),
(104,701),
(105,701);

--populate address table
INSERT INTO ADDRESSES VALUES
(501,2845,'Westland','Michigan',48326),
(502,1234,'London Road','Michigan',48126),
(503,5846,'Paris','Michigan',48145),
(504,784,'Texas','Michigan',48084),
(505,156,'Maurisius','Michigan',48125);

--populate customer table
INSERT INTO CUSTOMERS VALUES
(DEFAULT,'Staalen Vales',501 ),
(DEFAULT,'Ridge Dampere',502),
(DEFAULT,'Lukas Pedricas',503),
(DEFAULT,'Udai Shankar',504),
(DEFAULT,'Krish Rawat',505);

--populate order table
INSERT INTO ORDERS (PRODUCT_ID,CUSTOMER_ID,ORDER_ID, ORDER_DATE, QUANTITY, ASSOCIATE_ID) VALUES
(701,100 ,NEXT VALUE FOR order_id_seq,'2021-02-20',20,201),
(701,110 ,NEXT VALUE FOR order_id_seq,'2021-02-13',39,202),
(702,120 ,NEXT VALUE FOR order_id_seq,'2021-02-09',58,203),
(702,130 ,NEXT VALUE FOR order_id_seq,'2021-02-01',12,202),
(703,140 ,NEXT VALUE FOR order_id_seq,'2021-02-28',54,201),
(703,100 ,NEXT VALUE FOR order_id_seq,'2021-02-15',7,203),
(704,110 ,NEXT VALUE FOR order_id_seq,'2021-02-14',10,201),
(704,120 ,NEXT VALUE FOR order_id_seq,'2021-02-15',9,202),
(705,130 ,NEXT VALUE FOR order_id_seq,'2021-02-16',11,203),
(705,140 ,NEXT VALUE FOR order_id_seq,'2021-02-22',00,201);

--populate into inovice table
INSERT INTO INVOICE VALUES
('990', '21-01-2012', '23-02-2013'),
('991', '21-02-2012', '23-03-2013'),
('992', '21-05-2012', '23-07-2013'),
('993', '21-04-2012', '23-08-2013');

--populate into material
INSERT INTO MATERIAL VALUES
('900', 'YES', 'NO'),
('901', 'YES', 'NO'),
('902', 'YES', 'NO'),
('903', 'YES', 'NO'),
('904', 'YES', 'NO');

--POPULATE INTO TECHNOLOGY 
INSERT INTO TECHNOLOGY VALUES
(112, 'ALT'),
(134, 'RHY'),
(345, 'HGF'),
(56, 'JH'),
(78, 'JK');


----------------------Constraint testing-------------------

--01
--CHECK CONSTRAINT test
--Description: CHECK Constraint will not allow stock_availability column to be less than 50
--Expected Results : Insertion will not be allowed
INSERT INTO (warehouse_id,warehouse_location,stock_availability) WAREHOUSES VALUES
(123,'mexico',30);
--Actual Results:
--SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.


--02
--CHECK CONSTRAINT test
--Description: CHECK constraint will not allow "Hawaii" to be entered into state field
--Expected Results : Insertion will not be allowed
INSERT INTO ADDRESSES (address_id,house_num,street_name,state,zip) VALUES
(523,95,'denamrk St #V104','Hawaii',96707);
--Actual Results:
--SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.

--03
--CHECK CONSTRAINT test
--Description: CHECK constraint will NOT allow any color other than 'Black','White','Gold','Blue','Brown'
--Expected Results : Insertion will not be allowed
INSERT INTO COLORS (color_id,product_color) VALUES
('#00421A','Yellow');
--Actual Results:
--SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.


--04
--Constraint NOT NULL test
--Description: checking NOT NULL constraint
--Expected Results : NULL values insertion will not be allowed
INSERT INTO WAREHOUSES (warehouse_id,warehouse_location,stock_availability) VALUES
(108,'sarnia',NULL);
--Actual Results:
--SQL Error [23502]: [SQL0407] Null values not allowed in column or variable STOCK_AVAILABILITY.

--05
--Constraint DEFAULT test
--Description: Checking DEFAULT constraint
--Expected Results : Insertion will not be allowed
INSERT INTO ASSOCIATES (associate_id,associate_name) VALUES
(DEFAULT,'John Fury');
--Actual Results:
--SQL Error [23502]: [SQL0407] Null values not allowed in column or variable ASSOCIATE_ID.

--06
--Constraint Primary Key test
--Description: Check for duplicate value in primary key
--Expected Results : Insertion will not be allowed
INSERT INTO PRODUCTS (product_id,type_id,brand_id,model_id,color_id) VALUES
(701,'standard ceiling fan','Mega','DX-328','#00416A' );
--Actual Results:
--SQL Error [23505]: [SQL0803] Duplicate key value specified.

--07
--Constraint DEFAULT test
--Description: Checking to insert a different data into customer_id which should be generated always
--Expected Results : Insertion will not be allowed
INSERT INTO CUSTOMERS VALUES
(500,'Rahul',501);
--Actual Results:
--SQL Error [428C9]: [SQL0798] Value cannot be specified for GENERATED ALWAYS column CUSTO00001.

--08
--Constraint Unique Key test and default test
--Description: Checking to insert a different data into serial_num which should be generated as default
--Expected Results : Insertion will not be allowed
INSERT INTO MODELS (model_id,blade_span,motor,speed,serial_num,unit_price,warranty,rating,review) VALUES
('DX-328',53,'200 watts','2000 rpm',500,100.00,'3 years',5,'Good performance');
--Actual Results:
--SQL Error [428C9]: [SQL0798] Value cannot be specified for GENERATED ALWAYS column SERIAL_NUM.

--09
--Constraint Foriegn Key test
--Description: Checking for Foreign Key constraint on TP_PRODUCTS_MODEL_ID_FK
--Expected Results : Insertion will not be allowed
INSERT INTO PRODUCTS (product_id,type_id,brand_id,model_id,color_id) VALUES
(721,'kettle material','Mega','DX-328','#00416A' );
--Actual Results:
--SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint TP_PRODUCTS_MODEL_ID_FK in IBM7121.

---CREATING VIEWS ---------------




-- QUERY ALL THE TABLES
SELECT CUST.CUSTOMER_NAME ,
ord.ORDER_DATE ,
ord.ORDER_ID,
prod.PRODUCT_ID AS "PART_CODE",
ord.QUANTITY AS "NUM_ORDERED",
models.UNIT_PRICE ,
models.DESCRIPTION 
FROM CUSTOMERS cust
JOIN ORDERS ord
ON cust.CUSTOMER_ID = ord.CUSTOMER_ID 
JOIN PRODUCTS prod 
ON ord.PRODUCT_ID = PROD.PRODUCT_ID 
JOIN MODELS models
ON prod.MODEL_ID = models.MODEL_ID ;

--CREATING VIEWS WEB1V
CREATE OR REPLACE VIEW WEB1V (CUSTOMER_NAME, ORDER_DATE, ORDER_ID, 
PRODUCT_ID, QUANTITY, UNIT_PRICE, DESCRIPTION) AS
  SELECT CUST.CUSTOMER_NAME ,
  ord.ORDER_DATE ,
  ord.ORDER_ID,
  prod.PRODUCT_ID AS "PART_CODE",
  ord.QUANTITY AS "NUM_ORDERED",
  models.UNIT_PRICE  AS "QUOTED_PRICE",
  models.DESCRIPTION 
  FROM CUSTOMERS cust
  JOIN ORDERS ord
  ON cust.CUSTOMER_ID = ord.CUSTOMER_ID 
  JOIN PRODUCTS prod 
  ON ord.PRODUCT_ID = PROD.PRODUCT_ID 
  JOIN MODELS models
  ON prod.MODEL_ID = models.MODEL_ID ;

SELECT * 
FROM WEB1V
ORDER BY customer_name desc;


--CREATING VIEW WEB2V
CREATE OR REPLACE VIEW WEB2V (CUSTOMER_NAME, ORDER_DATE, ORDER_NUMBER, PRODUCT_ID, 
DESCRIPTION, QUANTITY_ORDERED,PRICE, EXTENDED_PRICE) AS
SELECT CUST.CUSTOMER_NAME, ORD.ORDER_DATE , ORD.ORDER_ID , PROD.PRODUCT_ID ,
MODELS.DESCRIPTION , ORD.QUANTITY , MODELS.UNIT_PRICE , MODELS.UNIT_PRICE* ORD.QUANTITY 
FROM CUSTOMERS CUST
JOIN ORDERS ORD
ON CUST.CUSTOMER_ID = ORD.CUSTOMER_ID 
JOIN PRODUCTS PROD
ON ORD.PRODUCT_ID = PROD.PRODUCT_ID 
JOIN MODELS MODELS
ON PROD.MODEL_ID = MODELS.MODEL_ID ;

SELECT *
FROM WEB2V
ORDER BY ORDER_DATE ,ORDER_NUMBER ,PRODUCT_ID ;


--CREATING VIEW WEB3V
CREATE OR REPLACE VIEW WEB3V (CUSTOMER_NAME, ORDER_ID, ORDER_TOTAL) AS
SELECT CUST.CUSTOMER_NAME ,ORD.ORDER_ID , ORD.QUANTITY * MODELS.UNIT_PRICE 
FROM CUSTOMERS CUST
JOIN ORDERS ORD 
ON CUST.CUSTOMER_ID = ORD.CUSTOMER_ID
JOIN PRODUCTS PROD 
ON ORD.PRODUCT_ID  = PROD.PRODUCT_ID 
JOIN MODELS MODELS
ON PROD.MODEL_ID = MODELS.MODEL_ID ;


SELECT *
FROM WEB3V
ORDER BY CUSTOMER_NAME ,ORDER_TOTAL DESC;




