-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: budget26_27
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
  `update_date` date DEFAULT NULL,
  `ponumber` varchar(50) DEFAULT NULL,
  `advance` tinyint(1) DEFAULT NULL,
  `advanceReceiverName` varchar(100) DEFAULT NULL,
  `narration` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `budget_note`
--

LOCK TABLES `budget_note` WRITE;
/*!40000 ALTER TABLE `budget_note` DISABLE KEYS */;
INSERT INTO `budget_note` VALUES (1,100001,10000.00,0.00,90000.00,'First Budget Note','APPROVED',100001,'2026-03-29',100001,'2026-03-29','',0,'',''),(2,100005,50000.00,0.00,450000.00,'BN','APPROVED',100001,'2026-03-29',100001,'2026-03-29','',0,'',''),(3,100001,15000.00,8000.00,75000.00,'New BN','APPROVED',100001,'2026-03-29',100001,'2026-03-29','',0,'',''),(4,100006,50000.00,0.00,450000.00,'','APPROVED',100001,'2026-03-29',100001,'2026-03-29','',0,'',''),(5,100012,5000.00,0.00,95000.00,'Others','APPROVED',100001,'2026-06-09',100001,'2026-06-09','',0,'','');
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
INSERT INTO `budget_note_history` VALUES (1,1,10000.00,0.00,90000.00,'First Budget Note','DRAFT',100001,'2026-03-29'),(2,2,50000.00,0.00,450000.00,'BN','DRAFT',100001,'2026-03-29'),(3,3,15000.00,8000.00,75000.00,'New BN','DRAFT',100001,'2026-03-29'),(4,4,50000.00,0.00,450000.00,'','DRAFT',100001,'2026-03-29'),(5,5,5000.00,0.00,95000.00,'Others','DRAFT',100001,'2026-06-09');
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
INSERT INTO `budgetalloc` VALUES (100001,100014,'2000-01-01',100000.00,'Advertisement',100001,'2026-03-29',100001,'2026-03-29','100001',12000.00,13000.00),(100002,100052,'2000-01-01',200000.00,'two laks',100001,'2026-03-29',100001,'2026-03-29','100001',0.00,0.00),(100003,100022,'2000-01-01',100000.00,'one lakh',100001,'2026-03-29',100001,'2026-03-29','100007',0.00,0.00),(100004,100052,'2000-01-01',50000.00,'50k',100001,'2026-03-29',100001,'2026-03-29','100007',0.00,0.00),(100005,100014,'2000-01-01',500000.00,'500k',100001,'2026-03-29',100001,'2026-03-29','100003',45000.00,5000.00),(100006,100052,'2000-01-01',500000.00,'500k',100001,'2026-03-29',100001,'2026-03-29','100003',42975.00,7025.00),(100007,100028,'2024-04-01',10000.00,'',100001,'2026-04-03',100001,'2026-04-03','100018',0.00,0.00),(100008,100069,'2024-04-01',98797.00,'',100001,'2026-04-03',100001,'2026-04-03','100012',0.00,0.00),(100009,100069,'2024-04-01',98797.00,'',100001,'2026-04-03',100001,'2026-04-03','100004',0.00,0.00),(100010,100028,'2024-04-01',89898.00,'',100001,'2026-04-03',100001,'2026-04-03','100005',0.00,0.00),(100011,100028,'2024-04-01',24560.00,'',100001,'2026-04-03',100001,'2026-04-03','100027',0.00,0.00),(100012,100083,'2026-04-01',100000.00,'Allocation',100001,'2026-06-09',100001,'2026-06-09','100007',3000.00,2000.00);
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
  `strName` varchar(200) DEFAULT NULL,
  `strAccNo` varchar(10) DEFAULT NULL,
  `strRemark` varchar(200) DEFAULT NULL,
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
INSERT INTO `budgethead` VALUES (100001,'100007','Software','E1','Accounts Software',100001,'2025-05-19',100001,'2026-03-02',''),(100002,'100059','FD Provision for increase in Intake','E2','Accounts',100001,'2025-05-19',100001,'2026-03-02',''),(100003,'100023','Printing & Stationary','E3','',100001,'2025-05-19',100001,'2026-03-02',''),(100004,'100043','Research Expenses','E4','Computer Application',100001,'2025-05-27',100001,'2026-03-02',''),(100005,'100009','Salary Teaching','E5','Accounts',100001,'2025-05-27',100001,'2026-03-02',''),(100006,'100010','Salary Non-Teaching','E6','Accounts',100001,'2025-05-27',100001,'2026-03-02',''),(100007,'100013','Honorarium/Professional Fees','E7','Accounts',100001,'2025-05-27',100001,'2026-03-02',''),(100008,'100012','Visiting Faculty','E8','Accounts',100001,'2025-05-27',100001,'2026-03-02',''),(100009,'100011','EPF Employee Contribution','E9','Accounts',100001,'2025-05-27',100001,'2026-03-02',''),(100010,'100015','Outsource Staff','E10','Accounts',100001,'2025-05-27',100001,'2026-03-02',''),(100011,'100014','Housekeeping,Garden & Security','E11','Accounts',100001,'2025-05-27',100001,'2026-03-02',''),(100012,'100013','Honorarium/Consultancy','E12','Accounts',100001,'2025-05-27',100001,'2026-03-02',''),(100013,'100005','Computers/Equipments','E13','Accounts',100001,'2025-05-27',100001,'2026-03-02',''),(100014,'100016','Advertisement ','E14','',100001,'2025-05-27',100001,'2026-03-02',''),(100015,'100018','Affiliation/Exam/University Fees','E15','',100001,'2025-05-27',100001,'2026-03-02',''),(100016,'100019','Consumable Goods','E16','',100001,'2025-05-27',100001,'2026-03-02',''),(100017,'100020','Campus & Garden Expenses','E17','',100001,'2025-05-27',100001,'2026-03-02',''),(100018,'100021','Industrial Visits & Study Tours','E18','',100001,'2025-05-27',100001,'2026-03-02',''),(100019,'100022','Office Expenses','E19','',100001,'2025-05-27',100001,'2026-03-02',''),(100020,'100024','Property Tax','E20','',100001,'2025-05-27',100001,'2026-03-02',''),(100021,'100025','Placement Expenses','E21','',100001,'2025-05-27',100001,'2026-03-02',''),(100022,'100004','Building Repairs','E22','',100001,'2025-05-27',100001,'2026-03-02',''),(100023,'100004','Equipment & Computers Repairs','E23','',100001,'2025-05-27',100001,'2026-03-02',''),(100024,'100004','Other Repairs & Maintenance','E24','',100001,'2025-05-27',100001,'2026-03-02',''),(100025,'100026','Staff Training & Development','E25','',100001,'2025-05-27',100001,'2026-03-02',''),(100026,'100028','Seminar, Conference & workshops','E26','',100001,'2025-05-27',100001,'2026-03-02',''),(100027,'100029','Merit & Ews Scholarship','E27','',100001,'2025-05-27',100001,'2026-03-02',''),(100028,'100030','Cultural Activities & Gathering','E28','',100001,'2025-05-27',100001,'2026-03-02',''),(100029,'100031','Sports activities & Equipment','E29','',100001,'2025-05-27',100001,'2026-03-02',''),(100030,'100032','Student Development Cell','E30','',100001,'2025-05-27',100001,'2026-03-02',''),(100031,'100027','Value Added courses (Students)','E31','',100001,'2025-05-27',100001,'2026-03-02',''),(100032,'100035','Students Club Activity','E32','',100001,'2025-05-27',100001,'2026-03-02',''),(100033,'0','NSS, co-curricular social Activity','E33','',100001,'2025-05-27',100001,'2026-03-02',''),(100034,'100037','Alumni Activities','E34','',100001,'2025-05-27',100001,'2026-03-02',''),(100035,'100051','Foundation Day Celebration','E35','',100001,'2025-05-27',100001,'2026-03-02',''),(100036,'100038','Telephone Bill/Mobile Bill','E36','',100001,'2025-05-27',100001,'2026-03-02',''),(100037,'100039','Internet Lease Line','E37','',100001,'2025-05-27',100001,'2026-03-02',''),(100038,'100040','Travelling & Conveyance','E38','',100001,'2025-05-27',100001,'2026-03-02',''),(100039,'100041','Vehicle diesel and Maintenance','E39','',100001,'2025-05-27',100001,'2026-03-02',''),(100040,'100042','Electricity Charges','E40','',100001,'2025-05-27',100001,'2026-03-02',''),(100041,'100043','Research Project','E41','',100001,'2025-05-27',100001,'2026-03-02',''),(100042,'100044','Seed Money','E42','',100001,'2025-05-27',100001,'2026-03-02',''),(100043,'100045','Start- up & Innovation Cell','E43','',100001,'2025-05-27',100001,'2026-03-02',''),(100044,'100046','National & International Collaborations','E44','',100001,'2025-05-27',100001,'2026-03-02',''),(100045,'100047','Exam Expenses','E45','',100001,'2025-05-27',100001,'2026-03-02',''),(100046,'100048','Desktop/ Laptop on Rent','E46','',100001,'2025-05-27',100001,'2026-03-02',''),(100047,'100008','Study Material - Books','E47','',100001,'2025-05-27',100001,'2026-03-02',''),(100048,'100049','Public Relation office','E48','',100001,'2025-05-27',100001,'2026-03-02',''),(100049,'100008','Library Books','E49','',100001,'2025-05-27',100001,'2026-03-02',''),(100050,'100005','Equipments','E50','',100001,'2025-05-27',100001,'2026-03-02',''),(100051,'100006','Furniture Fixture','E51','',100001,'2025-05-27',100001,'2026-03-02',''),(100052,'100002','Building Phase 1','E52','',100001,'2025-05-27',100001,'2026-03-02',''),(100053,'100058','Pending Bills','E53','Accounts',100001,'2025-05-28',100001,'2026-03-02',''),(100054,'100035','Club Activity','E54','',100001,'2025-05-28',100001,'2026-03-02',''),(100055,'100052','Quality Enhancement Program','E55','',100001,'2025-05-28',100001,'2026-03-02',''),(100056,'100051','Insurance','E56','',100001,'2025-05-28',100001,'2026-03-02',''),(100057,'100051','Staff Welfare & Training','E57','',100001,'2025-05-28',100001,'2026-03-02',''),(100058,'100051','Fin Asst for Profeesional Development','E58','',100001,'2025-05-28',100001,'2026-03-02',''),(100059,'100051','Staff Recreational Activity','E59','',100001,'2025-05-28',100001,'2026-03-02',''),(100060,'100051','Recruitment Advertisement','E60','',100001,'2025-05-28',100001,'2026-03-02',''),(100061,'100051','Advocate fees for Labour Case ','E61','',100001,'2025-05-28',100001,'2026-03-02',''),(100062,'100051','PF Prof Fees & Expert Remuneration','E62','',100001,'2025-05-28',100001,'2026-03-02',''),(100063,'100051','Class IV Uniforms','E63','',100001,'2025-05-28',100001,'2026-03-02',''),(100064,'100027','Student Activities (NSS)','E64','',100001,'2025-05-28',100001,'2026-03-02',''),(100065,'100001','Infra Development','E65','',100001,'2025-05-28',100001,'2026-03-02',''),(100066,'100021','Student Study Tour','E66','',100001,'2025-05-28',100001,'2026-03-02',''),(100067,'100033','Research and Projects (Students)','E67','',100001,'2025-05-28',100001,'2026-03-02',''),(100068,'100050','Guest Lectures ','E68','',100001,'2025-05-28',100001,'2026-03-02',''),(100069,'100036','Co-Curricular/Social Activity','E69','',100001,'2025-05-28',100001,'2026-03-02',''),(100070,'100027','Competitive Examination Cell','E70','',100001,'2025-05-28',100001,'2026-03-02',''),(100071,'100034','Skill Development','E71','Skill development/Value Addition/Certification Course & Study Tour',100001,'2025-05-28',100001,'2026-03-02',''),(100072,'100050','Workshop Training Program Guest Lecture','E72','',100001,'2025-05-28',100001,'2026-03-02',''),(100073,'100050','Workshop Completions Guest Lecture','E73','',100001,'2025-05-28',100001,'2026-03-02',''),(100074,'100002','Building Phase 2','E74','Accounts',100001,'2025-05-28',100001,'2026-03-02',''),(100075,'100057','Library Journals/Periodicals/Newspaper/Institue Membership','E75','',100001,'2025-06-13',100001,'2026-03-02',''),(100076,'100008','Library E-Book/Journals & Software','E76','',100001,'2025-06-13',100001,'2026-03-02',''),(100077,'100057','Library Seminar Conference & Workshop','E77','',100001,'2025-06-13',100001,'2026-03-02',''),(100078,'100003','Library Computers','E78','',100001,'2025-06-13',100001,'2026-03-02',''),(100079,'100007','Library Software','E79','',100001,'2025-06-13',100001,'2026-03-02',''),(100080,'100003','Computers / Laptops ','E80','',100001,'2025-09-02',100001,'2026-03-02',''),(100081,'100056','Gratuity','E81','Accounts',100001,'2026-01-20',100001,'2026-03-02',''),(100082,'100016','Advertisement 2026-2027','E82','For 2026-2027 Expenses',100001,'2026-03-06',100001,'2026-03-06',''),(100083,'100061','Other Budget Head','E83','Advertisement',100001,'2026-06-09',100001,'2026-06-09',''),(100084,'100007','Requisition','E84','Requisition',100001,'2026-09-16',100001,'2026-09-16','');
/*!40000 ALTER TABLE `budgethead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `budgetrequisition`
--

DROP TABLE IF EXISTS `budgetrequisition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `budgetrequisition` (
  `RequisitionId` int NOT NULL AUTO_INCREMENT,
  `HeadId` int DEFAULT NULL,
  `Dt` date DEFAULT NULL,
  `dblRequestedAmount` double(11,2) DEFAULT '0.00',
  `dblApprovedAmount` double(11,2) DEFAULT '0.00',
  `strRemark` varchar(100) DEFAULT NULL,
  `strStatus` varchar(20) DEFAULT 'Pending',
  `strInsBy` int DEFAULT NULL,
  `strInsOn` date DEFAULT NULL,
  `strUptdBy` int DEFAULT NULL,
  `strUptdOn` date DEFAULT NULL,
  `strDepartmentId` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`RequisitionId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `budgetrequisition`
--

LOCK TABLES `budgetrequisition` WRITE;
/*!40000 ALTER TABLE `budgetrequisition` DISABLE KEYS */;
INSERT INTO `budgetrequisition` VALUES (1,100014,'2026-09-16',100000.00,0.00,'Requisition Amount','Pending',100001,'2026-09-16',NULL,NULL,'100007'),(2,100082,'2000-01-01',98797.00,0.00,'Requisition.','Pending',100001,'2026-09-16',NULL,NULL,'100001'),(3,100061,'2000-01-01',24560.00,0.00,'Requisition','Pending',100001,'2026-09-16',NULL,NULL,'100022'),(4,100014,'2000-01-01',89898.00,0.00,'Computer Application','Pending',100047,'2026-09-16',NULL,NULL,'100003'),(5,100052,'2000-01-01',98797.00,0.00,'','Pending',100047,'2026-09-16',NULL,NULL,'100003'),(6,100014,'2000-01-01',100000.00,0.00,'','Pending',100047,'2026-09-16',NULL,NULL,'100003'),(7,100034,'2026-09-16',5000.00,0.00,'remark','Pending',100001,'2026-09-16',NULL,NULL,'100005'),(8,100084,'2000-01-01',10000.00,0.00,'Requisition','Pending',100047,'2026-09-16',NULL,NULL,'100003');
/*!40000 ALTER TABLE `budgetrequisition` ENABLE KEYS */;
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
INSERT INTO `budgroup` VALUES ('100001','IT Infra for New Building','0'),('100002','Building ','0'),('100003','Computers','0'),('100004','Repairs & Maintenance','1'),('100005','Equipments','0'),('100006','Furniture Fixture','0'),('100007','Softwares','0'),('100008','Library Books','0'),('100009','Salary - Teaching','1'),('100010','Salary - Non Teaching','1'),('100011','EPF - Employer Share','1'),('100012','Visiting Faculty','1'),('100013','Honorarium / Professional Fees','1'),('100014','HK,Garden Security Staff','1'),('100015','Outsourse Staff','1'),('100016','Advertisement','1'),('100017','Consultancy','1'),('100018','Affiliation & University Fee','1'),('100019','Consumable Goods','1'),('100020','Campus & Garden Expenses','1'),('100021','Ind Visit & Study Tour','1'),('100022','Office & Other Exp','1'),('100023','Printing & Stationary','1'),('100024','Property Tax','1'),('100025','Placement Expenses','1'),('100026','Staff Training & Welfare Exp','1'),('100027','Student Activities','1'),('100028','Sem. Conference & Workshop','1'),('100029','Merit EWS & Grayquest Con','1'),('100030','Gathering/Annual Day Expenses','1'),('100031','Sports Expenses','1'),('100032','Student Development Cell','1'),('100033','Research Project (Students)','1'),('100034','Skill Development','1'),('100035','Students Club Activity','1'),('100036','Co-Curricular Social Activity','1'),('100037','Alumni Meet','1'),('100038','Telephone Expenses','1'),('100039','Internet Expenses','1'),('100040','Travelling & Conveyance','1'),('100041','Vehicle Fuel & Maintenance','1'),('100042','Electricity Charges','1'),('100043','Research Expenses (Staff)','1'),('100044','Seed Money','1'),('100045','Start- up & Innovation Cell','1'),('100046','International Relation Cell ','1'),('100047','Exam Expenses','1'),('100048','Desktop/ Laptop on Rent ','1'),('100049','Public Relation office','1'),('100050','Experts Talk / Lecturer','1'),('100051','Human Resource Acitivity','1'),('100052','Quality Enhancement Program','1'),('100053','Animal Welfare expenses','1'),('100054','Bos/ Academic Council ','1'),('100055','Corporate Meeting & Event','1'),('100056','Gratuity','1'),('100057','Library Expenses','1'),('100058','Pending Bills','1'),('100059','FD','1'),('100060','Other Budget Group','2'),('100061','Others Group','2');
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
INSERT INTO `departments` VALUES ('100001','Accounts Admin','Mr. Sandeep Rohinkar','','','',''),('100002','Stores and Purchase','Mr. Satish Bawale','','','',''),('100003','Computer Application','Dr.Vikas Mahandule','','','',''),('100004','Business Adminstration & International Business Dept','Mrs.Aakanksha Landge','','','',''),('100005','Arts & Commerce','Dr. Padmavati Undale','','','',''),('100006','Science and Computer Science','Dr. Sangita Birajdar','','','',''),('100007','Accounts','Mrs.Deepali Jogdand','','','',''),('100008','Associate Dean- Students Affairs','Dr. Sunil Mahajan','','','',''),('100009','Public Relation Officer','Dr. Rahul Barathe','','','',''),('100010','IQAC','Mrs. Vijayalaxmi M K','','','',''),('100011','HRE','Ms. Reshma Somvanshi','','','',''),('100012','Associate Dean Marketing','Mr.Gaurav Magar','','','',''),('100013','Registrar','Dr. Sharad Kadam','','','',''),('100014','Library','Dr. Rahul Barathe','','','',''),('100015','Design Analytic and Cyber Security','Mrs. Bareen Shaikh','','','',''),('100016','Training & Placement','Dr. Mangesh Bhople','','','',''),('100017','Physical Education','Mr. Rajesh Kadlak','','','',''),('100018','Cultural Group Coordinator','Mrs.Mayuri Bapat','','','',''),('100019','National Service Scheme','Mr.Arvind Wagaskar','','','',''),('100020','Research & Development','Dr. Vaishali Kherdekar','','','',''),('100021','Student Development','Mrs.Pallavi Mahagaonkar','','','',''),('100022','Alumni ','Mrs.Mayuri Bapat','','','',''),('100023','Startup & Innovation Cell','Mr.Abhijit Netke','','','',''),('100024','Competitive Examination Cell','Ms.Diksha Kadam ','','','',''),('100025','Mathematics','Dr. Pradip Pansare','','','',''),('100026','System Adminstrator (IT)',' Mr.Shakil Nadaf','','','',''),('100027','Examination Department','Dr. Avinash Choure','','','',''),('100028','Deputy Director International Relation','Dr.Manasi Atitkar','','','',''),('100029','Presiding Officer Internal Complaint Committee','Mrs.Aakanksha Landge','','','',''),('100030','Coordination (UBA)','Dr. Shriram Kargaonkar','','','',''),('100031','Deputy Director Academics','Prof.Akshada Kulkarni','','','','');
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
INSERT INTO `headbal` VALUES (100060,0.00),(100061,0.00),(100083,0.00),(100084,0.00);
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
  `strName` varchar(100) DEFAULT NULL,
  `strLogin` varchar(50) DEFAULT NULL,
  `strPwd` varchar(50) DEFAULT NULL,
  `lvl` tinyint(1) DEFAULT NULL,
  `strInsBy` int DEFAULT NULL,
  `strInsOn` date DEFAULT NULL,
  `strUptdBy` int DEFAULT NULL,
  `strUptdOn` date DEFAULT NULL,
  `strDepartmentId` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userlst`
--

LOCK TABLES `userlst` WRITE;
/*!40000 ALTER TABLE `userlst` DISABLE KEYS */;
INSERT INTO `userlst` VALUES (100000,'LTPL','ltpl','0665513306455614231063',0,100000,'2005-04-16',100000,'2005-04-16',NULL),(100001,'Accounts Admin','acc','030261543',1,100007,'2025-05-06',100001,'2025-07-17','100001'),(100002,'Satish','store@mitacsc','030261143',1,100007,'2025-05-06',100001,'2025-07-04','100002'),(100008,'Advertisement & Marketing','marketing@mitacsc','1553227210014231063',1,100001,'2025-06-16',100001,'2025-07-23','100012'),(100009,'Accounts','accounts@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100007'),(100010,'Associate Dean- Students Affairs','studentaffairs@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100008'),(100014,'Registrar','registrar@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-08-05','100013'),(100015,'Library','library@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100014'),(100016,'Science and Computer Science','bsccs@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100006'),(100017,'Computer Application','bbaca@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100003'),(100018,'Arts & Commerce','bcom@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100005'),(100019,'Design Analytic and Cyber Security','dacs@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100015'),(100020,'Training & Placement','placement@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100016'),(100021,'Physical Education','sports@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100017'),(100022,'Cultural Group Coordinator','cultural@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100018'),(100026,'Alumni ','alumni@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100022'),(100027,'Startup & Innovation Cell','innovationcell@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100023'),(100028,'Competitive Examination Cell','examcell@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100024'),(100029,'Mathematics','mathematics@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100025'),(100031,'Examination Department','exam@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100027'),(100032,'Deputy Director Academics','academics@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100031'),(100033,'Deputy Director International Relation','internationalrelation@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100028'),(100034,'Coordination (UBA)','uba@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100030'),(100035,'HRE','hre@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100011'),(100036,'IQAC','iqac@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100010'),(100037,'National Service Scheme','nss@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100019'),(100038,'Public Relation Officer','pro@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100009'),(100039,'Research & Development','rnd@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-08-04','100020'),(100040,'Student Development','sdo@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100021'),(100041,'System Adminstrator (IT)','it@mitacsc','1553227210014231063',1,100001,'2025-07-23',100001,'2025-07-23','100026'),(100042,'Business Adminstration & International Business Dept','bbaib@mitacsc','1553227210014231063',1,100001,'2025-07-29',100001,'2025-07-31','100004'),(100043,'Presiding Officer Internal Complaint Committee','intcomplaint@mitacsc','1553227210014231063',1,100001,'2025-07-29',100001,'2025-07-29','100029'),(100044,'Director','director@mitacsc','1553227210014231063',2,100001,'2025-08-06',100001,'2025-08-06','100001'),(100045,'Computer','comp','14333666560',1,100001,'2026-03-07',100001,'2026-03-07','100003'),(100046,'accounts','acc1','14130661461',1,100001,'2026-04-18',100001,'2026-04-18','100007'),(100047,'more','more','15533671145',1,100001,'2026-09-16',100001,'2026-09-16','100003');
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
  `vouNumManual` varchar(20) DEFAULT NULL,
  `tdsnarration` varchar(500) DEFAULT NULL,
  `budgetnoteRemainAmt` double(11,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher_details`
--

LOCK TABLES `voucher_details` WRITE;
/*!40000 ALTER TABLE `voucher_details` DISABLE KEYS */;
INSERT INTO `voucher_details` VALUES (1,1,1,'2026-03-29',500.00,0.00,'TDS','1','','','Voucher 1','First Budget Note for Report Check','1011',100001,'2026-03-29',100001,'2026-03-29','1','TDS',9500.00),(2,2,1,'2026-03-29',1000.00,0.00,'TDS','1','','','voucher 2','second voucher','1011',100001,'2026-03-29',100001,'2026-03-29','','',8500.00),(3,3,2,'2026-03-29',5000.00,0.00,'TDS','1','','','voucher 1','voucher 1','1011',100001,'2026-03-29',100001,'2026-03-29','','',45000.00),(4,4,1,'2026-03-31',500.00,0.00,'TDS','1','','','voucher 3 future','voucher 3 next date','1011',100001,'2026-03-29',100001,'2026-03-29','','',8000.00),(5,5,3,'2026-03-29',5000.00,0.00,'TDS','1','','','New BN for Advertisement.','New BN','1011',100001,'2026-03-29',100001,'2026-03-29','','',10000.00),(6,6,4,'2026-03-29',5000.00,0.00,'TDS','1','','','Voucher 1','acc','1011',100001,'2026-03-29',100001,'2026-03-29','','',45000.00),(7,7,3,'2026-04-09',5000.00,1000.00,'10','2','BOI','123465','Receiver','on account of','1011',100001,'2026-04-09',100001,'2026-04-09','123465','TDS Narration',4000.00),(8,8,4,'2026-04-09',2000.00,25.00,'TDS','1','','','gjgjhghj','hgjhg','1011',100001,'2026-04-09',100001,'2026-04-09','','hjgjh',42975.00),(9,9,5,'2026-06-09',2000.00,0.00,'TDS','1','','','Ravindra More','on account of','1011',100001,'2026-06-09',100001,'2026-06-09','110','TDS is 100 rs',3000.00);
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

-- Dump completed on 2026-09-29 22:11:55
