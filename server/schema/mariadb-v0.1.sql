CREATE TABLE IF NOT EXISTS `customers` (
    `id` SERIAL,
    `customer_name` VARCHAR(200),
    `company_name` VARCHAR(200),
    `phone_number` VARCHAR(150),
    `email_address` VARCHAR(255),
    `street_address` VARCHAR(255),
    `city` VARCHAR(150),
    `state` VARCHAR(150),
    `zip_code` VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS `vehicles` (
    `id` SERIAL,
    `customer_id` BIGINT UNSIGNED REFERENCES customers(id),
    `vin` VARCHAR(200),
    `year` VARCHAR(100),
    `make` VARCHAR(200),
    `model` VARCHAR(200),
    `trim` VARCHAR(200),
    `engine` VARCHAR(200),
    `transmission` VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS `invoices` (
    `id` SERIAL,
    `stage` VARCHAR(150),
    `customer_id` BIGINT UNSIGNED REFERENCES customers(id),
    `vehicle_id` BIGINT UNSIGNED REFERENCES vehicles(id),
    `date` DATE,
    `description` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `invoice_notes` (
    `id` SERIAL,
    `invoice_id` BIGINT UNSIGNED REFERENCES invoices(id),
    `vehicle_miles` INT UNSIGNED,
    `note` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `invoice_lines` (
    `id` SERIAL,
    `invoice_id` BIGINT UNSIGNED REFERENCES invoices(id),
    `product_id` VARCHAR(255),
    `description` VARCHAR(255),
    `price` DECIMAL(10,2),
    `quantity` DECIMAL(10,1),
    `subtotal` DECIMAL(10,2) AS (`price` * `quantity`) PERSISTENT
);

CREATE TABLE IF NOT EXISTS `schedule` (
    `id` SERIAL,
    `invoice_id` BIGINT UNSIGNED,
    `technician` VARCHAR(255),
    `scheduled_time` DATETIME
);

CREATE TABLE IF NOT EXISTS `products` (
    `product_id` VARCHAR(255) PRIMARY KEY,
    `description` VARCHAR(255),
    `track_qty` BOOLEAN,
    `stock_qty` DECIMAL(10,1),
    `current_qty` DECIMAL(10,1)
);

CREATE TABLE IF NOT EXISTS `vendors` (
    `id` SERIAL,
    `vendor_name` VARCHAR(255),
    `phone_number` VARCHAR(150),
    `email_address` VARCHAR(250),
    `street_address` VARCHAR(255),
    `city` VARCHAR(150),
    `state` VARCHAR(150),
    `zip_code` VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS `purchase_orders` (
    `id` SERIAL,
    `vendor_id` BIGINT UNSIGNED REFERENCES vendors(id),
    `date` DATE,
    `description` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `po_lines` (
    `id` SERIAL,
    `po_id` BIGINT UNSIGNED REFERENCES purchase_orders(id),
    `vendor_plu` VARCHAR(255),
    `product_id` VARCHAR(255),
    `description` VARCHAR(255),
    `price` DECIMAL(10,2),
    `quantity` DECIMAL(10,1),
    `subtotal` DECIMAL(10,2) AS (`price` * `quantity`) PERSISTENT
);

CREATE TABLE IF NOT EXISTS `shop_info` (
    `description` VARCHAR(255) PRIMARY KEY,
    `value` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `users` (
    `username` VARCHAR(255),
    `password` VARCHAR(255),
    `role` VARCHAR(255)
);

REPLACE INTO shop_info (`description`, `value`) VALUES ('db_version', '0.1')