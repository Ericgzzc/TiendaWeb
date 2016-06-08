-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 26, 2015 at 02:24 PM
-- Server version: 5.5.32
-- PHP Version: 5.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tiendav`
--
CREATE DATABASE IF NOT EXISTS `tiendav` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `tiendav`;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `email`, `password`) VALUES
(1, 'eric@gmail.com', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='contains product categories, e.g., dairy, meats, etc.' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'peliculas'),
(2, 'ropa'),
(3, 'dispositivos'),
(4, 'casa');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='maintains customer details' AUTO_INCREMENT=12 ;

--
-- Dumping data for table `customer`
--


-- --------------------------------------------------------

--
-- Table structure for table `customer_order`
--

DROP TABLE IF EXISTS `customer_order`;
CREATE TABLE IF NOT EXISTS `customer_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `amount` decimal(6,2) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `confirmation_number` int(10) unsigned NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_customer_order_customer` (`customer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='maintains customer order details' AUTO_INCREMENT=10 ;

--
-- Dumping data for table `customer_order`


-- --------------------------------------------------------

--
-- Table structure for table `ordered_product`
--

DROP TABLE IF EXISTS `ordered_product`;
CREATE TABLE IF NOT EXISTS `ordered_product` (
  `customer_order_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `quantity` smallint(5) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`customer_order_id`,`product_id`),
  KEY `fk_ordered_product_customer_order` (`customer_order_id`),
  KEY `fk_ordered_product_product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `ordered_product`
--


-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(5,2) NOT NULL,
  `description` tinytext COLLATE utf8_unicode_ci,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `category_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_category` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='contains product details' AUTO_INCREMENT=22 ;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `price`, `description`, `last_update`, `category_id`) VALUES
(1, 'avengers', '1.70', 'Avengers ', '2015-11-24 11:52:27', 1),
(2, 'prestige', '2.39', 'Los trucos de un mago', '2015-11-24 11:52:30', 1),
(3, 'batman', '1.09', 'Batman la Trilogia', '2015-11-24 11:52:32', 1),
(4, 'moon', '1.76', 'Hombre en la luna', '2015-11-24 11:52:35', 1),
(5, 'camisa', '2.29', 'Camisa, chica, mediana grande', '2015-11-24 11:52:37', 2),
(6, 'playera', '3.49', 'chica, mediana grande', '2015-11-24 11:52:39', 2),
(7, 'pantalon', '2.59', 'Pantalon mezclilla', '2015-11-24 11:52:50', 2),
(8, 'zapatos', '3.55', 'negros', '2015-11-24 11:52:54', 2),
(9, 'computadora', '1.89', 'HP Escritorio', '2015-11-24 11:53:03', 3),
(10, 'laptop', '1.19', 'Dell Inspiron', '2015-11-24 11:53:06', 3),
(11, 'ipod', '1.15', 'Ipod 4G', '2015-11-24 11:53:13', 3),
(12, 'television', '2.39', 'Television 40"', '2015-11-24 11:53:18', 3),
(13, 'sillon', '1.59', 'Sillon de piel', '2015-11-24 11:53:21', 4),
(14, 'silla', '2.49', 'Silla outdoors', '2015-11-24 11:53:24', 4),
(15, 'mesa', '1.29', 'Mesa 4 personas', '2015-11-24 11:53:27', 4),
(16, 'cafetera', '1.49', 'Mesa para cafe', '2015-11-24 11:53:33', 4),
(21, 'pelicula', '12.00', NULL, '2015-11-26 13:03:08', 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer_order`
--
ALTER TABLE `customer_order`
  ADD CONSTRAINT `fk_customer_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `ordered_product`
--
ALTER TABLE `ordered_product`
  ADD CONSTRAINT `fk_ordered_product_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ordered_product_customer_order` FOREIGN KEY (`customer_order_id`) REFERENCES `customer_order` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `fk_product_category1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
