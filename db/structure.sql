CREATE DATABASE  IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mydb`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	5.7.20-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `art`
--

DROP TABLE IF EXISTS `art`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `art` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(45) NOT NULL,
  `Artist` varchar(45) NOT NULL,
  `Year Produced` int(11) NOT NULL,
  `Style` varchar(45) NOT NULL,
  `Medium` varchar(45) NOT NULL,
  `Provenance` varchar(100) DEFAULT NULL,
  `Show` varchar(45) NOT NULL,
  `In Stoage` varchar(45) NOT NULL,
  `UUID` varchar(45) DEFAULT NULL,
  `Museum_idMuseum` int(11) NOT NULL,
  `Room_Room Name` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`,`Room_Room Name`),
  KEY `fk_Art_Museum1_idx` (`Museum_idMuseum`),
  KEY `fk_Art_Room1_idx` (`Room_Room Name`),
  CONSTRAINT `fk_Art_Museum1` FOREIGN KEY (`Museum_idMuseum`) REFERENCES `museum` (`idMuseum`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Art_Room1` FOREIGN KEY (`Room_Room Name`) REFERENCES `room` (`Room Name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `art`
--

LOCK TABLES `art` WRITE;
/*!40000 ALTER TABLE `art` DISABLE KEYS */;
INSERT INTO `art` (`ID`, `Title`, `Artist`, `Year Produced`, `Style`, `Medium`, `Provenance`, `Show`, `In Stoage`, `UUID`, `Museum_idMuseum`, `Room_Room Name`) VALUES (1,'Mural','Jackson Pollock',1943,'Abstract Expressionism','Oil Paint',' University of Iowa Museum of Art','Pollock','No','3d4083ea-be58-11e7-abc4-cec278b6b50a',1,''),(2,'Going West','Jackson Pollock',1934,'Expressionism','oil, fiberboard',NULL,'Pollock','No','c30349ae-be58-11e7-abc4-cec278b6b50a',1,''),(3,'Number 5','Jackson Pollock',1948,'Abstract','Oil Paint',NULL,'Pollock','No','fe01218e-be58-11e7-abc4-cec278b6b50a',1,''),(4,'Blue poles (Number 11)','Jackson Pollock',1952,'Action painting','enamel, canvas','National Gallery of Australia (NGA), Canberra, Australia','Pollock','No','380e03d8-be59-11e7-abc4-cec278b6b50a',1,''),(5,'Number 1 (Lavender Mist)','Jackson Pollock',1950,'Action painting','Oil Paint',NULL,'Pollock','No','719795e2-be59-11e7-abc4-cec278b6b50a',1,''),(6,'Glass Words Material Described','Joseph Kosuth',1965,'Conceptual Art','Mixed Media',NULL,'Conceptual','No','b35334be-be59-11e7-abc4-cec278b6b50a',1,''),(7,'Clock (One and Five)','Joseph Kosuth',1965,'Conceptual Art','Mixed Media',NULL,'Conceptual','No','d97b838a-be59-11e7-abc4-cec278b6b50a',1,''),(8,'One and Three Chairs','Joseph Kosuth',1965,'Conceptual Art','Mixed Media',NULL,'Conceptual','No','03dae436-be5a-11e7-abc4-cec278b6b50a',1,''),(9,'Four Colors Four Words','Joseph Kosuth',1966,'Conceptual Art','Mixed Media',NULL,'Conceptual','No','32bf06ce-be5a-11e7-abc4-cec278b6b50a',1,''),(10,'Titled (Art as Idea as Idea) (Water)','Joseph Kosuth',1966,'Conceptual Art','Mixed Media','Solomon R. Guggenheim Museum, New York City, NY, US ','Conceptual','No','730fceb6-be5a-11e7-abc4-cec278b6b50a',1,''),(11,'Five Words in Green Neon','Joseph Kosuth',1965,'Conceptual Art','Mixed Media',NULL,'Conceptual','No','a432ed48-be5a-11e7-abc4-cec278b6b50a',1,''),(12,'Rain (Study)','Agnes Martin',1960,'Color Field Painting','Oil',NULL,'No','No','41efb10e-be62-11e7-abc4-cec278b6b50a',1,''),(13,'Untitled','Agnes Martin',1959,'Color Field Painting','Oil',NULL,'No','No','6668e078-be62-11e7-abc4-cec278b6b50a',1,''),(14,'Red Bird','Agnes Martin',1964,'Minimalism','pencil, ink, paper',' Museum of Modern Art (MoMA), New York City, NY, US ','No','Yes','ab3a5d62-be62-11e7-abc4-cec278b6b50a',1,''),(15,'Black Lines 1','Georgia O\'Keeffe',1916,'Abstract Art','Oil',NULL,'No','No','fed7acc2-be62-11e7-abc4-cec278b6b50a',1,''),(16,'Music Pink and Blue','Georgia O\'Keeffe',1918,'Abstract Art, Precisionism','Oil',NULL,'No','No','28181446-be63-11e7-abc4-cec278b6b50a',1,''),(17,'100 Cans','Andy Warhol',1962,'Pop Art','Oil','Albright-Knox Art Gallery, Buffalo, NY, US ','No','Yes','7ab22160-be63-11e7-abc4-cec278b6b50a',1,''),(18,'Elvis I & II','Andy Warhol',1963,'Pop Art','Oil',NULL,'No','No','9d39050a-be63-11e7-abc4-cec278b6b50a',1,''),(19,'Big Campbell\'s Soup Can 19c (Beef Noodle)','Andy Warhol',1962,'Pop Art','Oil',NULL,'No','Yes','c34c7ba0-be63-11e7-abc4-cec278b6b50a',1,''),(20,'Marilyn Monroe','Andy Warhol',1968,'Pop Art','Oil',NULL,'No','No','e9224774-be63-11e7-abc4-cec278b6b50a',1,'');
/*!40000 ALTER TABLE `art` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `SSN` int(11) NOT NULL,
  `Position` varchar(45) NOT NULL,
  `Birth Date` varchar(45) NOT NULL,
  `Pay` int(11) NOT NULL,
  `Start Date` varchar(45) NOT NULL,
  `People_ID1` int(11) NOT NULL,
  `User_Name` varchar(45) DEFAULT NULL COMMENT 'First and Last name (First_Last)',
  `Sesion_Token` decimal(65,0) unsigned zerofill NOT NULL,
  KEY `fk_Employees_People1_idx` (`People_ID1`),
  CONSTRAINT `fk_Employees_People1` FOREIGN KEY (`People_ID1`) REFERENCES `people` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` (`SSN`, `Position`, `Birth Date`, `Pay`, `Start Date`, `People_ID1`, `User_Name`, `Sesion_Token`) VALUES (111111111,'Caretaker','08-06-1974',45000,'06-09-2010',1,'William_Johnson',00000000000000000000000000000000000000000000000000000000000000000),(222222222,'Security Guard','09-10-1958',35000,'06-09-2010',2,'Sarah_Fields',00000000000000000000000000000000000000000000000000000000000000000),(333333333,'Artificer','01-02-1986',68000,'06-09-2010',3,'Madelyn_Mann',00000000000000000000000000000000000000000000000000000000000000000),(444444444,'Curator','01-26-1964',78000,'06-09-2010',4,'Jerry_Geroges',00000000000000000000000000000000000000000000000000000000000000000),(555555555,'Accountant','07-06-1978',70000,'06-09-2010',5,'Marrisa_Clory',00000000000000000000000000000000000000000000000000000000000000000),(666666666,'Administrator','06-17-1987',70000,'06-09-2010',8,'Michael_Fielding',00000000000000000000000000000000000000000000000000000000000000000);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `museum`
--

DROP TABLE IF EXISTS `museum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `museum` (
  `idMuseum` int(11) NOT NULL AUTO_INCREMENT,
  `Location` varchar(45) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Shows` varchar(45) NOT NULL,
  `People_ID` int(11) NOT NULL,
  PRIMARY KEY (`idMuseum`),
  KEY `fk_Museum_People1_idx` (`People_ID`),
  CONSTRAINT `fk_Museum_People1` FOREIGN KEY (`People_ID`) REFERENCES `people` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `museum`
--

LOCK TABLES `museum` WRITE;
/*!40000 ALTER TABLE `museum` DISABLE KEYS */;
INSERT INTO `museum` (`idMuseum`, `Location`, `Name`, `Shows`, `People_ID`) VALUES (1,'Houston, Texas','Harris County Museum of Art','Conceptual, Pollock',0);
/*!40000 ALTER TABLE `museum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `non-employees`
--

DROP TABLE IF EXISTS `non-employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `non-employees` (
  `Position` varchar(45) NOT NULL,
  `People_ID1` int(11) NOT NULL,
  KEY `fk_Non-Employees_People1_idx` (`People_ID1`),
  CONSTRAINT `fk_Non-Employees_People1` FOREIGN KEY (`People_ID1`) REFERENCES `people` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `non-employees`
--

LOCK TABLES `non-employees` WRITE;
/*!40000 ALTER TABLE `non-employees` DISABLE KEYS */;
INSERT INTO `non-employees` (`Position`, `People_ID1`) VALUES ('Donor',6),('Member',7);
/*!40000 ALTER TABLE `non-employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `on display`
--

DROP TABLE IF EXISTS `on display`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `on display` (
  `Display` varchar(45) NOT NULL,
  `Room_Room Name` varchar(45) NOT NULL,
  `Art_ID` int(11) NOT NULL,
  PRIMARY KEY (`Display`,`Room_Room Name`),
  KEY `fk_On Display_Art1_idx` (`Art_ID`),
  CONSTRAINT `fk_On Display_Art1` FOREIGN KEY (`Art_ID`) REFERENCES `art` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `on display`
--

LOCK TABLES `on display` WRITE;
/*!40000 ALTER TABLE `on display` DISABLE KEYS */;
/*!40000 ALTER TABLE `on display` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `on loan`
--

DROP TABLE IF EXISTS `on loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `on loan` (
  `Location` varchar(45) NOT NULL,
  `Loan Date` date NOT NULL,
  `Return Date` date NOT NULL,
  `Show Name` varchar(45) NOT NULL,
  `Insured For` int(11) NOT NULL,
  `Art_ID` int(11) NOT NULL,
  `Art_Room_Room Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Art_ID`,`Art_Room_Room Name`),
  CONSTRAINT `fk_On Loan_Art1` FOREIGN KEY (`Art_ID`) REFERENCES `art` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `on loan`
--

LOCK TABLES `on loan` WRITE;
/*!40000 ALTER TABLE `on loan` DISABLE KEYS */;
/*!40000 ALTER TABLE `on loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` (`ID`, `Name`) VALUES (1,'William Johnson'),(2,'Sarah Fields'),(3,'Madelyn Mann'),(4,'Jerry Geroges'),(5,'Marrisa Clory'),(6,'Jonathan Marks'),(7,'Marks Jonathan'),(8,'Michael Fielding');
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `Room Name` varchar(45) NOT NULL,
  `Theme` varchar(45) NOT NULL,
  `Size` int(11) NOT NULL,
  `Show_Title` varchar(45) NOT NULL,
  `On Display_Display` varchar(45) NOT NULL,
  `On Display_Room_Room Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Room Name`),
  KEY `fk_Room_Show1_idx` (`Show_Title`),
  KEY `fk_Room_On Display1_idx` (`On Display_Display`,`On Display_Room_Room Name`),
  CONSTRAINT `fk_Room_On Display1` FOREIGN KEY (`On Display_Display`, `On Display_Room_Room Name`) REFERENCES `on display` (`Display`, `Room_Room Name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Room_Show1` FOREIGN KEY (`Show_Title`) REFERENCES `show` (`Title`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `show`
--

DROP TABLE IF EXISTS `show`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `show` (
  `Title` varchar(45) NOT NULL,
  `Show Begin` varchar(45) NOT NULL,
  `Show End` varchar(45) NOT NULL,
  PRIMARY KEY (`Title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `show`
--

LOCK TABLES `show` WRITE;
/*!40000 ALTER TABLE `show` DISABLE KEYS */;
INSERT INTO `show` (`Title`, `Show Begin`, `Show End`) VALUES ('Conceptual','01-01-2017','01-01-2018'),('Pollock','01-01-2017','01-01-2018');
/*!40000 ALTER TABLE `show` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'mydb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-27 23:29:14
