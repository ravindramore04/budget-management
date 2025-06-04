CREATE DATABASE  IF NOT EXISTS `budget22_23` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `budget22_23`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: budget22_23
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `budget_note`
--

DROP TABLE IF EXISTS `budget_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `budget_note` (
  `budget_note_id` int DEFAULT NULL,
  `AllocId` int DEFAULT NULL,
  `budget_note_expense` double(11,2) DEFAULT '0.00',
  `allocation_reserved_amount` double(11,2) DEFAULT '0.00',
  `allocation_balance_amount_after_expense` double(11,2) DEFAULT '0.00',
  `budget_note_remark` varchar(100) DEFAULT NULL,
  `budget_note_status` varchar(10) DEFAULT NULL,
  `created_by_user_id` int DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `updated_by_user_id` int DEFAULT NULL,
  `update_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `budget_note`
--

LOCK TABLES `budget_note` WRITE;
/*!40000 ALTER TABLE `budget_note` DISABLE KEYS */;
INSERT INTO `budget_note` VALUES (1,100001,1000.00,1000.00,93000.00,'','DRAFT',100007,'2025-05-03',100007,'2025-05-03'),(2,100001,500.00,500.00,2500.00,'Test Budget Note','DRAFT',100007,'2025-05-04',100007,'2025-05-04'),(4,100001,500.00,500.00,500.00,'','DRAFT',100007,'2025-05-04',100007,'2025-05-04'),(5,100001,500.00,500.00,0.00,'','DRAFT',100007,'2025-05-04',100007,'2025-05-04'),(6,100001,1500.00,1500.00,-1500.00,'This is new updated one','DRAFT',100007,'2025-05-04',100007,'2025-05-04'),(7,100001,1500.00,1500.00,-3000.00,'This is new updated one','DRAFT',100007,'2025-05-04',100007,'2025-05-04');
/*!40000 ALTER TABLE `budget_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `budget_note_history`
--

DROP TABLE IF EXISTS `budget_note_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `budget_note_history` (
  `budget_note_history_id` int DEFAULT NULL,
  `budget_note_id` int DEFAULT NULL,
  `budget_note_expense` double(11,2) DEFAULT '0.00',
  `allocation_reserved_amount` double(11,2) DEFAULT '0.00',
  `allocation_balance_amount_after_expense` double(11,2) DEFAULT '0.00',
  `budget_note_remark` varchar(100) DEFAULT NULL,
  `budget_note_status` varchar(10) DEFAULT NULL,
  `created_by_user_id` int DEFAULT NULL,
  `create_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `budget_note_history`
--

LOCK TABLES `budget_note_history` WRITE;
/*!40000 ALTER TABLE `budget_note_history` DISABLE KEYS */;
INSERT INTO `budget_note_history` VALUES (1,1,5000.00,5000.00,95000.00,'Budget Note','DRAFT',100007,'2025-05-01'),(2,2,1000.00,1000.00,94000.00,'','DRAFT',100007,'2025-05-01'),(3,1,1000.00,1000.00,93000.00,'','DRAFT',100007,'2025-05-03'),(4,2,500.00,500.00,2500.00,'Test Budget Note','DRAFT',100007,'2025-05-04'),(5,3,1500.00,1500.00,1000.00,'This is new updated one','DRAFT',100007,'2025-05-04'),(6,4,500.00,500.00,500.00,'','DRAFT',100007,'2025-05-04'),(7,5,500.00,500.00,0.00,'','DRAFT',100007,'2025-05-04'),(8,6,1500.00,1500.00,-1500.00,'This is new updated one','DRAFT',100007,'2025-05-04'),(9,7,1500.00,1500.00,-3000.00,'This is new updated one','DRAFT',100007,'2025-05-04');
/*!40000 ALTER TABLE `budget_note_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `budgetalloc`
--

DROP TABLE IF EXISTS `budgetalloc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `budgetalloc` (
  `AllocId` int DEFAULT NULL,
  `HeadId` int DEFAULT NULL,
  `Dt` date DEFAULT NULL,
  `dblAmount` double(11,2) DEFAULT '0.00',
  `strRemark` varchar(100) DEFAULT NULL,
  `strInsBy` int DEFAULT NULL,
  `strInsOn` date DEFAULT NULL,
  `strUptdBy` int DEFAULT NULL,
  `strUptdOn` date DEFAULT NULL,
  `strDepartmentId` varchar(10) DEFAULT NULL,
  `dblReservedAmount` double(11,2) DEFAULT '0.00',
  `dblUtilisedAmount` double(11,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `budgetalloc`
--

LOCK TABLES `budgetalloc` WRITE;
/*!40000 ALTER TABLE `budgetalloc` DISABLE KEYS */;
INSERT INTO `budgetalloc` VALUES (100001,100001,'2025-04-01',10000.00,'',100007,'2025-05-03',100007,'2025-05-03','100001',10850.00,2150.00),(100002,100001,'2000-01-01',90000.00,'',100007,'2025-05-01',100007,'2025-05-01','100002',-1000.00,1000.00),(100003,100002,'2025-04-01',10000.00,'Budget note',100007,'2025-05-03',100007,'2025-05-03','100003',0.00,0.00);
/*!40000 ALTER TABLE `budgetalloc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `budgethead`
--

DROP TABLE IF EXISTS `budgethead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `budgethead` (
  `HeadId` int DEFAULT NULL,
  `strBudgroupId` varchar(10) DEFAULT NULL,
  `strName` varchar(40) DEFAULT NULL,
  `strAccNo` varchar(10) DEFAULT NULL,
  `strRemark` varchar(100) DEFAULT NULL,
  `strInsBy` int DEFAULT NULL,
  `strInsOn` date DEFAULT NULL,
  `strUptdBy` int DEFAULT NULL,
  `strUptdOn` date DEFAULT NULL,
  `strDepartmentId` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `budgethead`
--

LOCK TABLES `budgethead` WRITE;
/*!40000 ALTER TABLE `budgethead` DISABLE KEYS */;
INSERT INTO `budgethead` VALUES (100001,'100001','Staff Training1','E1','Staff',100007,'2025-05-01',100007,'2025-05-03','100001'),(100002,'100003','Arts Science Store','E2','',100007,'2025-05-03',100007,'2025-05-03','100003');
/*!40000 ALTER TABLE `budgethead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `budgroup`
--

DROP TABLE IF EXISTS `budgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `budgroup` (
  `strBudgroupId` varchar(10) DEFAULT NULL,
  `strBudgroupNm` varchar(30) DEFAULT NULL,
  `strRmrk` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `budgroup`
--

LOCK TABLES `budgroup` WRITE;
/*!40000 ALTER TABLE `budgroup` DISABLE KEYS */;
INSERT INTO `budgroup` VALUES ('100001','Recurring Expenditure ','Recurring Expenditure '),('100002','Non-Recurring Expenditure','Non-Recurring Expenditure'),('100003','Computer Department1','Check'),('100004','sadsad','K');
/*!40000 ALTER TABLE `budgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cheque`
--

DROP TABLE IF EXISTS `cheque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cheque` (
  `voucherId` int DEFAULT NULL,
  `strChequeNo` varchar(6) DEFAULT NULL,
  `strPONo` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cheque`
--

LOCK TABLES `cheque` WRITE;
/*!40000 ALTER TABLE `cheque` DISABLE KEYS */;
INSERT INTO `cheque` VALUES (100002,'',0),(100003,'',0),(100004,'',0),(100006,'',0),(100007,'',0),(100008,'',0),(100017,'',0),(100023,'',0),(100024,'',0),(100025,'',0),(100026,'',0),(100027,'',0),(100028,'',0),(100035,'',0),(100036,'',0),(100037,'',0),(100038,'',0),(100039,'',0),(100040,'',0),(100041,'',0),(100042,'',0),(100044,'',0),(100045,'',0),(100047,'',0),(100048,'',0),(100049,'',0),(100050,'',0),(100051,'',0),(100052,'',0),(100055,'',0),(100056,'',0),(100057,'',0),(100058,'',0),(100066,'',0),(100070,'',0),(100071,'',0),(100074,'',0),(100076,'',0),(100077,'',0),(100080,'',0),(100082,'',0),(100083,'',0),(100084,'',0),(100085,'',0),(100088,'',0),(100091,'',0),(100095,'',0),(100101,'',0),(100102,'',0),(100107,'',0),(100108,'',0),(100111,'',0),(100112,'',0),(100113,'',0),(100114,'',0),(100117,'',0),(100118,'',0),(100119,'',0),(100120,'',0),(100128,'',0),(100129,'',0),(100130,'',0),(100131,'',0),(100134,'',0),(100135,'',0),(100137,'',0),(100138,'',0),(100139,'',0),(100140,'',0),(100141,'',0),(100144,'',0),(100145,'',0),(100146,'',0),(100152,'',0),(100153,'',0),(100155,'',0),(100156,'',0),(100157,'',0),(100158,'',0),(100159,'',0),(100160,'',0),(100165,'',0),(100168,'',0),(100169,'',0),(100173,'',0),(100174,'',0),(100177,'',0),(100178,'',0),(100185,'',0),(100191,'',0),(100192,'',0),(100193,'',0),(100195,'',0),(100196,'',0),(100197,'',0),(100198,'',0),(100203,'',0),(100204,'',0),(100205,'',0),(100209,'',0),(100210,'',0),(100211,'',0),(100217,'',0),(100222,'',0),(100223,'',0),(100225,'',0),(100226,'',0),(100227,'',0),(100228,'',0),(100229,'',0),(100231,'',0),(100232,'',0),(100233,'',0),(100235,'',0),(100236,'',0),(100237,'',0),(100238,'',0),(100240,'',0),(100241,'',0),(100242,'',0),(100243,'',0),(100244,'',0),(100245,'',0),(100246,'',0),(100247,'',0),(100248,'',0),(100249,'',0),(100250,'',0),(100255,'',0),(100256,'',0),(100257,'',0),(100259,'',0),(100265,'',0),(100266,'',0),(100267,'',0),(100269,'',0),(100270,'',0),(100271,'',0),(100272,'',0),(100273,'',0),(100274,'',0),(100277,'',0),(100278,'',0),(100280,'',0),(100281,'',0),(100282,'',0),(100284,'',0),(100285,'',0),(100286,'',0),(100287,'',0),(100288,'',0),(100290,'',0),(100291,'',0),(100292,'',0),(100293,'',0),(100294,'',0),(100295,'',0),(100296,'',0),(100297,'',0),(100298,'',0),(100301,'',0),(100302,'',0),(100303,'',0),(100305,'',0),(100306,'',0),(100307,'',0),(100309,'',0),(100311,'',0),(100312,'',0),(100313,'',0),(100314,'',0),(100315,'',0),(100316,'',0),(100317,'',0),(100320,'',0),(100321,'',0),(100322,'',0),(100323,'',0),(100324,'',0),(100327,'',0),(100328,'',0),(100329,'',0),(100331,'',0),(100332,'',0),(100333,'',0),(100334,'',0),(100335,'',0),(100336,'',0),(100344,'',0),(100346,'',0),(100351,'',0),(100354,'',0),(100355,'',0),(100356,'',0),(100357,'',0),(100358,'',0),(100359,'',0),(100360,'',0),(100369,'',0),(100370,'',0),(100371,'',0),(100372,'',0),(100373,'',0),(100374,'',0),(100375,'',0),(100376,'',0),(100378,'',0),(100379,'',0),(100380,'',0),(100401,'',0),(100403,'',0),(100404,'',0),(100405,'',0),(100406,'',0),(100407,'',0),(100408,'',0),(100409,'',0),(100410,'',0),(100411,'',0),(100412,'',0),(100413,'',0),(100414,'',0),(100415,'',0),(100416,'',0),(100417,'',0),(100418,'',0),(100419,'',0),(100420,'',0),(100421,'',0),(100422,'',0),(100423,'',0),(100425,'',0),(100426,'',0),(100427,'',0),(100429,'',0),(100430,'',0),(100431,'',0),(100432,'',0),(100433,'',0),(100434,'',0),(100435,'',0),(100436,'',0),(100437,'',0),(100438,'',0),(100439,'',0),(100440,'',0),(100441,'',0),(100442,'',0),(100443,'',0),(100444,'',0),(100445,'',0),(100447,'',0),(100448,'',0),(100449,'',0),(100450,'',0),(100451,'',0),(100452,'',0),(100453,'',0),(100454,'',0),(100455,'',0),(100456,'',0),(100458,'',0),(100459,'',0),(100475,'',0),(100478,'',0),(100479,'',0),(100480,'',0),(100483,'',0),(100484,'',0),(100485,'',0),(100486,'',0),(100488,'',0),(100489,'',0),(100498,'',0),(100499,'',0),(100500,'',0),(100501,'',0),(100502,'',0),(100503,'',0),(100504,'',0),(100505,'',0),(100506,'',0),(100508,'',0),(100514,'',0),(100517,'',0),(100518,'',0),(100519,'',0),(100520,'',0),(100522,'',0),(100525,'',0),(100526,'',0),(100527,'',0),(100528,'',0),(100530,'',0),(100531,'',0),(100532,'',0),(100533,'',0),(100535,'',0),(100536,'',0),(100540,'',0),(100541,'',0),(100542,'',0),(100544,'',0),(100545,'',0),(100551,'',0),(100552,'',0),(100554,'',0),(100555,'',0),(100557,'',0),(100559,'',0),(100560,'',0),(100561,'',0),(100562,'',0),(100563,'',0),(100564,'',0),(100566,'',0),(100567,'',0),(100568,'',0),(100569,'',0),(100570,'',0),(100571,'',0),(100572,'',0),(100573,'',0),(100574,'',0),(100575,'',0),(100576,'',0),(100577,'',0),(100578,'',0),(100580,'',0),(100582,'',0),(100583,'',0),(100584,'',0),(100585,'',0),(100586,'',0),(100587,'',0),(100588,'',0),(100589,'',0),(100590,'',0),(100591,'',0),(100592,'',0),(100593,'',0),(100594,'00000',0),(100595,'',0),(100596,'',0),(100597,'',0),(100598,'',0),(100600,'',0),(100601,'',0),(100602,'',0),(100603,'',0),(100604,'',0),(100605,'',0),(100606,'',0),(100607,'',0),(100608,'',0),(100609,'',0),(100610,'',0),(100612,'',0),(100613,'',0),(100614,'',0),(100615,'',0),(100626,'',0),(100627,'',0),(100629,'',0),(100630,'',0),(100631,'',0),(100632,'',0),(100633,'',0),(100637,'',0),(100644,'',0),(100646,'',0),(100647,'',0),(100648,'',0),(100649,'',0),(100650,'',0),(100651,'',0),(100660,'',0),(100663,'',0),(100664,'',0),(100671,'',0),(100674,'',0),(100675,'',0),(100676,'',0),(100677,'',0),(100678,'',0),(100679,'',0),(100685,'',0),(100687,'',0),(100688,'',0),(100689,'',0),(100690,'',0),(100691,'',0),(100692,'',0),(100693,'',0),(100694,'',0),(100695,'',0),(100697,'',0),(100698,'',0),(100699,'',0),(100700,'',0),(100701,'',0),(100702,'',0),(100704,'',0),(100705,'',0),(100706,'',0),(100707,'',0),(100708,'',0),(100709,'',0),(100710,'',0),(100711,'',0),(100712,'',0),(100713,'',0),(100714,'',0),(100715,'',0),(100716,'',0),(100717,'',0),(100718,'',0),(100719,'',0),(100720,'',0),(100721,'',0),(100722,'',0),(100723,'',0),(100726,'',0),(100729,'',0),(100734,'',0),(100735,'',0),(100740,'',0),(100741,'',0),(100745,'',0),(100749,'',0),(100750,'',0),(100751,'',0),(100752,'',0),(100753,'',0),(100756,'',0),(100757,'',0),(100758,'',0),(100759,'',0),(100761,'',0),(100762,'',0),(100763,'',0),(100765,'',0),(100766,'',0),(100768,'',0),(100769,'',0),(100770,'',0),(100771,'',0),(100772,'',0),(100773,'',0),(100774,'',0),(100775,'',0),(100781,'',0),(100782,'',0),(100783,'',0),(100784,'',0),(100788,'',0),(100789,'',0),(100790,'',0),(100791,'',0),(100796,'',0),(100798,'',0),(100799,'',0),(100805,'',0),(100806,'',0),(100808,'',0),(100811,'',0),(100813,'',0),(100814,'',0),(100820,'',0),(100821,'',0),(100822,'',0),(100824,'',0),(100826,'',0),(100827,'',0),(100828,'',0),(100829,'',0),(100830,'',0),(100831,'',0),(100832,'',0),(100835,'',0),(100836,'',0),(100838,'',0),(100839,'',0),(100841,'',0),(100842,'',0),(100843,'',0),(100847,'',0),(100848,'',0),(100849,'',0),(100850,'',0),(100851,'',0),(100852,'',0),(100853,'',0),(100854,'',0),(100855,'',0),(100856,'',0),(100857,'',0),(100858,'',0),(100859,'',0),(100861,'',0),(100866,'',0),(100872,'',0),(100873,'',0),(100877,'',0),(100878,'',0),(100879,'',0),(100884,'53958',0),(100885,'53958',0),(100886,'',0),(100887,'',0),(100889,'054121',0),(100890,'054121',0),(100891,'',0),(100893,'',0),(100894,'',0),(100895,'',0),(100896,'',0),(100897,'',0),(100899,'',0),(100900,'',0),(100901,'',0),(100902,'',0),(100903,'',0),(100904,'',0),(100905,'05412',0),(100906,'',0),(100916,'',0),(100917,'',0),(100918,'',0),(100919,'',0),(100920,'',0),(100921,'',0),(100922,'',0),(100923,'',0),(100924,'',0),(100925,'',0),(100926,'',0),(100927,'',0),(100928,'',0),(100929,'',0),(100930,'',0),(100931,'',0),(100932,'',0),(100934,'',0),(100935,'',0),(100937,'',0),(100938,'',0),(100941,'',0),(100942,'',0),(100943,'',0),(100944,'',0),(100945,'',0),(100946,'',0),(100948,'',0),(100949,'',0),(100950,'',0),(100951,'',0),(100952,'',0),(100953,'',0),(100965,'',0),(100968,'',0),(100969,'',0),(100972,'',0),(100982,'',0),(100983,'',0),(100989,'',0),(101000,'',0),(101001,'',0),(101009,'',0),(101013,'',0),(101018,'',0),(101019,'',0),(101023,'',0),(101026,'',0),(101027,'',0),(101028,'',0),(101029,'',0),(101030,'',0),(101031,'',0),(101032,'',0),(101034,'',0),(101035,'',0),(101036,'',0),(101037,'',0),(101038,'',0),(101039,'',0),(101040,'',0),(101041,'',0);
/*!40000 ALTER TABLE `cheque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `strName` varchar(40) DEFAULT NULL,
  `strShortNm` varchar(20) DEFAULT NULL,
  `strAddr` varchar(100) DEFAULT NULL,
  `strPh1` varchar(15) DEFAULT NULL,
  `strPh2` varchar(15) DEFAULT NULL,
  `strInsBy` int DEFAULT NULL,
  `strInsOn` date DEFAULT NULL,
  `strUptdBy` int DEFAULT NULL,
  `strUptdOn` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES ('MIT ARTS,COMMERCE & SCIENCE COLLEGE','MIT ACSC','ALANDI(D), PUNE  ','9175605407','',100005,'2013-04-03',100005,'2010-00-05');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `strDepartmentId` varchar(10) DEFAULT NULL,
  `strDepartmentNm` varchar(100) DEFAULT NULL,
  `strHeadOfDeptNm` varchar(100) DEFAULT NULL,
  `strRmrk` varchar(50) DEFAULT NULL,
  `strRmrk1` varchar(50) DEFAULT NULL,
  `strRmrk2` varchar(50) DEFAULT NULL,
  `strRmrk3` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES ('100001','BCA','Rohinkar','','','',''),('100002','BBA','','','','',''),('100003','Computer1','Rohinkar','','','','');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `headbal`
--

DROP TABLE IF EXISTS `headbal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `headbal` (
  `HeadId` int DEFAULT NULL,
  `dblBalance` double(11,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `headbal`
--

LOCK TABLES `headbal` WRITE;
/*!40000 ALTER TABLE `headbal` DISABLE KEYS */;
INSERT INTO `headbal` VALUES (100001,298797.00),(100002,10000.00),(100003,100000.00),(100004,0.00),(100001,100000.00),(100002,10000.00);
/*!40000 ALTER TABLE `headbal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchaseorder`
--

DROP TABLE IF EXISTS `purchaseorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchaseorder` (
  `nPONo` decimal(10,0) DEFAULT NULL,
  `POId` int DEFAULT NULL,
  `nBudgetId` decimal(10,0) DEFAULT NULL,
  `POdt` date DEFAULT NULL,
  `Consume` decimal(1,0) DEFAULT NULL,
  `NonConsume` decimal(1,0) DEFAULT NULL,
  `Strparty` varchar(25) DEFAULT NULL,
  `nAmt` decimal(15,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaseorder`
--

LOCK TABLES `purchaseorder` WRITE;
/*!40000 ALTER TABLE `purchaseorder` DISABLE KEYS */;
INSERT INTO `purchaseorder` VALUES (1,10000,100041,'2025-03-02',1,0,'Software',10000);
/*!40000 ALTER TABLE `purchaseorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userlst`
--

DROP TABLE IF EXISTS `userlst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userlst` (
  `UId` int DEFAULT NULL,
  `strName` varchar(40) DEFAULT NULL,
  `strLogin` varchar(50) DEFAULT NULL,
  `strPwd` varchar(50) DEFAULT NULL,
  `lvl` tinyint(1) DEFAULT NULL,
  `strInsBy` int DEFAULT NULL,
  `strInsOn` date DEFAULT NULL,
  `strUptdBy` int DEFAULT NULL,
  `strUptdOn` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userlst`
--

LOCK TABLES `userlst` WRITE;
/*!40000 ALTER TABLE `userlst` DISABLE KEYS */;
INSERT INTO `userlst` VALUES (100000,'LTPL','ltpl','0665513306455614231063',0,100000,'2005-04-16',100000,'2005-04-16'),(100001,'MAE','Budget12-13','141306615573526716414231063',1,100000,'0000-00-00',100000,'0000-00-00'),(100002,'Rashmi','rashmic','0344605633206655114231063',2,100001,'2012-04-09',100001,'2012-04-09'),(100003,'Ramya','ramyal','0711413327454114231063',2,100001,'2012-04-09',100001,'2012-04-09'),(100004,'Nilesh','nileshw','0334645543127155014231063',2,100001,'2012-04-09',100001,'2012-04-09'),(100005,'MIT ACSC','acsc','1443126256030266151',1,100000,'0000-00-00',100000,'0000-00-00'),(100006,'MIT ACSC','mitacsc','16631262562',2,100005,'2014-06-19',100005,'2014-06-19'),(100007,'ravindra','more','15533671145',1,100000,'0000-00-00',100000,'0000-00-00'),(100008,'ravindra','test','16431271564',1,100000,'0000-00-00',100000,'0000-00-00'),(100001,'more','more','15533671145',1,100000,'0000-00-00',100000,'0000-00-00');
/*!40000 ALTER TABLE `userlst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher`
--

DROP TABLE IF EXISTS `voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voucher` (
  `voucherId` int DEFAULT NULL,
  `voucherNo` int NOT NULL,
  `dt` date DEFAULT NULL,
  `HeadId` int DEFAULT NULL,
  `dblAmount` double(10,2) DEFAULT NULL,
  `dblTds` double(10,2) DEFAULT NULL,
  `strType` varchar(100) DEFAULT NULL,
  `strToAcc` varchar(250) DEFAULT NULL,
  `bMode` tinyint(1) DEFAULT NULL,
  `strBank` varchar(100) DEFAULT NULL,
  `strReceiverNm` varchar(100) DEFAULT NULL,
  `strInsBy` int DEFAULT NULL,
  `strInsOn` date DEFAULT NULL,
  `strUptdBy` int DEFAULT NULL,
  `strUptdOn` date DEFAULT NULL,
  `strTDS` varchar(200) DEFAULT NULL,
  `strPONo` int DEFAULT NULL,
  `VouNo` int DEFAULT NULL,
  `srCvouNO` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher`
--

LOCK TABLES `voucher` WRITE;
/*!40000 ALTER TABLE `voucher` DISABLE KEYS */;
/*!40000 ALTER TABLE `voucher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher_details`
--

DROP TABLE IF EXISTS `voucher_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voucher_details` (
  `voucher_id` int DEFAULT NULL,
  `voucher_number` int DEFAULT NULL,
  `budget_note_id` int DEFAULT NULL,
  `voucher_date` date DEFAULT NULL,
  `amount` double(11,2) DEFAULT '0.00',
  `tds_amount` double(11,2) DEFAULT '0.00',
  `strType` varchar(20) DEFAULT NULL,
  `payment_mode` varchar(10) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `chequeno` varchar(20) DEFAULT NULL,
  `receiver_name` varchar(100) DEFAULT NULL,
  `narration` varchar(500) DEFAULT NULL,
  `po_number` varchar(100) DEFAULT NULL,
  `created_by_user_id` int DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `updated_by_user_id` int DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `vouNumManual` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher_details`
--

LOCK TABLES `voucher_details` WRITE;
/*!40000 ALTER TABLE `voucher_details` DISABLE KEYS */;
INSERT INTO `voucher_details` VALUES (1,1,2,'2025-05-03',500.00,100.00,'110','1','','','Ravindra More','Ravindra More','1011',100007,'2025-05-03',100007,'2025-05-03','100'),(2,2,1,'2025-05-03',300.00,100.00,'110','1','','','Ravindra More','Ravindra More','1011',100007,'2025-05-03',100007,'2025-05-03','100'),(3,3,1,'2025-05-03',400.00,100.00,'TDS','1','','','Ravindra More','Ravindra More','1011',100007,'2025-05-03',100007,'2025-05-03','100'),(4,4,1,'2025-05-03',450.00,200.00,'TDS','1','','','Ravindra More','Ravindra More','1011',100007,'2025-05-03',100007,'2025-05-03','100');
/*!40000 ALTER TABLE `voucher_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-04 22:10:15
