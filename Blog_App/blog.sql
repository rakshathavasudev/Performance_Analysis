-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 27, 2019 at 03:57 PM
-- Server version: 5.7.23
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blog`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `spCreateBlog`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spCreateBlog` (IN `p_title` VARCHAR(45), IN `p_content` VARCHAR(5000))  BEGIN
    insert into tbl_blog(
        title,
        content
    )
    values
    (
        p_title,
        p_content
      
    );
END$$

DROP PROCEDURE IF EXISTS `spGetBlogbyname`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetBlogbyname` (IN `p_blogname` VARCHAR(45))  BEGIN
select * from tbl_blog where title = p_blogname;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_blog`
--

DROP TABLE IF EXISTS `tbl_blog`;
CREATE TABLE IF NOT EXISTS `tbl_blog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `content` varchar(5000) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_blog`
--

INSERT INTO `tbl_blog` (`id`, `title`, `content`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, '2019-04-27 15:03:29', '2019-04-27 15:03:29'),
(2, NULL, NULL, '2019-04-27 15:05:36', '2019-04-27 15:05:36'),
(4, 'First', 'First addition', '2019-04-27 15:22:59', '2019-04-27 15:22:59'),
(5, 'testing', 'The api being tested', '2019-04-27 15:49:08', '2019-04-27 15:49:08'),
(6, 'Spooky', 'Spooky at a distance', '2019-04-27 15:50:16', '2019-04-27 15:50:16'),
(7, 'Blackhole', 'Blackhole first image is taken', '2019-04-27 15:52:08', '2019-04-27 15:52:08');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
