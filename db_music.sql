-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: db_music
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `aid` int NOT NULL AUTO_INCREMENT,
  `adName` varchar(10) NOT NULL,
  `pwd` varchar(200) NOT NULL,
  `name` varchar(10) NOT NULL,
  `tel` varchar(15) NOT NULL,
  PRIMARY KEY (`aid`),
  UNIQUE KEY `adName` (`adName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album` (
  `alid` int NOT NULL AUTO_INCREMENT,
  `alName` varchar(100) NOT NULL,
  `alImgUrl` varchar(200) NOT NULL,
  `alIntro` text,
  `alResTime` date NOT NULL,
  `sgid` int NOT NULL,
  PRIMARY KEY (`alid`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COMMENT='专辑表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES (1,'耳朵','album/1.jpg','李荣浩的专辑','2015-03-20',10),(2,'有理想','album/2.jpg','李荣浩的专辑','2019-05-18',10),(3,'模特','album/3.jpg','李荣浩的专辑','2016-04-25',10),(4,'麻雀','album/4.jpg','李荣浩的专辑','2017-03-22',10),(5,'意外','album/5.jpg','薛之谦的专辑','2015-03-20',3),(6,'绅士','album/6.jpg','薛之谦的专辑','2019-05-18',3),(7,'初学者','album/7.jpg','薛之谦的专辑','2016-04-25',3),(8,'我相信','album/8.jpg','张靓颖的专辑','2017-03-22',2),(9,'画心','album/9.jpg','张靓颖的专辑','2017-03-22',2),(10,'The One','album/10.jpg','张靓颖的专辑','2017-03-22',2),(11,'重来','album/11.jpg','逃跑计划的专辑','2015-03-20',4),(12,'世界','album/12.jpg','逃跑计划的专辑','2019-05-18',4),(13,'歌 时代II','album/13.jpg','张信哲的专辑','2016-04-25',1),(14,'等待','album/14.jpg','张信哲的专辑','2017-03-22',1),(15,'美妙生活','album/15.jpg','林宥嘉的专辑','2015-03-20',7),(16,'感官-世界','album/16.jpg','林宥嘉的专辑','2019-05-18',7),(17,'成全','album/17.jpg','林宥嘉的专辑','2019-05-18',7),(18,'摩天动物园','album/18.jpg','邓紫棋的专辑','2015-03-20',30),(19,'光年之外','album/19.jpg','邓紫棋的专辑','2019-05-18',30),(20,'另一个童话','album/20.jpg','邓紫棋的专辑','2019-05-18',30),(21,'勇气','album/21.jpg','梁静茹的专辑','2015-03-20',9),(22,'丝路','album/22.jpg','梁静茹的专辑','2019-05-18',9),(23,'你曾是少年','album/23.jpg','S.H.E的专辑','2016-04-25',22),(24,'Super Star','album/24.jpg','S.H.E的专辑','2017-03-22',22),(25,'Faded(憔悴不堪)','album/25.jpg','Alan Walker的专辑','2015-03-20',39),(26,'On My Way','album/26.jpg','Alan Walker的专辑','2016-04-25',39),(27,'The Spectre','album/27.jpg','Alan Walker的专辑','2017-03-22',39),(28,'There For You','album/28.jpg','Martin Garrix的专辑','2015-03-20',25),(29,'So Far Away','album/29.jpg','Martin Garrix的专辑','2016-04-25',25),(30,'This Is Acting (Deluxe Version)','album/30.jpg','Alan Walker的专辑','2016-04-25',39),(31,'Walk Thru Fire','album/31.jpg','Vicetone的专辑','2017-03-22',16),(32,'Nevada','album/32.jpg','Vicetone的专辑','2019-05-18',16),(33,'Lemon(柠檬)','album/33.jpg','米津玄師的专辑','2017-03-22',8),(34,'打上花火(初回限定盤)','album/34.jpg','米津玄師的专辑','2015-03-20',8),(35,'WONDER Tourism','album/35.jpg','DAISHI DANCE的专辑','2019-05-18',34),(36,'the ジブリ set','album/36.jpg','DAISHI DANCE的专辑','2017-03-22',34),(37,'妖狐×僕SS ENDING SONG Vol.3','album/37.jpg','花澤香菜的专辑','2017-03-22',11),(38,'恋爱サーキュレーション (恋爱循环)','album/38.jpg','花澤香菜的专辑','2017-05-22',11),(39,'オヒアの木 (奥希亚之树)','album/39.jpg','滨崎步的专辑','2015-03-20',13),(40,'GUILTY (原罪)','album/40.jpg','滨崎步的专辑','2019-05-18',13),(41,'倾耳倾听I-第一乐章','album/41.jpg','WANDS的专辑','2016-04-25',15),(42,'果てしない夢を (把无尽的梦)','album/42.jpg','WANDS的专辑','2017-03-22',15),(43,'Sour Candy','album/43.jpg','Lady Gaga的专辑','2015-03-20',26),(44,'TOHOSHINKI LIVE CD COLLECTION ～The Secret Code～ FINAL i','album/44.jpg','东方神起的专辑','2016-04-25',12),(45,'どうして君を好きになってしまったんだろう？ (为何会喜欢上你)','album/45.jpg','东方神起的专辑','2017-03-22',12),(46,'Tomorrow With You (我们的明天)','album/46.jpg','Kondor的专辑','2017-03-22',27),(47,'Peace of body','album/47.jpg','Kondor的专辑','2017-03-22',27),(48,'ALONE JOURNEY','album/48.jpg','Blazo的专辑','2019-05-18',37),(49,'还好遇见你','album/49.jpg','PCHY的专辑','2017-03-22',23),(50,'The Love of Siam (Original Soundtrack)','album/50.jpg','PCHY的专辑','2015-03-20',23),(51,'15首全球至伤情歌1','album/51.jpg','Sara的专辑','2019-05-18',41),(52,'呼和浩特hohhot','album/52.jpg','Sara的专辑','2016-04-25',41),(53,'When My Heart Felt Volcanic','album/53.jpg','The Aces的专辑','2017-03-22',18),(54,'Fake Nice','album/54.jpg','The Aces的专辑','2017-01-22',18),(55,'走不出的回忆','album/55.jpg','任然的专辑','2017-03-22',5),(56,'没有发生的爱情','album/56.jpg','任然的专辑','2017-03-22',5),(57,'后继者','album/57.jpg','任然的专辑','2017-03-22',5),(58,'Dusk Till Dawn','album/58.jpg','ZAYN的专辑','2017-03-22',14),(59,'船帆','album/59.jpg','赵政豪的专辑','2019-04-23',42),(60,'La Maladie D\'Amour (相思病)','album/60.jpg','Michel Sardou的专辑','2012-04-23',43),(61,'信仰','album/61.jpg','张主任的专辑','2020-07-17',44);
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `areaclass`
--

DROP TABLE IF EXISTS `areaclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `areaclass` (
  `areaid` int NOT NULL AUTO_INCREMENT,
  `areaName` varchar(10) NOT NULL,
  PRIMARY KEY (`areaid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='地区分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areaclass`
--

LOCK TABLES `areaclass` WRITE;
/*!40000 ALTER TABLE `areaclass` DISABLE KEYS */;
INSERT INTO `areaclass` VALUES (1,'华语'),(2,'欧美'),(3,'日本'),(4,'韩国'),(5,'其他');
/*!40000 ALTER TABLE `areaclass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favouritesong`
--

DROP TABLE IF EXISTS `favouritesong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favouritesong` (
  `fsid` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL,
  `sid` int DEFAULT NULL,
  PRIMARY KEY (`fsid`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COMMENT='喜欢的歌曲表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favouritesong`
--

LOCK TABLES `favouritesong` WRITE;
/*!40000 ALTER TABLE `favouritesong` DISABLE KEYS */;
INSERT INTO `favouritesong` VALUES (7,1,35),(9,1,32),(10,2,12),(11,2,13),(29,1,62),(31,1,9),(59,2,19),(61,10,21);
/*!40000 ALTER TABLE `favouritesong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gedan`
--

DROP TABLE IF EXISTS `gedan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gedan` (
  `gdid` int NOT NULL AUTO_INCREMENT,
  `gdCover` varchar(200) NOT NULL DEFAULT 'gedanCover/default.png',
  `gdTitle` varchar(100) NOT NULL,
  `gdIntro` text,
  `gdPlayNum` int NOT NULL DEFAULT '0',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`gdid`),
  UNIQUE KEY `gdTitle_UNIQUE` (`gdTitle`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='歌单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gedan`
--

LOCK TABLES `gedan` WRITE;
/*!40000 ALTER TABLE `gedan` DISABLE KEYS */;
INSERT INTO `gedan` VALUES (1,'gedanCover/1.jpg','「国语情歌」岁月匆匆，往事难留','有人说，只有伤过的人才听得懂情歌。只有经历过爱，经历过离别，才能在情歌里嗅到似曾相识的味道和感伤。情歌还是老的好，像陈酿的美酒，承受了岁月的揉搓，留下的，便是最深情和动人的部分。',77821145,'2020-10-22 13:39:40','2020-10-22 13:39:40'),(2,'gedanCover/2.jpg','【入耳沉醉】 猝不及防的心动','每天，都要去做一些枯燥的事 一些让人心烦的事 可是又不得不去做 一切都在重复 都在复制，粘贴……… 为何不去做那些让人愉快的事呢',1564884,'2020-10-22 13:39:50','2020-10-22 13:39:50'),(4,'gedanCover/4.jpg','暮色似水，思念成海','暮色隐约，氤氲在青黛色的天空中。思念在内心深处晕染，才染了眉梢，又上了心头。暮色似水，对你的思念成海',53453,'2020-10-22 13:39:54','2020-10-22 13:39:54'),(5,'gedanCover/5.jpg','人生走在路上，愿你心花路放','新的一天新的开始，用一个最好的状态面对今天。一个人走在路上总会有些胆怯，听听这里的歌，不柔不躁，勇往直前。',4323,'2020-10-22 13:39:56','2020-10-22 13:39:56'),(6,'gedanCover/6.jpg','假日派对｜欧美清凉小调','夏天是清凉的世界。我们穿着颜色各异的游泳衣，跳进碧蓝的泳池里，真是又冰又凉，我们尽情地在水里游啊，跳啊，笑啊，好不痛快。',1543,'2020-10-22 13:39:58','2020-10-22 13:39:58'),(7,'gedanCover/7.jpg','白噪音|雷雨，伴你入睡，享受自然界的音乐','淅沥沥，伴你入眠，最舒适的自然声音，难得听到的狂风骤雨电闪雷鸣',21256,'2020-10-22 13:39:59','2020-10-22 13:39:59'),(8,'gedanCover/8.jpg','宁静的夜晚仰望星空|信仰','我还要再编制一个美丽的神话吗?秋夜清凉，举头望月，飘渺的思绪散入茫茫夜空。信马由缰，一步一步的步入秋夜。廊桥的故事，泊成清凌凌的月光。青葱的岁月，乳化成缕缕青烟。尘埃洗尽，秋梦无痕，一切的一切都烟消云散。',12545,'2020-10-22 13:40:01','2020-10-22 13:40:01'),(9,'gedanCover/9.jpg','跟自己说晚安，天总是会亮的','城市很大，有的人开心，有的人失落， 每个人都有属于自己的故事， 夜深了，就道声晚安与往事说再见吧。 听完这些歌，我们就说晚安。 “愿你夜夜好梦”',7893567,'2020-10-22 13:40:03','2020-10-22 13:40:03'),(10,'gedanCover/10.jpg','深夜音“药”： 激活你的学习脑细胞','喜欢深夜写作业?又害怕深夜的你脑子不好使?为何不来点音乐去刺激的脑细胞活跃起来让你的效率大大的提升一下呢?',4517,'2020-10-22 13:40:05','2020-10-22 13:40:05'),(11,'gedanCover/11.jpg','中国风 · 月下寄相思','举头望明月，低头思佳人…… 愿我如星君如月，夜夜流光相皎洁',9371,'2020-10-22 13:40:06','2020-10-22 13:40:06'),(12,'gedanCover/12.jpg','油管旅拍Vlog | 备好行囊，上路！','趁阳光正好，趁微风不噪，趁繁花还未开至荼蘼，趁现在还年轻，还可以走很长很长的路，还能诉说很深很深的思恋，去寻找那些曾出现在梦境中的路径、山峦和田野吧。',352167,'2020-10-22 13:40:08','2020-10-22 13:40:08'),(13,'gedanCover/13.jpg','民谣不是陈词滥调，只是故事发了酵','民谣，一听就是一个故事。 唱的人普通，听的人平凡。 喜欢那种感同身受，热爱那些词藻。 用歌曲说话，用歌曲讲故事， 因为被赋予旋律所以才更容易打动人心。',451351,'2020-10-22 13:40:10','2020-10-22 13:40:10'),(14,'gedanCover/14.jpg','忘忧纯音 · 沦陷静谧雨中','总有一些时刻，情绪莫名的低迷。 时光一缕缕走过，波澜不惊中少了些许的小确幸。 望着窗外细雨，听着宁静弦音，满眼都是清新与柔软，心情慢慢舒适起来。',46512,'2020-10-22 13:40:11','2020-10-22 13:40:11'),(15,'gedanCover/15.jpg','不屈摇滚丨天若塌，便再撑起一片天','电音和摇滚，我认为最为带感的两种音乐类型，但电音的激情我总算在孤独时听，而对于摇滚，传达的是更为真实的力量与激励，管它什么困难，用力前进！',45636,'2020-10-22 14:27:34','2020-10-22 14:27:34'),(36,'gedanCover/default.png','你凑合',NULL,0,'2020-11-07 11:19:24','2020-11-07 11:19:24');
/*!40000 ALTER TABLE `gedan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gedansong`
--

DROP TABLE IF EXISTS `gedansong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gedansong` (
  `gsid` int NOT NULL AUTO_INCREMENT,
  `gdid` int DEFAULT NULL,
  `sid` int DEFAULT NULL,
  PRIMARY KEY (`gsid`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='歌单歌曲关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gedansong`
--

LOCK TABLES `gedansong` WRITE;
/*!40000 ALTER TABLE `gedansong` DISABLE KEYS */;
INSERT INTO `gedansong` VALUES (1,1,2),(2,1,1),(3,1,12),(4,1,5),(5,1,3),(6,1,21),(7,2,6),(8,2,3),(9,2,7),(10,1,18),(11,1,16),(12,1,35),(13,1,41),(14,4,53),(15,4,25),(16,6,8),(17,6,4),(18,7,33),(19,7,12),(20,8,34),(21,9,12),(22,9,27),(23,8,16),(24,8,58),(25,10,23),(26,11,44),(27,10,67),(28,10,14),(29,11,54),(30,12,32),(31,12,48);
/*!40000 ALTER TABLE `gedansong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `label`
--

DROP TABLE IF EXISTS `label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `label` (
  `lbid` int NOT NULL,
  `lbName` varchar(30) NOT NULL,
  PRIMARY KEY (`lbid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标签表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `label`
--

LOCK TABLES `label` WRITE;
/*!40000 ALTER TABLE `label` DISABLE KEYS */;
INSERT INTO `label` VALUES (1,'原创'),(2,'古典'),(3,'说唱'),(4,'电音'),(5,'日语'),(6,'古风'),(7,'民谣'),(8,'流行'),(9,'欧美'),(10,'华语'),(11,'韩语');
/*!40000 ALTER TABLE `label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rankboard`
--

DROP TABLE IF EXISTS `rankboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rankboard` (
  `rbid` int NOT NULL AUTO_INCREMENT,
  `rbTitle` varchar(20) NOT NULL,
  `rbCover` varchar(200) NOT NULL DEFAULT 'rankBoard/default.jpg',
  `rbPlayNum` int NOT NULL DEFAULT '0',
  `rbUpdate` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`rbid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='排行榜表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rankboard`
--

LOCK TABLES `rankboard` WRITE;
/*!40000 ALTER TABLE `rankboard` DISABLE KEYS */;
INSERT INTO `rankboard` VALUES (1,'飙升榜','rankBoard/1.jpg',3135,'每日更新'),(2,'新歌榜','rankBoard/2.jpg',21314,'每日更新'),(3,'原创榜','rankBoard/3.jpg',566,'每周四更新'),(4,'热歌榜','rankBoard/4.jpg',5464233,'每周四更新'),(5,'古典音乐榜','rankBoard/5.jpg',312344,'每周四更新'),(6,'说唱榜','rankBoard/6.jpg',8954643,'每周五更新'),(7,'电音榜','rankBoard/7.jpg',56467,'每周五更新'),(8,'日语榜','rankBoard/8.jpg',67814,'每周二更新'),(9,'古风榜','rankBoard/9.jpg',333484,'每周五更新'),(10,'民谣榜','rankBoard/10.jpg',3456456,'每周五更新'),(11,'欧美热歌榜','rankBoard/11.jpg',15145165,'每周四更新'),(12,'中国新乡村音乐排行榜','rankBoard/12.jpg',3640220,'每周四更新'),(13,'Hit FM Top榜','rankBoard/13.jpg',28161492,'每周一更新');
/*!40000 ALTER TABLE `rankboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommend`
--

DROP TABLE IF EXISTS `recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommend` (
  `rid` int NOT NULL AUTO_INCREMENT,
  `rpicUrl` varchar(200) NOT NULL,
  `rintro` text,
  `rLink` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='精品推荐表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommend`
--

LOCK TABLES `recommend` WRITE;
/*!40000 ALTER TABLE `recommend` DISABLE KEYS */;
INSERT INTO `recommend` VALUES (1,'banner/1.jpg','','1'),(2,'banner/2.jpg','','2'),(3,'banner/3.jpg','','3'),(4,'banner/4.jpg','','4'),(5,'banner/5.jpg','','5');
/*!40000 ALTER TABLE `recommend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchword`
--

DROP TABLE IF EXISTS `searchword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `searchword` (
  `swid` int NOT NULL AUTO_INCREMENT,
  `swName` varchar(20) NOT NULL,
  `scount` int NOT NULL DEFAULT '0',
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`swid`),
  UNIQUE KEY `hwName` (`swName`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='搜索热词表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchword`
--

LOCK TABLES `searchword` WRITE;
/*!40000 ALTER TABLE `searchword` DISABLE KEYS */;
INSERT INTO `searchword` VALUES (1,'年少有为',3,'2020-08-13 18:44:53','2020-08-13 16:56:21'),(2,'Nevada',27,'2020-08-18 00:35:26','2020-08-13 16:59:21'),(3,'蔓越莓和煎饼',1,'2020-08-13 16:59:56','2020-08-13 16:59:55'),(4,'无人之岛',1,'2020-08-13 17:02:50','2020-08-13 17:01:38'),(5,'Super Star',33,'2020-08-16 16:38:40','2020-08-13 17:06:11'),(6,'信仰',153,'2020-11-07 09:55:23','2020-08-13 17:07:50'),(7,'S.H.E',3,'2020-08-14 15:26:27','2020-08-13 17:08:34'),(8,'林宥嘉',53,'2020-11-01 18:50:06','2020-08-13 17:08:51'),(9,'PCHY',1,'2020-08-13 17:10:56','2020-08-13 17:10:56'),(10,'Sara',29,'2020-08-19 12:02:47','2020-08-13 17:11:05'),(11,'船帆',28,'2020-08-15 02:42:22','2020-08-13 17:11:18'),(12,'On My Way',2,'2020-08-13 17:36:14','2020-08-13 17:35:16'),(13,'耳朵',76,'2020-11-01 18:44:39','2020-08-13 17:35:35'),(14,'摩天动物园',34,'2020-10-13 13:14:26','2020-08-13 17:35:48'),(15,'我们',25,'2020-08-16 16:38:13','2020-08-13 19:56:45'),(16,'成全',37,'2020-09-02 21:02:12','2020-08-14 12:39:32'),(17,'张信哲',83,'2020-11-05 14:24:45','2020-08-14 12:43:25'),(18,'薛之谦',62,'2020-11-01 18:43:16','2020-08-14 14:41:19'),(19,'邓紫棋',30,'2020-11-07 01:58:10','2020-08-14 14:46:21'),(20,'任然',1,'2020-08-14 14:49:51','2020-08-14 14:49:51'),(21,'任',2,'2020-08-14 15:19:40','2020-08-14 14:51:21'),(22,'信',5,'2020-11-05 15:24:59','2020-08-14 15:31:46'),(23,'O',2,'2020-08-14 15:32:35','2020-08-14 15:32:00'),(24,'c',12,'2020-08-15 15:39:24','2020-08-14 16:04:46'),(25,'ce',1,'2020-08-14 16:04:46','2020-08-14 16:04:46'),(26,'ch',2,'2020-08-14 16:05:00','2020-08-14 16:04:51'),(27,'che',2,'2020-08-14 16:04:59','2020-08-14 16:04:51'),(28,'成',1,'2020-08-14 16:05:05','2020-08-14 16:05:05'),(29,'张信',2,'2020-11-01 18:43:10','2020-08-14 16:12:17'),(30,'张',4,'2020-11-01 18:43:10','2020-08-14 16:12:18'),(31,'我',1,'2020-08-14 16:12:24','2020-08-14 16:12:24'),(32,'z',10,'2020-09-02 21:00:29','2020-08-14 16:12:24'),(33,'梁静茹',1,'2020-08-14 17:32:03','2020-08-14 17:32:02'),(34,'n',5,'2020-10-20 14:01:59','2020-08-14 18:43:04'),(35,'耳',1,'2020-08-14 21:47:14','2020-08-14 21:47:14'),(36,'林宥',1,'2020-08-15 02:42:48','2020-08-15 02:42:48'),(37,'林',1,'2020-08-15 02:42:51','2020-08-15 02:42:51'),(38,'w',2,'2020-08-15 02:44:14','2020-08-15 02:44:13'),(39,'wo',1,'2020-08-15 02:44:14','2020-08-15 02:44:13'),(40,'A',4,'2020-08-19 15:32:08','2020-08-15 02:44:15'),(41,'Al',2,'2020-08-15 02:44:29','2020-08-15 02:44:24'),(42,'Ala',2,'2020-08-15 02:44:29','2020-08-15 02:44:24'),(43,'Alan',1,'2020-08-15 02:44:24','2020-08-15 02:44:24'),(44,'b',1,'2020-08-15 02:44:51','2020-08-15 02:44:50'),(45,'ni',3,'2020-10-20 14:01:59','2020-08-15 02:44:58'),(46,'ca',5,'2020-11-06 00:22:12','2020-08-15 02:45:01'),(47,'李荣浩',29,'2020-10-13 12:55:02','2020-08-15 03:34:22'),(48,'赵',2,'2020-08-15 23:25:11','2020-08-15 23:24:57'),(49,'张主任',5,'2020-08-15 23:50:07','2020-08-15 23:25:14');
/*!40000 ALTER TABLE `searchword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sexclass`
--

DROP TABLE IF EXISTS `sexclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sexclass` (
  `sexid` int NOT NULL AUTO_INCREMENT,
  `sexName` varchar(10) NOT NULL,
  PRIMARY KEY (`sexid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='性别分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sexclass`
--

LOCK TABLES `sexclass` WRITE;
/*!40000 ALTER TABLE `sexclass` DISABLE KEYS */;
INSERT INTO `sexclass` VALUES (1,'男'),(2,'女'),(3,'乐队/组合');
/*!40000 ALTER TABLE `sexclass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `singer`
--

DROP TABLE IF EXISTS `singer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `singer` (
  `sgid` int NOT NULL AUTO_INCREMENT,
  `sgName` varchar(30) NOT NULL,
  `sgSex` varchar(1) DEFAULT NULL,
  `combina` varchar(1) NOT NULL DEFAULT '0',
  `birth` date DEFAULT NULL,
  `sgBgImgUrl` varchar(200) NOT NULL,
  `sgFaceUrl` varchar(200) NOT NULL,
  `sgIntro` text,
  `honor` text,
  `setIn` date DEFAULT NULL,
  `areaid` int NOT NULL,
  `sexid` int NOT NULL,
  PRIMARY KEY (`sgid`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='歌手表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `singer`
--

LOCK TABLES `singer` WRITE;
/*!40000 ALTER TABLE `singer` DISABLE KEYS */;
INSERT INTO `singer` VALUES (1,'张信哲','男','0','1990-02-07','singerBg/1.jpg','singerBg/1.jpg','我是张信哲，我为自己代言','太多，不想写','2004-04-13',1,1),(2,'张靓颖','女','0','1982-05-24','singerBg/2.jpg','singerBg/2.jpg','','','2002-05-05',1,2),(3,'薛之谦','男','0','1983-07-17','singerBg/3.jpg','singerBg/3.jpg','薛之谦（ Joker Xue），1983年7月17日出生于上海，华语流行乐男歌手、影视演员、音乐制作人，毕业于格里昂酒店管理学院。2005年，参加选秀节目《我型我秀》正式出道。2006年，发行首张同名专辑《薛之谦》，随后凭借歌曲《认真的雪》获得广泛关注。2008年，发行专辑《深深爱过你》并在上海举行个人首场演唱会“谦年传说”。2013年，专辑《几个薛之谦》获得 MusicRadio中国 TOP排行榜内地推荐唱片。2014年，专辑《意外》获得第21届东方风云榜颁奖最佳唱作人；2015年6月，薛之谦首度担当制作人并发行原创 EP《绅士》，2016年，凭借 EP《绅士》、《一半》获得第16届全球华语歌曲排行榜多项奖项，而歌曲《初学者》则获得年度二十大金曲奖。2017年4月，开启“我好像在哪见过你”全国巡回演唱会。','','2010-05-05',1,1),(4,'逃跑计划',' ','1','1990-02-07','singerBg/4.jpg','singerBg/4.jpg','','','2004-04-13',1,3),(5,'任然','女','0','1990-02-07','singerBg/5.jpg','singerBg/5.jpg','','','2004-04-13',1,2),(6,'上官大叔','男','0','1990-02-07','singerBg/6.jpg','singerBg/6.jpg','','','2004-04-13',1,1),(7,'林宥嘉','男','0','1990-02-07','singerBg/7.jpg','singerBg/7.jpg','','','2004-04-13',1,1),(8,'米津玄師 (よねづ けんし)','男','0','1990-02-07','singerBg/8.jpg','singerBg/8.jpg','','','2004-04-13',3,1),(9,'梁静茹','女','0','1982-05-24','singerBg/9.jpg','singerBg/9.jpg','','','2002-05-05',1,2),(10,'李荣浩','男','0','1990-02-07','singerBg/10.jpg','singerBg/10.jpg','','','2004-04-13',1,1),(11,'花澤香菜 (はなざわ かな)','女','0','1990-02-07','singerBg/11.jpg','singerBg/11.jpg','','','2004-04-13',3,2),(12,'东方神起 (동방신기)',' ','1','1990-02-07','singerBg/12.jpg','singerBg/12.jpg','','','2004-04-13',4,3),(13,'滨崎步 (浜崎あゆみ)','女','0','1982-05-24','singerBg/13.jpg','singerBg/13.jpg','','','2002-05-05',3,2),(14,'ZAYN (泽恩·马利克)','男','0','1982-05-24','singerBg/14.jpg','singerBg/14.jpg','','','2002-05-05',2,1),(15,'WANDS (ワンズ)',' ','1','1982-05-24','singerBg/15.jpg','singerBg/15.jpg','','','2002-05-05',3,3),(16,'Vicetone',' ','1','1982-05-24','singerBg/16.jpg','singerBg/16.jpg','','','2002-05-05',2,3),(17,'Troye Sivan (特洛耶·希文)','男','0','1990-02-07','singerBg/17.jpg','singerBg/17.jpg','','','2004-04-13',2,1),(18,'The Aces',' ','1','1990-02-07','singerBg/18.jpg','singerBg/18.jpg','','','2004-04-13',2,3),(19,'Sia (希雅·富勒)','女','0','1982-05-24','singerBg/19.jpg','singerBg/19.jpg','','','2002-05-05',2,2),(20,'Senpai','男','0','1990-02-07','singerBg/20.jpg','singerBg/20.jpg','','','2004-04-13',2,1),(21,'Sabrina Carpenter (莎布琳娜·卡潘特)','女','0','1982-05-24','singerBg/21.jpg','singerBg/21.jpg','','','2002-05-05',2,2),(22,'S.H.E',' ','1','1990-02-07','singerBg/22.jpg','singerBg/22.jpg','','','2004-04-13',1,3),(23,'PCHY','男','0','1990-02-07','singerBg/23.jpg','singerBg/23.jpg','','','2004-04-13',5,1),(24,'Meron Ryan','女','0','1982-05-24','singerBg/24.jpg','singerBg/24.jpg','','','2002-05-05',2,2),(25,'Martin Garrix (马汀·盖瑞克斯)','男','0','1982-05-24','singerBg/25.jpg','singerBg/25.jpg','','','2002-05-05',2,1),(26,'Lady Gaga (嘎嘎小姐)','女','0','1982-05-24','singerBg/26.jpg','singerBg/26.jpg','','','2002-05-05',2,2),(27,'Kondor','男','0','1990-02-07','singerBg/27.jpg','singerBg/27.jpg','','','2004-04-13',5,1),(28,'Jamie Scott (杰米·斯科特)','男','0','1990-02-07','singerBg/28.jpg','singerBg/28.jpg','','','2004-04-13',2,1),(29,'Iselin Solheim','女','0','1982-05-24','singerBg/29.jpg','singerBg/29.jpg','','','2002-05-05',2,2),(30,'G.E.M.邓紫棋','女','0','1979-01-18','singerBg/30.jpg','singerBg/30.jpg','','','2000-03-05',1,2),(31,'Farruko','男','0','1991-05-02','singerBg/31.jpg','singerBg/31.jpg','','','2004-04-13',2,1),(32,'David Guetta (大卫·库塔)','男','0','1991-05-02','singerBg/32.jpg','singerBg/32.jpg','','','2004-04-13',2,1),(33,'DAOKO (ダヲコ)','女','0','1982-05-24','singerBg/33.jpg','singerBg/33.jpg','','','2002-05-05',3,2),(34,'DAISHI DANCE (ダイシ・ダンス)','男','0','1990-02-07','singerBg/34.jpg','singerBg/34.jpg','','','2004-04-13',3,1),(35,'Cozi Zuehlsdorff','女','0','1990-02-07','singerBg/35.jpg','singerBg/35.jpg','','','2004-04-13',2,2),(36,'Cécile Corbel (塞西尔·科贝尔)','女','0','1982-05-24','singerBg/36.jpg','singerBg/36.jpg','','','2002-05-05',2,2),(37,'Blazo (布拉泽)','男','0','1991-05-02','singerBg/37.jpg','singerBg/37.jpg','','','2004-04-13',2,1),(38,'BLACKPINK (블랙핑크)',' ','1','1982-05-24','singerBg/38.jpg','singerBg/38.jpg','','','2002-05-05',4,3),(39,'Alan Walker (艾伦·沃克)','男','0','1982-05-24','singerBg/39.jpg','singerBg/39.jpg','','','2002-05-05',2,1),(40,'Romy Dya','女','0','1982-05-24','singerBg/40.jpg','singerBg/40.jpg','','','2002-05-05',2,2),(41,'Sara','女','0','1982-05-24','singerBg/41.jpg','singerBg/41.jpg','','','2002-05-05',5,2),(42,'赵政豪','男','0','2000-05-24','singerBg/42.jpg','singerBg/42.jpg',NULL,NULL,'2018-05-05',1,1),(43,'Michel Sardou','男','0','1947-01-26','singerBg/43.jpg','singerBg/43.jpg',NULL,NULL,'2006-07-12',2,1),(44,'张主任','男','0','1947-01-26','singerBg/44.jpg','singerBg/44.jpg',NULL,NULL,'2002-05-05',1,1);
/*!40000 ALTER TABLE `singer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song`
--

DROP TABLE IF EXISTS `song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `song` (
  `sid` int NOT NULL AUTO_INCREMENT,
  `sName` varchar(50) NOT NULL,
  `subName` varchar(50) DEFAULT NULL,
  `coverUrl` varchar(200) NOT NULL,
  `lyricsUrl` varchar(200) DEFAULT NULL,
  `playUrl` varchar(200) NOT NULL,
  `duration` decimal(10,6) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `playNum` int NOT NULL DEFAULT '0',
  `downLink` varchar(200) NOT NULL,
  `sgid` int NOT NULL,
  `alid` int DEFAULT NULL,
  `swid` int DEFAULT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 COMMENT='歌曲表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song`
--

LOCK TABLES `song` WRITE;
/*!40000 ALTER TABLE `song` DISABLE KEYS */;
INSERT INTO `song` VALUES (1,'年少有为',NULL,'album/1.jpg','songLyrics/年少有为.lrc','song/年少有为.mp3',279.353455,'2015-03-18 00:00:00',57,'1',10,1,1),(2,'麻雀',NULL,'album/4.jpg','songLyrics/麻雀.lrc','song/麻雀.mp3',252.786942,'2019-05-18 00:00:00',29,'2',10,4,NULL),(3,'不将就',NULL,'album/2.jpg','songLyrics/不将就.lrc','song/不将就.mp3',313.025299,'2020-09-08 04:50:00',14,'3',10,2,NULL),(4,'李白',NULL,'album/3.jpg','songLyrics/李白.lrc','song/李白.mp3',273.475922,'2017-03-18 00:00:00',19,'4',10,3,NULL),(5,'念念又不忘',NULL,'album/1.jpg','songLyrics/念念又不忘.lrc','song/念念又不忘.mp3',342.622040,'2020-09-08 04:50:00',16,'5',10,1,NULL),(6,'演员',NULL,'album/6.jpg','songLyrics/演员.lrc','song/演员.mp3',261.276733,'2015-03-18 00:00:00',15,'6',3,6,NULL),(7,'丑八怪',NULL,'album/5.jpg','songLyrics/丑八怪.lrc','song/丑八怪.mp3',248.476730,'2020-09-08 04:50:00',20,'7',3,5,NULL),(8,'你还要我怎样',NULL,'album/5.jpg','songLyrics/你还要我怎样.lrc','song/你还要我怎样.mp3',310.987762,'2020-09-08 03:45:00',9,'8',3,5,NULL),(9,'初学者',NULL,'album/7.jpg','songLyrics/初学者.lrc','song/初学者.mp3',280.032654,'2017-03-18 00:00:00',13,'9',3,7,NULL),(10,'如果爱下去',NULL,'album/10.jpg','songLyrics/如果爱下去.lrc','song/如果爱下去.mp3',242.364082,'2020-09-07 21:13:52',8,'10',2,10,NULL),(11,'Intro',NULL,'album/8.jpg','songLyrics/Intro.lrc','song/Intro.mp3',68.179592,'2015-03-18 00:00:00',16,'11',2,8,NULL),(12,'画心',NULL,'album/9.jpg','songLyrics/画心.lrc','song/画心.mp3',432.326531,'2019-05-18 00:00:00',46,'12',2,9,NULL),(13,'夜空中最亮的星',NULL,'album/12.jpg','songLyrics/夜空中最亮的星.lrc','song/夜空中最亮的星.mp3',252.264490,'2019-05-18 00:00:00',45,'13',4,12,NULL),(14,'一万次悲伤',NULL,'album/12.jpg','songLyrics/一万次悲伤.lrc','song/一万次悲伤.mp3',255.529796,'2020-09-08 04:50:00',80,'14',4,12,NULL),(15,'重来',NULL,'album/11.jpg','songLyrics/重来.lrc','song/重来.mp3',312.006531,'2020-09-08 18:23:10',57,'15',4,11,NULL),(16,'信仰',NULL,'album/13.jpg','songLyrics/信仰.lrc','song/信仰.mp3',322.220398,'2015-03-18 00:00:00',42,'16',1,13,6),(17,'别怕我伤心',NULL,'album/14.jpg','songLyrics/别怕我伤心.lrc','song/别怕我伤心.mp3',291.866119,'2020-05-18 04:50:00',879,'17',1,14,NULL),(18,'我好想你',NULL,'album/13.jpg','songLyrics/我好想你.lrc','song/我好想你.mp3',334.497955,'2019-05-18 00:00:00',29,'18',1,13,NULL),(19,'说谎',NULL,'album/16.jpg','songLyrics/说谎.lrc','song/说谎.mp3',264.202454,'2020-09-08 15:23:10',390,'19',7,16,NULL),(20,'想自由',NULL,'album/15.jpg','songLyrics/想自由.lrc','song/想自由.mp3',281.678375,'2017-03-18 00:00:00',57,'20',7,15,NULL),(21,'成全',NULL,'album/17.jpg','songLyrics/成全.lrc','song/成全.mp3',309.838379,'2020-09-08 04:50:00',3136,'21',7,17,NULL),(22,'句号',NULL,'album/18.jpg','songLyrics/句号.lrc','song/句号.mp3',235.676743,'2015-03-18 00:00:00',19,'22',30,18,NULL),(23,'光年之外',NULL,'album/19.jpg','songLyrics/光年之外.lrc','song/光年之外.mp3',235.546127,'2019-05-18 00:00:00',476,'23',30,19,NULL),(24,'倒数',NULL,'album/20.jpg','songLyrics/倒数.lrc','song/倒数.mp3',229.381226,'2016-04-25 00:00:00',463,'24',30,20,NULL),(25,'勇气',NULL,'album/21.jpg','songLyrics/勇气.lrc','song/勇气.mp3',239.333878,'2017-03-18 00:00:00',47,'25',9,21,NULL),(26,'可惜不是你',NULL,'album/22.jpg','songLyrics/可惜不是你.lrc','song/可惜不是你.mp3',285.857971,'2015-03-18 00:00:00',46,'26',9,22,NULL),(27,'你曾是少年',NULL,'album/23.jpg','songLyrics/你曾是少年.lrc','song/你曾是少年.mp3',266.684082,'2015-03-18 00:00:00',548,'27',22,23,NULL),(28,'Super Star',NULL,'album/24.jpg','songLyrics/Super Star.lrc','song/Super Star.mp3',196.388571,'2019-05-18 00:00:00',125,'28',22,24,5),(29,'Faded',NULL,'album/25.jpg','songLyrics/Faded.lrc','song/Faded.mp3',212.662857,'2016-04-25 00:00:00',53,'29',39,25,NULL),(30,'On My Way',NULL,'album/26.jpg','songLyrics/On My Way.lrc','song/On My Way.mp3',193.828571,'2017-03-18 00:00:00',87,'30',39,26,12),(31,'There For You',NULL,'album/28.jpg','songLyrics/There For You.lrc','song/There For You.mp3',221.048163,'2015-03-18 00:00:00',978,'31',25,28,NULL),(32,'So Far Away',NULL,'album/29.jpg','songLyrics/So Far Away.lrc','song/So Far Away.mp3',183.666939,'2019-05-18 00:00:00',559,'32',25,29,NULL),(33,'Move Your Body (Alan Walker Remix)',NULL,'album/30.jpg','songLyrics/Move Your Body (Alan Walker Remix).lrc','song/Move Your Body (Alan Walker Remix).mp3',217.939592,'2016-04-25 00:00:00',749,'33',39,30,NULL),(34,'Dusk Till Dawn',NULL,'album/58.jpg','songLyrics/Dusk Till Dawn.lrc','song/Dusk Till Dawn.mp3',265.978776,'2017-03-18 00:00:00',239,'34',14,58,NULL),(35,'Walk Thru Fire',NULL,'album/31.jpg','songLyrics/Walk Thru Fire.lrc','song/Walk Thru Fire.mp3',194.533878,'2015-03-18 00:00:00',457,'35',16,31,NULL),(36,'Nevada',NULL,'album/32.jpg','songLyrics/Nevada.lrc','song/Nevada.mp3',208.587755,'2015-03-18 00:00:00',568,'39',16,32,2),(37,'Lemon',NULL,'album/33.jpg','songLyrics/Lemon.lrc','song/Lemon.mp3',256.026122,'2019-05-18 00:00:00',220,'37',8,33,NULL),(38,'打上花火',NULL,'album/34.jpg','songLyrics/打上花火.lrc','song/打上花火.mp3',289.384490,'2016-04-25 00:00:00',353,'38',8,34,NULL),(39,'クランベリーとパンケーキ (蔓越莓和煎饼)',NULL,'album/33.jpg','songLyrics/クランベリーとパンケーキ (蔓越莓和煎饼).lrc','song/クランベリーとパンケーキ (蔓越莓和煎饼).mp3',210.050612,'2017-03-18 00:00:00',173,'39',8,33,3),(40,'Take Me Hand',NULL,'album/35.jpg','songLyrics/Take Me Hand.lrc','song/Take Me Hand.mp3',260.022857,'2015-03-18 00:00:00',24,'40',34,35,NULL),(41,'千と千尋の神隠し_いつも何度でも',NULL,'album/36.jpg','songLyrics/千と千尋の神隠し_いつも何度でも.lrc','song/千と千尋の神隠し_いつも何度でも.mp3',310.073469,'2015-03-18 00:00:00',106,'41',34,36,NULL),(42,'恋愛サーキュレーション (恋爱循环)',NULL,'album/38.jpg','songLyrics/恋愛サーキュレーション (恋爱循环).lrc','song/恋愛サーキュレーション (恋爱循环).mp3',253.910204,'2019-05-18 00:00:00',96,'42',11,38,NULL),(43,'sweets parade',NULL,'album/37.jpg','songLyrics/sweets parade.lrc','song/sweets parade.mp3',239.516735,'2016-04-25 00:00:00',106,'43',11,37,NULL),(44,'My All (Live)',NULL,'album/40.jpg','songLyrics/My All (Live).lrc','song/My All (Live).mp3',416.208980,'2017-03-18 00:00:00',935,'44',13,40,NULL),(45,'オヒアの木 (奥希亚之树)',NULL,'album/39.jpg','songLyrics/オヒアの木 (奥希亚之树).lrc','song/オヒアの木 (奥希亚之树).mp3',276.636735,'2015-03-18 00:00:00',216,'45',13,39,NULL),(46,'世界が終るまでは… (直到世界尽头)',NULL,'album/41.jpg','songLyrics/世界が終るまでは… (直到世界尽头).lrc','song/世界が終るまでは… (直到世界尽头).mp3',315.794286,'2015-03-18 00:00:00',5652,'46',15,41,NULL),(47,'雨に濡れて (淋湿在雨中)',NULL,'album/42.jpg','songLyrics/雨に濡れて (淋湿在雨中).lrc','song/雨に濡れて (淋湿在雨中).mp3',287.477551,'2019-05-18 00:00:00',332,'47',15,42,NULL),(48,'Sour Candy',NULL,'album/43.jpg','songLyrics/Sour Candy.lrc','song/Sour Candy.mp3',157.753469,'2016-04-25 00:00:00',365,'48',26,43,NULL),(49,'Share The World',NULL,'album/44.jpg','songLyrics/Share The World.lrc','song/Share The World.mp3',206.837551,'2017-03-18 00:00:00',383,'49',12,44,NULL),(50,'どうして君を好きになってしまったんだろう_ (为何我会喜欢上你？)',NULL,'album/45.jpg','songLyrics/どうして君を好きになってしまったんだろう_ (为何我会喜欢上你？).lrc','song/どうして君を好きになってしまったんだろう_ (为何我会喜欢上你？).mp3',198.765714,'2015-03-18 00:00:00',8455,'50',12,45,NULL),(51,'Tomorrow With You',NULL,'album/46.jpg','songLyrics/Tomorrow With You.lrc','song/Tomorrow With You.mp3',200.515918,'2015-03-18 00:00:00',4,'51',27,46,NULL),(52,'Meaningful Ways',NULL,'album/47.jpg','songLyrics/Meaningful Ways.lrc','song/Meaningful Ways.mp3',186.984490,'2019-05-18 00:00:00',3,'52',27,47,NULL),(53,'Best Moments',NULL,'album/48.jpg','songLyrics/Best Moments.lrc','song/Best Moments.mp3',209.580408,'2016-04-25 00:00:00',11,'53',37,48,NULL),(54,'Pเพียงเธอ (Pieng ter) (只有你)',NULL,'album/50.jpg','songLyrics/เพียงเธอ (Pieng ter) (只有你).lrc','song/เพียงเธอ (Pieng ter) (只有你).mp3',251.872653,'2017-03-18 00:00:00',10,'54',23,50,NULL),(55,'错过',NULL,'album/49.jpg','songLyrics/错过.lrc','song/错过.mp3',274.390204,'2015-03-18 00:00:00',0,'55',23,49,NULL),(56,'เจอกับตัวเอง___ถึงรู้',NULL,'album/51.jpg','songLyrics/เจอกับตัวเอง___ถึงรู้.lrc','song/เจอกับตัวเอง___ถึงรู้.mp3',240.875102,'2015-03-18 00:00:00',6,'56',41,51,NULL),(57,'叛',NULL,'album/52.jpg','songLyrics/叛.lrc','song/叛.mp3',216.946939,'2019-05-18 00:00:00',6,'57',41,52,NULL),(58,'Strong Enough',NULL,'album/53.jpg','songLyrics/Strong Enough.lrc','song/Strong Enough.mp3',227.709388,'2016-04-25 00:00:00',22,'58',18,53,NULL),(59,'Fake Nice',NULL,'album/54.jpg','songLyrics/Fake Nice.lrc','song/Fake Nice.mp3',203.676735,'2017-03-18 00:00:00',3,'59',18,54,NULL),(60,'Stuck',NULL,'album/53.jpg','songLyrics/Stuck.lrc','song/Stuck.mp3',245.655510,'2015-03-18 00:00:00',8,'60',18,53,NULL),(61,'无人之岛',NULL,'album/56.jpg','songLyrics/无人之岛.lrc','song/无人之岛.mp3',285.283265,'2016-04-25 00:00:00',0,'61',5,56,4),(62,'后继者',NULL,'album/57.jpg','songLyrics/后继者.lrc','song/后继者.mp3',242.703673,'2017-03-18 00:00:00',9,'62',5,57,NULL),(63,'走不出的回忆',NULL,'album/55.jpg','songLyrics/走不出的回忆.lrc','song/走不出的回忆.mp3',224.966531,'2015-03-18 00:00:00',3,'63',5,55,NULL),(64,'飞鸟',NULL,'album/56.jpg','songLyrics/飞鸟.lrc','song/飞鸟.mp3',295.000816,'2015-03-18 00:00:00',1,'64',5,56,NULL),(65,'The Spectre',NULL,'album/27.jpg','songLyrics/The Spectre.lrc','song/The Spectre.mp3',193.828571,'2015-03-18 00:00:00',0,'65',39,27,NULL),(66,'船帆',NULL,'album/59.jpg','songLyrics/船帆.lrc','song/船帆.mp3',200.045714,'2019-04-23 00:00:00',1,'66',42,59,11),(67,'La maladie d\'amour',NULL,'album/60.jpg','songLyrics/La maladie d\'amour.lrc','song/La maladie d\'amour.mp3',212.816548,'2010-03-03 00:00:00',12,'67',43,60,NULL),(68,'信仰','(原唱：张信哲)','album/61.jpg','songLyrics/信仰 - 张主任.lrc','song/信仰 - 张主任.mp3',323.112121,'2017-04-23 00:00:00',1,'68',44,61,6);
/*!40000 ALTER TABLE `song` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `songlabel`
--

DROP TABLE IF EXISTS `songlabel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `songlabel` (
  `slbid` int NOT NULL AUTO_INCREMENT,
  `sid` int DEFAULT NULL,
  `lbid` int DEFAULT NULL,
  PRIMARY KEY (`slbid`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COMMENT='歌曲标签关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `songlabel`
--

LOCK TABLES `songlabel` WRITE;
/*!40000 ALTER TABLE `songlabel` DISABLE KEYS */;
INSERT INTO `songlabel` VALUES (1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,1,8),(6,2,8),(7,3,8),(8,4,8),(9,12,6),(10,7,6),(11,4,6),(12,5,6),(13,7,6),(14,6,6),(15,3,6),(16,24,6),(17,35,6),(18,15,6),(19,45,6),(20,11,6),(21,9,6),(22,31,6),(23,41,6),(24,38,6),(25,33,6),(26,36,6),(27,17,6),(28,8,6),(29,35,5),(30,56,5),(31,61,5),(32,10,5),(33,35,2),(34,15,2),(35,3,2),(36,16,2),(37,5,2),(38,45,2),(39,8,2),(40,51,3),(41,35,3),(42,15,3),(43,31,3),(44,16,3),(45,52,3),(46,45,3),(47,25,3),(48,51,3),(49,11,4),(50,3,4),(51,15,4),(52,55,4),(53,33,4),(54,24,4),(55,38,7),(56,11,7),(57,19,7),(58,56,7),(59,48,7),(60,65,7),(61,56,7),(62,64,7),(63,63,7),(64,62,7),(65,38,9),(66,11,9),(67,19,9),(68,56,9),(69,48,9),(70,65,9),(71,56,9),(72,64,9),(73,63,9),(74,62,9);
/*!40000 ALTER TABLE `songlabel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `uName` varchar(11) NOT NULL,
  `pwd` varchar(200) NOT NULL,
  `nickName` varchar(15) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `faceUrl` varchar(200) NOT NULL DEFAULT 'face/default.jpg',
  `area` varchar(50) DEFAULT NULL,
  `intro` varchar(200) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `token` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uName` (`uName`),
  UNIQUE KEY `nickName_UNIQUE` (`nickName`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'180001','202cb962ac59075b964b07152d234b70','就大佛女孩','女','1985-06-01','face/180001M1604719231.jpg','上海市 上海市 普陀区','现实中我唯唯诺诺，网络中我重拳出击；现实中我唯唯诺诺，网络中我重拳出击','2020-11-07 11:21:06','2020-06-15 00:00:00','4991450e2f934c60e0d3c988a150adee87a2099e02a364fd9fbde67cacd7023c'),(2,'180002','202cb962ac59075b964b07152d234b70','白沭de信仰','男','2000-12-05','face/180002M1604683606.jpg','四川省 成都市 新都区','现实中我怂的一批，网络中我重拳出击','2020-11-07 01:52:20','2020-07-01 00:00:00','ea37220158bc0f1a1699709bcd715034d76207e78179aad3ae1775be7d0c8165'),(3,'180005','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'face/default.jpg',NULL,NULL,'2020-11-03 17:06:20','2020-11-03 16:54:50','075880ccbac56e20039ccac70adc61f7db1487b9efff75935768795d1bbe9c0e'),(4,'180004','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'face/default.jpg',NULL,NULL,'2020-11-03 17:15:45','2020-11-03 17:15:45',NULL),(9,'123456','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'face/default.jpg',NULL,NULL,'2020-11-04 15:52:42','2020-11-04 15:52:28','0c222c84da24a9dc579ec40f170d28cccbf54f4965bc3dd299f3605f61515bd4'),(10,'18301047','202cb962ac59075b964b07152d234b70','往事如烟','男','1999-12-15','face/18301047M1604685743.jpg','四川省 广安市 广安区',NULL,'2020-11-07 02:03:29','2020-11-07 02:01:07','5ec078cbc2a09c67442a9f9c25bee3c6dbb04bb165fe2d5e0718029e4cb4e192');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergedan`
--

DROP TABLE IF EXISTS `usergedan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usergedan` (
  `ugid` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL,
  `gdid` int DEFAULT NULL,
  `source` enum('创建','收藏') DEFAULT NULL,
  PRIMARY KEY (`ugid`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COMMENT='用户歌单关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergedan`
--

LOCK TABLES `usergedan` WRITE;
/*!40000 ALTER TABLE `usergedan` DISABLE KEYS */;
INSERT INTO `usergedan` VALUES (1,1,1,'创建'),(4,2,4,'创建'),(5,2,5,'创建'),(6,2,6,'创建'),(7,2,7,'创建'),(8,2,8,'创建'),(9,1,9,'创建'),(10,1,10,'创建'),(12,1,12,'创建'),(14,2,14,'收藏'),(15,2,15,'收藏'),(16,1,14,'创建'),(43,9,11,'创建'),(44,9,13,'创建'),(45,4,14,'创建'),(46,4,15,'创建'),(50,4,2,'创建'),(67,1,7,'收藏'),(68,2,1,'收藏'),(71,1,36,'创建');
/*!40000 ALTER TABLE `usergedan` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-08 19:05:43
