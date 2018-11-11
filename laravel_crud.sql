-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.36-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para laravel_crud
CREATE DATABASE IF NOT EXISTS `laravel_crud` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_romanian_ci */;
USE `laravel_crud`;

-- Volcando estructura para tabla laravel_crud.companies
CREATE TABLE IF NOT EXISTS `companies` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) COLLATE utf8_romanian_ci NOT NULL DEFAULT '',
  `company_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `company_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_romanian_ci;

-- Volcando datos para la tabla laravel_crud.companies: ~11 rows (aproximadamente)
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` (`company_id`, `company_name`, `company_created`, `company_modified`) VALUES
	(1, 'Zara', '2018-11-11 12:17:16', '2018-11-11 12:17:16'),
	(2, 'Sony', '2018-11-11 12:17:25', '2018-11-11 12:17:25'),
	(3, 'Microsoft', '2018-11-11 12:17:36', '2018-11-11 12:17:36'),
	(4, 'Nintendo', '2018-11-11 12:17:46', '2018-11-11 12:17:46'),
	(5, 'Acer', '2018-11-11 12:17:59', '2018-11-11 12:17:59'),
	(6, 'Asus', '2018-11-11 12:18:07', '2018-11-11 12:18:07'),
	(7, 'Toshiba', '2018-11-11 12:18:14', '2018-11-11 12:18:14'),
	(8, 'Apple', '2018-11-11 12:18:20', '2018-11-11 12:18:20'),
	(9, 'Xiaomi', '2018-11-11 12:18:37', '2018-11-11 12:18:37'),
	(10, 'Fender', '2018-11-11 12:18:56', '2018-11-11 12:18:56'),
	(11, 'Ubisoft', '2018-11-11 12:19:09', '2018-11-11 12:19:09'),
	(12, 'Google', '2018-11-11 12:24:12', '2018-11-11 12:24:12');
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;

-- Volcando estructura para tabla laravel_crud.products
CREATE TABLE IF NOT EXISTS `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `product_description` varchar(300) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `product_price` double NOT NULL DEFAULT '0',
  `company_id` int(11),
  `product_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `product_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla laravel_crud.products: ~21 rows (aproximadamente)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`product_id`, `product_name`, `product_description`, `product_price`, `company_id`, `product_created`, `product_modified`) VALUES
	(1, 'Shirt', 'Dark clothes.', 19.95, 1, '2018-11-11 10:23:00', '2018-11-11 10:23:00'),
	(2, 'Xbox one', 'Domestic video game console.', 299.95, 3, '2018-11-11 10:29:17', '2018-11-11 10:29:17'),
	(3, 'Playstation 4', 'Domestic video game console.', 299.95, 2, '2018-11-11 10:29:48', '2018-11-11 10:29:48'),
	(4, 'Nintendo Switch', 'Domestic video game console.', 319.95, 4, '2018-11-11 10:30:21', '2018-11-11 10:30:21'),
	(5, 'Xiaomi redmi 5 plus', 'Personal mobile device.', 199.95, 9, '2018-11-11 10:32:28', '2018-11-11 10:32:28'),
	(6, 'Acer Laptop', 'Personal laptop made by Acer.', 899.95, 5, '2018-11-11 10:33:31', '2018-11-11 10:33:31'),
	(7, 'Google Nexus 5', 'Personal mobile device made by Google.', 249.95, 12, '2018-11-11 10:35:36', '2018-11-11 10:35:36'),
	(8, 'Google Nexus 4', 'Personal mobile device made by Google.', 149.95, 12, '2018-11-11 10:35:36', '2018-11-11 10:35:36'),
	(9, 'Asus Laptop', 'Personal laptop made by Asus.', 799.95, 6, '2018-11-11 10:33:31', '2018-11-11 10:33:31'),
	(10, 'Playstation 3', 'Domestic video game console.', 94.95, 2, '2018-11-11 10:29:48', '2018-11-11 10:29:48'),
	(11, 'Xbox 360', 'Domestic video game console.', 99.95, 3, '2018-11-11 10:29:17', '2018-11-11 10:29:17'),
	(12, 'Nintendo Wii U', 'Domestic video game console.', 299.95, 4, '2018-11-11 10:30:21', '2018-11-11 10:30:21'),
	(13, 'Xiaomi MI A1', 'Personal mobile device.', 199.95, 9, '2018-11-11 10:32:28', '2018-11-11 10:32:28'),
	(14, 'Shoes', 'Dark clothes.', 39.95, 1, '2018-11-11 10:23:00', '2018-11-11 10:23:00'),
	(15, 'Toshiba Laptop', 'Personal laptop made by Toshiba.', 1299.95, 7, '2018-11-11 10:33:31', '2018-11-11 10:33:31'),
	(16, 'UNO card game', 'Card game.', 9.99, 11, '2018-11-11 10:33:31', '2018-11-11 10:33:31'),
	(17, 'Fender guitar', 'Musical instrument.', 499.95, 10, '2018-11-11 10:33:31', '2018-11-11 10:33:31'),
	(18, 'Fender bass', 'Musical instrument.', 559.95, 10, '2018-11-11 10:33:31', '2018-11-11 10:33:31'),
	(19, 'Nintendo Wii', 'Domestic video game console.', 99.95, 4, '2018-11-11 10:30:21', '2018-11-11 10:30:21'),
	(20, 'Apple Laptop', 'Personal laptop made by Apple.', 1599.95, 8, '2018-11-11 10:33:31', '2018-11-11 10:33:31'),
	(21, 'Playstation 2', 'Domestic video game console.', 59.95, 2, '2018-11-11 10:29:48', '2018-11-11 10:29:48');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
