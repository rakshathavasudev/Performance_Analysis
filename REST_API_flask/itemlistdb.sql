-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 29, 2019 at 03:33 PM
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
-- Database: `itemlistdb`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `spCreateUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spCreateUser` (IN `p_Username` VARCHAR(50), IN `p_Useremail` VARCHAR(50), IN `p_Password` VARCHAR(50))  BEGIN

if ( select exists (select 1 from tblUser where UserName = p_username) ) THEN

    select 'Username Exists !!';

ELSE

insert into tblUser
(
    UserName,
    UserEmail,
    Password
)
values
(
    p_Username,
    p_UserEmail,
    p_Password
);

END IF;

END$$

DROP PROCEDURE IF EXISTS `spDeleteUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDeleteUser` (IN `p_Username` VARCHAR(50), IN `p_password` VARCHAR(50))  BEGIN 
if(select exists(select 1 from tbluser where UserName=p_username)) THEN
    DELETE FROM tbluser WHERE UserName = p_Username;
    select 'User deleted';
    
    
ELSE
	select 'User not found';
END IF;
END$$

DROP PROCEDURE IF EXISTS `spGetUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetUser` (IN `p_username` VARCHAR(50))  BEGIN
    select * from tbluser where UserName = p_username; 
END$$

DROP PROCEDURE IF EXISTS `spUpdateUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spUpdateUser` (IN `p_Username` VARCHAR(50), IN `p_Password` VARCHAR(50))  BEGIN

if(select exists(select 1 from tbluser where Username=p_username)) THEN

	UPDATE tbluser SET password = p_Password 
	WHERE UserName = p_Username; 
ELSE
	select 'User not found';
    
END IF;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbluser`
--

DROP TABLE IF EXISTS `tbluser`;
CREATE TABLE IF NOT EXISTS `tbluser` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(45) DEFAULT NULL,
  `UserEmail` varchar(45) DEFAULT NULL,
  `Password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbluser`
--

INSERT INTO `tbluser` (`UserId`, `UserName`, `UserEmail`, `Password`) VALUES
(1, 'Rakshatha Vasudev', 'rakshathavasudev@gmail.com', 'rakshatha'),
(2, 'Shamitha', 'shamitha@gmail.com', 'shamitha'),
(3, 'Shvani', 'shivani@gmail.com', 'shivani'),
(4, 'Swaroopa', 'swaroopa@gmail.com', 'swaroopa'),
(5, 'Apoorva.M.K', 'apoorva@gmail.com', 'apoorva'),
(6, 'Goutami Salunke', 'goutamisalunke@gmail.com', 'goutami');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
