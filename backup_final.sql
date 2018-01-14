-- MySQL dump 10.13  Distrib 5.5.57, for Linux (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.5.57

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
  `Title` varchar(100) DEFAULT NULL,
  `Artist` varchar(45) NOT NULL,
  `Year Produced` int(11) NOT NULL,
  `Style` varchar(45) NOT NULL,
  `Medium` varchar(100) DEFAULT NULL,
  `UUID` varchar(45) NOT NULL,
  `in_exhibit` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`UUID`),
  KEY `UUID` (`UUID`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `art`
--

LOCK TABLES `art` WRITE;
/*!40000 ALTER TABLE `art` DISABLE KEYS */;
INSERT INTO `art` VALUES (47,'Birds Above the Forest','Max Ernst',1929,'Surrealism','Oil on Canvas','2124e72b-c346-4d66-bd82-02ace7af3035','Max Ernst: Beyond Painting'),(16,'Music Pink and Blue','Georgia O\'Keeffe',1918,'Abstract Art, Precisionism','Oil','28181446-be63-11e7-abc4-cec278b6b50a','Ernst and Pollock: A Dissection'),(32,'Galtea of the Spheres','Salvador Dali',1952,'Surrealism','Oil on Canvas','284a0ef8-5c6f-4228-8ccf-f84dd4e08e9c',''),(4,'Blue poles (Number 11)','Jackson Pollock',1952,'Action painting','enamel, canvas','380e03d8-be59-11e7-abc4-cec278b6b50a','Ernst and Pollock: A Dissection'),(12,'Rain (Study)','Agnes Martin',1960,'Color Field Painting','Oil','41efb10e-be62-11e7-abc4-cec278b6b50a',''),(21,'The King Playing with the Queen','Max Ernst',1944,'Surrealism','Bronze','427c8936-efdf-4892-8f35-21da59179cd4','Max Ernst: Beyond Painting'),(45,'Alice in 1941','Max Ernst',1941,'Surrealism','Oil on paper mounted on canvas','4f7ae1db-260e-4982-88a7-2fbbcc24c2c7','Max Ernst: Beyond Painting'),(28,'Wrapper from Galapagos: The Islands at the End of the World','Max Ernst',1955,'Surrealism','Etching from an illustrated book with ten etchings','5349384b-abbe-4280-bc2b-07faf48883ce','Max Ernst: Beyond Painting'),(36,'Kiss','Edvard  Munch',1897,'Expressionism','Oil on Canvas','58ca6592-29a8-439a-acbc-089135f88098',''),(34,'A Glimpse of Notre-Dame in the Late Afternoon','Henri Matisse',1902,'Fauvism','Oil on Canvas','63c1dd60-c8da-4028-bde9-23497a7ebf54',''),(13,'Untitled','Agnes Martin',1959,'Color Field Painting','Oil','6668e078-be62-11e7-abc4-cec278b6b50a',''),(5,'Number 1 (Lavender Mist)','Jackson Pollock',1950,'Action painting','Oil Paint','719795e2-be59-11e7-abc4-cec278b6b50a',''),(10,'Titled (Art as Idea as Idea) (Water)','Joseph Kosuth',1966,'Conceptual Art','Mixed Media','730fceb6-be5a-11e7-abc4-cec278b6b50a',''),(22,'The Nymph Echo','Max Ernst',1936,'Surrealism','Oil on Canvas','7a4552fd-a918-4487-b754-f553b06c43f9','Max Ernst: Beyond Painting'),(17,'100 Cans','Andy Warhol',1962,'Pop Art','Oil','7ab22160-be63-11e7-abc4-cec278b6b50a','Andy Warhol: A Look in Pop Art'),(18,'Elvis I & II','Andy Warhol',1963,'Pop Art','Oil','9d39050a-be63-11e7-abc4-cec278b6b50a','Andy Warhol: A Look in Pop Art'),(48,'Two Children Are Threatened by a Nightingale','Max Ernst',1924,'Surrealism','Oil with painted wood elements and cut-and-pasted printed paper on wood with wood frame','a10e8cf1-0afb-4f0b-b2ae-d33bb9245f2e','Max Ernst: Beyond Painting'),(11,'Five Words in Green Neon','Joseph Kosuth',1965,'Conceptual Art','Mixed Media','a432ed48-be5a-11e7-abc4-cec278b6b50a',''),(46,'Bird-head','Max Ernst',1935,'Surrealism','Bronze','a5aff7d6-7397-4537-83a4-640144a1f8e9','Max Ernst: Beyond Painting'),(14,'Red Bird','Agnes Martin',1964,'Minimalism','pencil, ink, paper','ab3a5d62-be62-11e7-abc4-cec278b6b50a',''),(25,'An Anxious Friend','Max Ernst',1944,'Surrealism','Bronze','b032d6c2-c8b2-4115-aa15-23f2684486ec','Max Ernst: Beyond Painting'),(6,'Glass Words Material Described','Joseph Kosuth',1965,'Conceptual Art','Mixed Media','b35334be-be59-11e7-abc4-cec278b6b50a',''),(33,'Metamorphosis of Narcissus','Salvador Dali',1937,'Surrealism','Oil on Canvas','be5effdd-6565-4ce0-8c09-1472c8dc9c67',''),(30,'Christ of St. John of the Cross','Salvador Dali',1951,'Surrealism','Oil on Canvas','c19aea01-6a1f-4b86-af84-2b347f692e28',''),(2,'Going West','Jackson Pollock',1934,'Expressionism','oil, fiberboard','c30349ae-be58-11e7-abc4-cec278b6b50a','Ernst and Pollock: A Dissection'),(19,'Big Campbell\'s Soup Can 19c (Beef Noodle)','Andy Warhol',1962,'Pop Art','Oil','c34c7ba0-be63-11e7-abc4-cec278b6b50a','Andy Warhol: A Look in Pop Art'),(7,'Clock (One and Five)','Joseph Kosuth',1965,'Conceptual Art','Mixed Media','d97b838a-be59-11e7-abc4-cec278b6b50a',''),(42,'Noon','George Henry',1885,'Impresionissm','Oil on canvas','e534c6d4-bc45-11e7-abc4-cec278b6b50a',''),(20,'Marilyn Monroe','Andy Warhol',1968,'Pop Art','Oil','e9224774-be63-11e7-abc4-cec278b6b50a','Andy Warhol: A Look in Pop Art'),(44,'The Gramineous Bicycle Garnished with Bells the Dappled Fire Damps and the Echinoderms Bending the S','Max Ernst',1921,'Dada','Gouache, ink, and pencil on printed paper on paperboard','e9335b09-a148-42a6-8243-6d692e5dc17c','Max Ernst: Beyond Painting'),(35,'Dance (II)','Henri Matisse',1910,'Expressionism','Oil on Canvas','ee941a23-e51f-4ade-a77b-993987e99775',''),(31,'Crucifixion','Salvador Dali',1954,'Surrealism','Oil on Canvas','f13d75a2-c751-43ea-aea3-5e2029ded4b4',''),(15,'Black Lines 1','Georgia O\'Keeffe',1916,'Abstract Art','Oil','fed7acc2-be62-11e7-abc4-cec278b6b50a','');
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
  `Pay` bigint(20) unsigned NOT NULL DEFAULT '0',
  `People_ID1` int(11) NOT NULL,
  `User_Name` varchar(45) DEFAULT NULL COMMENT 'First and Last name (First_Last)',
  `Session_Token` char(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  KEY `fk_Employees_People1_idx` (`People_ID1`),
  CONSTRAINT `fk_Employees_People1` FOREIGN KEY (`People_ID1`) REFERENCES `people` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (333333333,'Artificer','10-10-1988',78000,3,'the_dude','000000000000000000000000000000','bowling777888'),(444444444,'Curator','01-26-1964',78000,4,'bill_murray','000000000000000000000000000000','l0st1ntr4ns14tion'),(555555555,'Accountant','07-06-1978',70000,5,'janedoe','000000000000000000000000000000','money777money'),(666666666,'Administrator','06-17-1987',70000,8,'Equifax','000000000000','noitsnotpassword123'),(123456777,'CEO','10-07-1995',1000000000,106,'CEO','7467a6b2fdac8de2c339800feaba2283','threecommas'),(123321124,'Administrator','05-13-1994',100000,107,'austinmoreau','2ee62bae53f500671fb63a5ea00b069d','database'),(111345345,'Administrator','01-03-1996',100000,109,'rcampos','aee637b9a13aaa8c7d3e22c4d05b4231','database');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exhibits`
--

DROP TABLE IF EXISTS `exhibits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exhibits` (
  `Title` varchar(100) NOT NULL DEFAULT '',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `main_image` varchar(36) DEFAULT NULL,
  `description` text,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exhibits`
--

LOCK TABLES `exhibits` WRITE;
/*!40000 ALTER TABLE `exhibits` DISABLE KEYS */;
INSERT INTO `exhibits` VALUES ('Ernst and Pollock: A Dissection','2017-10-01','2018-02-22','427c8936-efdf-4892-8f35-21da59179cd4',NULL,6),('Andy Warhol: A Look in Pop Art','2017-10-10','2018-02-22','c34c7ba0-be63-11e7-abc4-cec278b6b50a',NULL,7),('Max Ernst: Beyond Painting','2017-10-01','2018-02-22','e9335b09-a148-42a6-8243-6d692e5dc17c','This exhibition surveys the career of the preeminent Dada and Surrealist artist Max Ernst (French and American, born Germany, 1891–1976), with particular emphasis on his ceaseless experimentation. Ernst began his pursuit of radical new techniques that went \"beyond painting\" to articulate the irrational and unexplainable in the wake of World War I, continuing through the advent and aftermath of World War II. Featuring approximately 100 works drawn from the Museum’s collection, the exhibition includes paintings that challenged material and compositional conventions',12);
/*!40000 ALTER TABLE `exhibits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `non-employees`
--

DROP TABLE IF EXISTS `non-employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `non-employees` (
  `Type` varchar(50) NOT NULL,
  `People_ID1` int(11) NOT NULL,
  `join_date` date DEFAULT NULL,
  `donor_amount` bigint(20) DEFAULT '0',
  KEY `fk_Non-Employees_People1_idx` (`People_ID1`),
  CONSTRAINT `fk_Non-Employees_People1` FOREIGN KEY (`People_ID1`) REFERENCES `people` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `non-employees`
--

LOCK TABLES `non-employees` WRITE;
/*!40000 ALTER TABLE `non-employees` DISABLE KEYS */;
INSERT INTO `non-employees` VALUES ('Member',7,'2017-12-02',0),('Donor',110,'2017-12-02',2000),('Volunteer',113,'2015-01-02',0),('Member',114,'2017-12-02',0),('Donor',115,'2017-12-02',100000);
/*!40000 ALTER TABLE `non-employees` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (3,'The Dude'),(4,'Bill Murray'),(5,'Jane Doe'),(7,'Austin Moreau'),(8,'Equifax'),(106,'Garrett George'),(107,'Austin Moreau'),(109,'Rafael Campos'),(110,'Joseph Smith'),(113,'Ned Blythe'),(114,'Richmal Evette'),(115,'Bill Gates');
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-04  4:36:28
