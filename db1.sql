-- 创建音乐数据库
create database db_music;
-- 使用音乐数据库
use db_music;
-- 创建数据表
-- 1.管理员表(admin)
create table admin(
  aid int primary key auto_increment,
  adName varchar(10) UNIQUE not null,
  pwd varchar(200) not null,
  name varchar(10) not null,
  tel varchar(15) not null
) comment '管理员表';

-- 2.用户表(user)
create table user
(
  uid int primary key auto_increment,
  uName varchar(10) UNIQUE not null,
  pwd varchar(200) not null,
  nickName varchar(15) not null,
  sex varchar(1),
  birth date,
  faceUrl varchar(200) not null,
  area varchar(50),
  intro varchar(200),
  regTime datetime not null
)comment '用户表';

--3.歌手表(singer) 已修改
create table singer
(
  sgid int primary key auto_increment,
  sgName varchar(30) not null,
  sgSex varchar(1),
  sgcombina varchar(1) not null default 0,
  birth date,
  sgBgImgUrl varchar(200) not null,
  sgFaceUrl varchar(200) not null,
  sgIntro text,
  honor text,
  setIn date,
  areaid int references areaClass(areaid) not null,
  sexid int references sexClass(sexid) not null
)comment '歌手表';

-- 4.专辑表(album)  已修改
create table album(
  alid int primary key auto_increment,
  alName varchar(50) not null,
  alImgUrl varchar(200) not null,
  alIntro text,
  alResTime date not null,
  sgid int references singer(sgid) not null
) comment '专辑表';

-- 5.歌曲表(song)  已修改
create table song
(
  sid int primary key auto_increment,
  sName varchar(50) not null,
  subName varchar(50),
  coverUrl varchar(200) not null,
  lyricsUrl varchar(200),
  playUrl varchar(200) not null,
  duration decimal(10,6) not null,
  sResTime date not null,
  playNum varchar(5) not null default 0,
  downLink varchar(200) not null,
  sgid int references singer(sgid) not null,
  alid int references album(alid),
  gdid int references gedan(gdid)
)comment '歌曲表';

-- 6.歌手地区分类表(areaClass) 已修改
create table areaClass(
  areaid int primary key auto_increment,
  areaName varchar(10) not null
) comment '地区分类表';

-- 7.歌手性别分类表(sexClass) 已修改
create table sexClass(
  sexid int primary key auto_increment,
  sexName varchar(10) not null
) comment '性别分类表';

-- 8.标签表(label)
create table label(
  lbId int primary key auto_increment,
  lbName varchar(10) not null
) comment '标签表';

-- 9.评论表(comment) // 为使用
create table comment(
  comid int primary key auto_increment,
  title varchar(30) not null,
  content text not null,
  comResTime varchar(200) not null,
  lick varchar(10) not null,
  uid int references user(uid),
  sid int references song(sid)
)comment '评论表';

-- 10.关注关系表(atten)  // 未使用
create table atten(
  attid int primary key auto_increment,
  uid int references user(uid),
  sgid int references singer(sgid)
) comment '关注关系表';

-- 11.下载关系表(download) // 未使用
create table download(
  downId int primary key auto_increment,
  uid int references user(uid),
  sid int references song(sid)
) comment '下载关系表';

-- 12.精品推荐表(recommend)
create table recommend(
  rid int primary key auto_increment,
  rpicUrl varchar(200) not null,
  rintro text,
  rLink varchar(200)
) comment '精品推荐表';

-- 13.歌单表(gedan)
create table gedan(
  gdid int primary key auto_increment,
  gdCover varchar(200) not null,
  gdTitle varchar(100) not null,
  gdIntro text,
  gdPlayNum varchar(10) not null default 0,
  uid int references user(uid)
) comment '歌单表';

-- 14.歌单歌曲关系表(gedanSong) 
create table gedanSong(
  gsid int primary key auto_increment,
  gdid int references gedan(gdid),
  sid int references song(sid)
) comment '歌单歌曲关系表';

-- 15.排行榜(Rankboard)
create table Rankboard
(
  rbid int primary key auto_increment,
  rbTitle varchar(20) not null
  rbPicUrl varchar(200) not null default 'rankBoard/default.jpg',
  rbPlayNum int not null default 0
) comment '排行榜表';

-- 16.搜索词表(searchWord)
create table searchWord
(
  hwid int primary key auto_increment, 主键id
  hwName varchar(20) UNIQUE not null,  搜索名称
  scount int not null default 0,       搜索次数 
  updated_at datetime,                 最近搜索时间
  created_at datetime,                 第一次搜索时间
  hwType varchar(10),                  搜索词类型(歌手/歌曲/专辑)
  sid int references song(sid),        歌曲表外键
  alid int references album(alid),     专辑表外键
  sgid int references singer(sgid)     歌手表外键
) comment '搜索热词表';

-- 17.排行歌曲关系表(RankSong) 
create table RankSong
(
  rsid int primary key auto_increment,
  sid int references song(sid),
  rbid int references rankboard(rbid)
) comment '排行歌曲关系表';

-- 18.歌曲标签关系表(songLabel)
create table songLabel(
  slbid int primary key auto_increment,
  sid int references song(sid),
  lbid int references label(lbid)
) comment '歌曲标签关系表';

-- 19.用户歌单关系表(userGedan)
create table userGedan(
  ugid int primary key auto_increment,
  uid int references user(uid),
  gdid int references gedan(gdid)
) comment '用户歌单关系表';

--20.喜欢的歌曲表(favouriteSong)
create table favouriteSong(
  fsid int primary key auto_increment,
  uid int references user(uid),
  sid int references song(sid)
) comment '喜欢的歌曲表';

--21.收藏歌单表(collectGedan)
create table collectGedan(
  cgid int primary key auto_increment,
  uid int references user(uid),
  sid int references song(sid)
) comment '喜欢的歌曲表';


insert into recommend values 
(1,'banner/1.jpg','','1'),
(2,'banner/2.jpg','','2'),
(3,'banner/3.jpg','','3'),
(4,'banner/4.jpg','','4'),
(5,'banner/5.jpg','','5');

ALTER TABLE singer AUTO_INCREMENT=1;

insert into areaClass values(1,'华语'),(2,'欧美'),(3,'日本'),(4,'韩国'),(5,'其他');
insert into sexClass values(1,'男'),(2,'女'),(3,'乐队/组合');

singer {
  insert into singer values(1,'张信哲','男','0','1990-2-07','singerBg/张信哲.jpg','singerBg/张信哲.jpg','','','2004-4-13',1,1);
  insert into singer values(2,'张靓颖','女','0','1982-5-24','singerBg/张靓颖.jpg','singerBg/张靓颖.jpg','','','2002-5-05',1,2);
  insert into singer values(3,'薛之谦','男','0','1983-7-17','singerBg/薛之谦.jpg','singerBg/薛之谦.jpg','','','2010-5-05',1,1);
  insert into singer values(4,'逃跑计划',' ','1','1990-2-07','singerBg/逃跑计划.jpg','singerBg/逃跑计划.jpg','','','2004-4-13',1,3);
  insert into singer values(5,'任然','女','0','1990-2-07','singerBg/任然.jpg','singerBg/任然.jpg','','','2004-4-13',1,2);
  insert into singer values(6,'上官大叔','男','0','1990-2-07','singerBg/上官大叔.jpg','singerBg/上官大叔.jpg','','','2004-4-13',1,1);
  insert into singer values(7,'林宥嘉','男','0','1990-2-07','singerBg/林宥嘉.jpg','singerBg/林宥嘉.jpg','','','2004-4-13',1,1);
  insert into singer values(8,'米津玄師 (よねづ けんし)','男','0','1990-2-07','singerBg/米津玄師 (よねづ けんし).jpg','singerBg/米津玄師 (よねづ けんし).jpg','','','2004-4-13',3,1);
  insert into singer values(9,'梁静茹','女','0','1982-5-24','singerBg/梁静茹.jpg','singerBg/梁静茹.jpg','','','2002-5-05',1,2);
  insert into singer values(10,'李荣浩','男','0','1990-2-07','singerBg/李荣浩.jpg','singerBg/李荣浩.jpg','','','2004-4-13',1,1);
  insert into singer values(11,'花澤香菜 (はなざわ かな)','女','0','1990-2-07','singerBg/花澤香菜 (はなざわ かな).jpg','singerBg/花澤香菜 (はなざわ かな).jpg','','','2004-4-13',3,2);
  insert into singer values(12,'东方神起 (동방신기)',' ','1','1990-2-07','singerBg/东方神起 (동방신기).jpg','singerBg/东方神起 (동방신기).jpg','','','2004-4-13',4,3);
  insert into singer values(13,'滨崎步 (浜崎あゆみ)','女','0','1982-5-24','singerBg/滨崎步 (浜崎あゆみ).jpg','singerBg/滨崎步 (浜崎あゆみ).jpg','','','2002-5-05',1,2);
  insert into singer values(14,'ZAYN (泽恩·马利克)','男','0','1982-5-24','singerBg/ZAYN (泽恩·马利克).jpg','singerBg/ZAYN (泽恩·马利克).jpg','','','2002-5-05',2,1);
  insert into singer values(15,'WANDS (ワンズ)',' ','1','1982-5-24','singerBg/WANDS (ワンズ).jpg','singerBg/WANDS (ワンズ).jpg','','','2002-5-05',3,3);
  insert into singer values(16,'Vicetone',' ','1','1982-5-24','singerBg/Vicetone.jpg','singerBg/Vicetone.jpg','','','2002-5-05',2,3);
  insert into singer values(17,'Troye Sivan (特洛耶·希文)','男','0','1990-2-07','singerBg/Troye Sivan (特洛耶·希文).jpg','singerBg/Troye Sivan (特洛耶·希文).jpg','','','2004-4-13',2,1);
  insert into singer values(18,'The Aces',' ','1','1990-2-07','singerBg/The Aces.jpg','singerBg/The Aces.jpg','','','2004-4-13',2,3);
  insert into singer values(19,'Sia (希雅·富勒)','女','0','1982-5-24','singerBg/Sia.jpg','singerBg/Sia.jpg','','','2002-5-05',2,2);
  insert into singer values(20,'Senpai','男','0','1990-2-07','singerBg/Senpai.jpg','singerBg/Senpai.jpg','','','2004-4-13',2,1);
  insert into singer values(21,'Sabrina Carpenter (莎布琳娜·卡潘特)','女','0','1982-5-24','singerBg/Sabrina Carpenter (莎布琳娜·卡潘特).jpg','singerBg/Sabrina Carpenter (莎布琳娜·卡潘特).jpg','','','2002-5-05',2,2);
  insert into singer values(22,'S.H.E',' ','1','1990-2-07','singerBg/S.H.E.jpg','singerBg/S.H.E.jpg','','','2004-4-13',1,3);
  insert into singer values(23,'PCHY','男','0','1990-2-07','singerBg/PCHY.jpg','singerBg/PCHY.jpg','','','2004-4-13',5,1);
  insert into singer values(24,'Meron Ryan','女','0','1982-5-24','singerBg/Meron Ryan.jpg','singerBg/Meron Ryan.jpg','','','2002-5-05',2,2);
  insert into singer values(25,'Martin Garrix (马汀·盖瑞克斯)','男','0','1982-5-24','singerBg/Martin Garrix (马汀·盖瑞克斯).jpg','singerBg/Martin Garrix (马汀·盖瑞克斯).jpg','','','2002-5-05',2,1);
  insert into singer values(26,'Lady Gaga (嘎嘎小姐)','女','0','1982-5-24','singerBg/Lady Gaga (嘎嘎小姐).jpg','singerBg/Lady Gaga (嘎嘎小姐).jpg','','','2002-5-05',2,2);
  insert into singer values(27,'Kondor','男','0','1990-2-07','singerBg/Kondor.jpg','singerBg/Kondor.jpg','','','2004-4-13',5,1);
  insert into singer values(28,'Jamie Scott (杰米·斯科特)','男','0','1990-2-07','singerBg/Jamie Scott (杰米·斯科特).jpg','singerBg/Jamie Scott (杰米·斯科特).jpg','','','2004-4-13',2,1);
  insert into singer values(29,'Iselin Solheim','女','0','1982-5-24','singerBg/Iselin Solheim.jpg','singerBg/Iselin Solheim.jpg','','','2002-5-05',2,2);
  insert into singer values(30,'G.E.M.邓紫棋','女','0','1979-1-18','singerBg/G.E.M.邓紫棋.jpg','singerBg/G.E.M.邓紫棋.jpg','','','2000-3-5',1,2);
  insert into singer values(31,'Farruko','男','0','1991-05-02','singerBg/Farruko.jpg','singerBg/Farruko.jpg','','','2004-4-13',2,1);
  insert into singer values(32,'David Guetta (大卫·库塔)','男','0','1991-05-02','singerBg/David Guetta (大卫·库塔).jpg','singerBg/David Guetta (大卫·库塔).jpg','','','2004-4-13',2,1);
  insert into singer values(33,'DAOKO (ダヲコ)','女','0','1982-5-24','singerBg/DAOKO (ダヲコ).jpg','singerBg/DAOKO (ダヲコ).jpg','','','2002-5-05',3,2);
  insert into singer values(34,'DAISHI DANCE (ダイシ・ダンス)','男','0','1990-2-07','singerBg/DAISHI DANCE (ダイシ・ダンス).jpg','singerBg/DAISHI DANCE (ダイシ・ダンス).jpg','','','2004-4-13',3,1);
  insert into singer values(35,'Cozi Zuehlsdorff','女','0','1990-2-07','singerBg/Cozi Zuehlsdorff.jpg','singerBg/Cozi Zuehlsdorff.jpg','','','2004-4-13',2,2);
  insert into singer values(36,'Cécile Corbel (塞西尔·科贝尔)','女','0','1982-5-24','singerBg/Cécile Corbel (塞西尔·科贝尔).jpg','singerBg/Cécile Corbel (塞西尔·科贝尔).jpg','','','2002-5-05',2,2);
  insert into singer values(37,'Blazo (布拉泽)','男','0','1991-05-02','singerBg/Blazo (布拉泽).jpg','singerBg/Blazo (布拉泽).jpg','','','2004-4-13',2,1);
  insert into singer values(38,'BLACKPINK (블랙핑크)',' ','1','1982-5-24','singerBg/BLACKPINK (블랙핑크).jpg','singerBg/BLACKPINK (블랙핑크).jpg','','','2002-5-05',4,3);
  insert into singer values(39,'Alan Walker (艾伦·沃克)','男','0','1982-5-24','singerBg/Alan Walker (艾伦·沃克).jpg','singerBg/Alan Walker (艾伦·沃克).jpg','','','2002-5-05',2,1);
  insert into singer values(40,'Romy Dya','女','0','1982-5-24','singerBg/Romy Dya.jpg','singerBg/Romy Dya.jpg','','','2002-5-05',2,2);
  insert into singer values(41,'Sara','女','0','1982-5-24','singerBg/Sara.jpg','singerBg/Sara.jpg','','','2002-5-05',5,2);
}

album {
  insert into album values(1,'耳朵','album/1.jpg','李荣浩的专辑','2015-3-20', 10);
  insert into album values(2,'有理想','album/2.jpg','李荣浩的专辑','2019-5-18', 10);
  insert into album values(3,'模特','album/3.jpg','李荣浩的专辑','2016-4-25', 10);
  insert into album values(4,'麻雀','album/4.jpg','李荣浩的专辑','2017-3-22', 10);
  insert into album values(5,'意外','album/5.jpg','薛之谦的专辑','2015-3-20', 3);
  insert into album values(6,'绅士','album/6.jpg','薛之谦的专辑','2019-5-18', 3);
  insert into album values(7,'初学者','album/7.jpg','薛之谦的专辑','2016-4-25', 3);
  insert into album values(8,'我相信','album/8.jpg','张靓颖的专辑','2017-3-22', 2);
  insert into album values(9,'画心','album/9.jpg','张靓颖的专辑','2017-3-22', 2);
  insert into album values(10,'The One','album/10.jpg','张靓颖的专辑','2017-3-22', 2);
  insert into album values(11,'重来','album/11.jpg','逃跑计划的专辑','2015-3-20', 4);
  insert into album values(12,'世界','album/12.jpg','逃跑计划的专辑','2019-5-18', 4);
  insert into album values(13,'歌 时代II','album/13.jpg','张信哲的专辑','2016-4-25', 1);
  insert into album values(14,'等待','album/14.jpg','张信哲的专辑','2017-3-22', 1);
  insert into album values(15,'美妙生活','album/15.jpg','林宥嘉的专辑','2015-3-20',7);
  insert into album values(16,'感官-世界','album/16.jpg','林宥嘉的专辑','2019-5-18', 7);
  insert into album values(17,'成全','album/17.jpg','林宥嘉的专辑','2019-5-18', 7);
  insert into album values(18,'摩天动物园','album/18.jpg','邓紫棋的专辑','2015-3-20',30);
  insert into album values(19,'光年之外','album/19.jpg','邓紫棋的专辑','2019-5-18', 30);
  insert into album values(20,'另一个通话','album/20.jpg','邓紫棋的专辑','2019-5-18', 30);
  insert into album values(21,'勇气','album/21.jpg','梁静茹的专辑','2015-3-20',9);
  insert into album values(22,'丝路','album/22.jpg','梁静茹的专辑','2019-5-18', 9);
  insert into album values(23,'你曾是少年','album/23.jpg','S.H.E的专辑','2016-4-25', 22);
  insert into album values(24,'Super Star','album/24.jpg','S.H.E的专辑','2017-3-22', 22);
  insert into album values(25,'Faded(憔悴不堪)','album/25.jpg','Alan Walker的专辑','2015-3-20',39);
  -- insert into album values(25,'Faded(憔悴不堪)','album/25.jpg','Iselin Solheim的专辑','2015-3-20', 29);
  insert into album values(26,'On My Way','album/26.jpg','Alan Walker的专辑','2016-4-25', 39);
  -- insert into album values(28,'On My Way','album/26.jpg','Sabrina Carpenter的专辑','2016-4-25', 21);
  -- insert into album values(29,'On My Way','album/26.jpg','Farruko的专辑','2016-4-25', 31);
  insert into album values(27,'The Spectre','album/27.jpg','Alan Walker的专辑','2017-3-22', 39);
  insert into album values(28,'There For You','album/28.jpg','Martin Garrix的专辑','2015-3-20', 25);
  -- insert into album values(28,'There For You','album/28.jpg','Troye Sivan的专辑','2015-3-20', 17);
  insert into album values(29,'So Far Away','album/29.jpg','Martin Garrix的专辑','2016-4-25', 25);
  -- insert into album values(29,'So Far Away','album/29.jpg','David Guetta的专辑','2016-4-25', 32);
  -- insert into album values(29,'So Far Away','album/29.jpg','Jamie Scott的专辑','2016-4-25',28);
  -- insert into album values(29,'So Far Away','album/29.jpg','Romy Dya的专辑','2016-4-25', 40);
  -- insert into album values(30,'This Is Acting (Deluxe Version)','album/30.jpg','Sia的专辑','2016-4-25', 19);
  insert into album values(30,'This Is Acting (Deluxe Version)','album/30.jpg','Alan Walker的专辑','2016-4-25', 39);
  -- insert into album values(31,'Dusk Till Dawn','album/31.jpg','Sia的专辑','2017-3-22', 19);
  insert into album values(31,'Walk Thru Fire','album/31.jpg','Vicetone的专辑','2017-3-22', 16);
  -- insert into album values(31,'Walk Thru Fire','album/31.jpg','Cozi Zuehlsdorff的专辑','2017-3-22', 35);
  insert into album values(32,'Nevada','album/32.jpg','Vicetone的专辑','2019-5-18', 16);
  -- insert into album values(32,'Nevada','album/32.jpg','Meron Ryan的专辑','2019-5-18', 24);
  insert into album values(33,'Lemon(柠檬)','album/33.jpg','米津玄師的专辑','2017-3-22', 8);
  insert into album values(34,'打上花火(初回限定盤)','album/34.jpg','米津玄師的专辑','2015-3-20',8);
  -- insert into album values(34,'打上花火(初回限定盤)','album/34.jpg','DAOKO的专辑','2015-3-20',33);
  insert into album values(35,'WONDER Tourism','album/35.jpg','DAISHI DANCE的专辑','2019-5-18', 34);
  -- insert into album values(35,'WONDERa Tourism','album/35.jpg','Cécile Corbel的专辑','2019-5-18', 36);
  insert into album values(36,'the ジブリ set','album/36.jpg','DAISHI DANCE的专辑','2017-3-22', 34);
  insert into album values(37,'妖狐×僕SS ENDING SONG Vol.3','album/37.jpg','花澤香菜的专辑','2017-3-22', 11);
  insert into album values(38,'恋爱サーキュレーション (恋爱循环)','album/38.jpg','花澤香菜的专辑','2017-5-22', 11);
  insert into album values(39,'オヒアの木 (奥希亚之树)','album/39.jpg','滨崎步的专辑','2015-3-20',13);
  insert into album values(40,'GUILTY (原罪)','album/40.jpg','滨崎步的专辑','2019-5-18', 13);
  insert into album values(41,'倾耳倾听I-第一乐章','album/41.jpg','WANDS的专辑','2016-4-25', 15);
  insert into album values(42,'果てしない夢を (把无尽的梦)','album/42.jpg','WANDS的专辑','2017-3-22', 15);
  -- insert into album values(43,'Sour Candy','album/43.jpg','BLACKPINK的专辑','2015-3-20',38);
  insert into album values(43,'Sour Candy','album/43.jpg','Lady Gaga的专辑','2015-3-20', 26);
  insert into album values(44,'TOHOSHINKI LIVE CD COLLECTION ～The Secret Code～ FINAL i','album/44.jpg','东方神起的专辑','2016-4-25', 12);
  insert into album values(45,'どうして君を好きになってしまったんだろう？ (为何会喜欢上你)','album/45.jpg','东方神起的专辑','2017-3-22', 12);
  insert into album values(46,'Tomorrow With You (我们的明天)','album/46.jpg','Kondor的专辑','2017-3-22', 27);
  -- insert into album values(46,'Tomorrow With You (我们的明天)','album/46.jpg','Senpai的专辑','2017-3-22', 20);
  insert into album values(47,'Peace of body','album/47.jpg','Kondor的专辑','2017-3-22', 27);
  insert into album values(48,'ALONE JOURNEY','album/48.jpg','Blazo的专辑','2019-5-18', 37);
  -- insert into album values(47,'ALONE JOURNEY','album/48.jpg','Kondor的专辑','2019-5-18', 27);
  insert into album values(49,'还好遇见你','album/49.jpg','PCHY的专辑','2017-3-22', 23);
  insert into album values(50,'The Love of Siam (Original Soundtrack)','album/50.jpg','PCHY的专辑','2015-3-20',23);
  insert into album values(51,'15首全球至伤情歌1','album/51.jpg','Sara的专辑','2019-5-18', 41);
  insert into album values(52,'呼和浩特hohhot','album/52.jpg','Sara的专辑','2016-4-25', 41);
  -- insert into album values(52,'呼和浩特hohhot','album/52.jpg','上官大叔的专辑','2016-4-25', 6);
  insert into album values(53,'When My Heart Felt Volcanic','album/53.jpg','The Aces的专辑','2017-3-22', 18);
  insert into album values(54,'Fake Nice','album/54.jpg','The Aces的专辑','2017-1-22', 18);
  insert into album values(55,'走不出的回忆','album/55.jpg','任然的专辑','2017-3-22', 5);
  insert into album values(56,'没有发生的爱情','album/56.jpg','任然的专辑','2017-3-22', 5);
  insert into album values(57,'后继者','album/57.jpg','任然的专辑','2017-3-22', 5);
  insert into album values(58,'Dusk Till Dawn','album/58.jpg','ZAYN的专辑','2017-3-22', 14);

}

song {
  insert into song values (1,'年少有为','album/1.jpg','songLyrics/年少有为.lrc','song/年少有为.mp3','04:39','2015-3-18','0',1,10,1);
  insert into song values (2,'麻雀','album/4.jpg','songLyrics/麻雀.lrc','song/麻雀.mp3','04:12','2019-5-18','0',2,10,4);
  insert into song values (3,'不将就','album/2.jpg','songLyrics/不将就.lrc','song/不将就.mp3','05:13','2016-4-25','0',3,10,2);
  insert into song values (4,'李白','album/3.jpg','songLyrics/李白.lrc','song/李白.mp3','04:33','2017-3-18','0',4,10,3);
  insert into song values (5,'念念又不忘','album/1.jpg','songLyrics/念念又不忘.lrc','song/念念又不忘.mp3','05:42','2015-3-18','0',5,10,1);
  insert into song values (6,'演员','album/6.jpg','songLyrics/演员.lrc','song/演员.mp3','04:21','2015-3-18','0',6,3,6);
  insert into song values (7,'丑八怪','album/5.jpg','songLyrics/丑八怪.lrc','song/丑八怪.mp3','04:08','2019-5-18','0',7,3,5);
  insert into song values (8,'你还要我怎样','album/5.jpg','songLyrics/你还要我怎样.lrc','song/你还要我怎样.mp3','05:11','2016-4-25','0',8,3,5);
  insert into song values (9,'初学者','album/7.jpg','songLyrics/初学者.lrc','song/初学者.mp3','04:40','2017-3-18','0',9,3,7);
  insert into song values (10,'如果爱下去','album/10.jpg','songLyrics/如果爱下去.lrc','song/如果爱下去.mp3','04:02','2015-3-18','0',10,2,10);
  insert into song values (11,'Intro','album/8.jpg','songLyrics/Intro.lrc','song/Intro.mp3','01:08','2015-3-18','0',11,2,8);
  insert into song values (12,'画心','album/9.jpg','songLyrics/画心.lrc','song/画心.mp3','07:12','2019-5-18','0',12,2,9);
  insert into song values (13,'夜空中最亮的星','album/12.jpg','songLyrics/夜空中最亮的星.lrc','song/夜空中最亮的星.mp3','04:12','2019-5-18','0',13,4,12);
  insert into song values (14,'一万次悲伤','album/12.jpg','songLyrics/一万次悲伤.lrc','song/一万次悲伤.mp3','04:15','2016-4-25','0',14,4,12);
  insert into song values (15,'重来','album/11.jpg','songLyrics/重来.lrc','song/重来.mp3','05:12','2017-3-18','0',15,4,11);
  insert into song values (16,'信仰','album/13.jpg','songLyrics/信仰.lrc','song/信仰.mp3','05:22','2015-3-18','0',16,1,13);
  insert into song values (17,'别怕我伤心','album/14.jpg','songLyrics/别怕我伤心.lrc','song/别怕我伤心.mp3','04:51','2015-3-18','0',17,1,14);
  insert into song values (18,'我好想你','album/13.jpg','songLyrics/我好想你.lrc','song/我好想你.mp3','05:34','2019-5-18','0',18,1,13);
  insert into song values (19,'说谎','album/16.jpg','songLyrics/说谎.lrc','song/说谎.mp3','04:24','2016-4-25','0',19,7,16);
  insert into song values (20,'想自由','album/15.jpg','songLyrics/想自由.lrc','song/想自由.mp3','04:41','2017-3-18','0',20,7,15);
  insert into song values (21,'成全','album/17.jpg','songLyrics/成全.lrc','song/成全.mp3','05:09','2015-3-18','0',21,7,17);
  insert into song values (22,'句号','album/18.jpg','songLyrics/句号.lrc','song/句号.mp3','03:55','2015-3-18','0',22,30,18);
  insert into song values (23,'光年之外','album/19.jpg','songLyrics/光年之外.lrc','song/光年之外.mp3','03:55','2019-5-18','0',23,30,19);
  insert into song values (24,'倒数','album/20.jpg','songLyrics/倒数.lrc','song/倒数.mp3','03:49','2016-4-25','0',24,30,20);
  insert into song values (25,'勇气','album/21.jpg','songLyrics/勇气.lrc','song/勇气.mp3','03:59','2017-3-18','0',25,9,21);
  insert into song values (26,'可惜不是你','album/22.jpg','songLyrics/可惜不是你.lrc','song/可惜不是你.mp3','04:45','2015-3-18','0',26,9,22);
  insert into song values (27,'你曾是少年','album/23.jpg','songLyrics/你曾是少年.lrc','song/你曾是少年.mp3','04:26','2015-3-18','0',27,22,23);
  insert into song values (28,'Super Star','album/24.jpg','songLyrics/Super Star.lrc','song/Super Star.mp3','03:16','2019-5-18','0',28,22,24);
  insert into song values (29,'Faded','album/25.jpg','songLyrics/Faded.lrc','song/Faded.mp3','03:32','2016-4-25','0',29,39,25);
  -- insert into song values (30,'Faded','album/25.jpg','songLyrics/Faded.lrc','song/Faded.mp3','03:32','2016-4-25','0',29,29,25);
  insert into song values (30,'On My Way','album/26.jpg','songLyrics/On My Way.lrc','song/On My Way.mp3','03:13','2017-3-18','0',30,39,26);
  -- insert into song values (32,'On My Way','album/26.jpg','songLyrics/On My Way.lrc','song/On My Way.mp3','03:13','2017-3-18','0',30,21,28);
  -- insert into song values (33,'On My Way','album/26.jpg','songLyrics/On My Way.lrc','song/On My Way.mp3','03:13','2017-3-18','0',30,31,29);
  insert into song values (31,'There For You','album/28.jpg','songLyrics/There For You.lrc','song/There For You.mp3','03:41','2015-3-18','0',31,25,28);
  -- insert into song values (36,'There For You','album/28.jpg','songLyrics/There For You.lrc','song/There For You.mp3','03:41','2015-3-18','0',31,17,32);
  insert into song values (32,'So Far Away','album/29.jpg','songLyrics/So Far Away.lrc','song/So Far Away.mp3','03:03','2019-5-18','0',32,25,29);
  -- insert into song values (38,'So Far Away','album/29.jpg','songLyrics/So Far Away.lrc','song/So Far Away.mp3','03:03','2019-5-18','0',36,32,34);
  -- insert into song values (39,'So Far Away','album/29.jpg','songLyrics/So Far Away.lrc','song/So Far Away.mp3','03:03','2019-5-18','0',36,28,35);
  -- insert into song values (40,'So Far Away','album/29.jpg','songLyrics/So Far Away.lrc','song/So Far Away.mp3','03:03','2019-5-18','0',36,40,36);
  insert into song values (33,'Move Your Body (Alan Walker Remix)','album/30.jpg','songLyrics/Move Your Body (Alan Walker Remix).lrc','song/Move Your Body (Alan Walker Remix).mp3','03:37','2016-4-25','0',33,39,30);
  -- insert into song values (42,'Move Your Body (Alan Walker Remix)','album/30.jpg','songLyrics/Move Your Body (Alan Walker Remix).lrc','song/Move Your Body (Alan Walker Remix).mp3','03:37','2016-4-25','0',33,19,37);
  -- insert into song values (43,'Dusk Till Dawn','album/58.jpg','songLyrics/Dusk Till Dawn.lrc','song/Dusk Till Dawn.mp3','04:26','2017-3-18','0',34,19,39);
  insert into song values (34,'Dusk Till Dawn','album/58.jpg','songLyrics/Dusk Till Dawn.lrc','song/Dusk Till Dawn.mp3','04:26','2017-3-18','0',34,14,58);
  insert into song values (35,'Walk Thru Fire','album/31.jpg','songLyrics/Walk Thru Fire.lrc','song/Walk Thru Fire.mp3','03:14','2015-3-18','0',35,16,31);
  -- insert into song values (46,'Walk Thru Fire','album/31.jpg','songLyrics/Walk Thru Fire.lrc','song/Walk Thru Fire.mp3','03:14','2015-3-18','0',35,24,31);
  insert into song values (36,'Nevada','album/32.jpg','songLyrics/Nevada.lrc','song/Nevada.mp3','03:28','2015-3-18','0',39,16,32);
  -- insert into song values (48,'Nevada','album/32.jpg','songLyrics/Nevada.lrc','song/Nevada.mp3','03:28','2015-3-18','0',39,35,32);
  insert into song values (37,'Lemon','album/33.jpg','songLyrics/Lemon.lrc','song/Lemon.mp3','04:16','2019-5-18','0',37,8,33);
  insert into song values (38,'打上花火','album/34.jpg','songLyrics/打上花火.lrc','song/打上花火.mp3','04:49','2016-4-25','0',38,8,34);
  -- insert into song values (51,'打上花火','album/34.jpg','songLyrics/打上花火.lrc','song/打上花火.mp3','04:49','2016-4-25','0',38,33,34);
  insert into song values (39,'クランベリーとパンケーキ (蔓越莓和煎饼)','album/33.jpg','songLyrics/クランベリーとパンケーキ (蔓越莓和煎饼).lrc','song/クランベリーとパンケーキ (蔓越莓和煎饼).mp3','03:30','2017-3-18','0',39,8,33);
  insert into song values (40,'Take Me Hand','album/35.jpg','songLyrics/Take Me Hand.lrc','song/Take Me Hand.mp3','04:20','2015-3-18','0',40,34,35);
  -- insert into song values (54,'Take Me Hand','album/35.jpg','songLyrics/Take Me Hand.lrc','song/Take Me Hand.mp3','04:20','2015-3-18','0',40,36,35);
  insert into song values (41,'千と千尋の神隠し_いつも何度でも','album/36.jpg','songLyrics/千と千尋の神隠し_いつも何度でも.lrc','song/千と千尋の神隠し_いつも何度でも.mp3','05:10','2015-3-18','0',41,34,36);
  insert into song values (42,'恋愛サーキュレーション (恋爱循环)','album/38.jpg','songLyrics/恋愛サーキュレーション (恋爱循环).lrc','song/恋愛サーキュレーション (恋爱循环).mp3','04:13','2019-5-18','0',42,11,38);
  insert into song values (43,'sweets parade','album/37.jpg','songLyrics/sweets parade.lrc','song/sweets parade.mp3','03:59','2016-4-25','0',43,11,37);
  insert into song values (44,'My All (Live)','album/40.jpg','songLyrics/My All (Live).lrc','song/My All (Live).mp3','06:56','2017-3-18','0',44,13,40);
  insert into song values (45,'オヒアの木 (奥希亚之树)','album/39.jpg','songLyrics/オヒアの木 (奥希亚之树).lrc','song/オヒアの木 (奥希亚之树).mp3','04:36','2015-3-18','0',45,13,39);
  insert into song values (46,'世界が終るまでは… (直到世界尽头)','album/41.jpg','songLyrics/世界が終るまでは… (直到世界尽头).lrc','song/世界が終るまでは… (直到世界尽头).mp3','05:15','2015-3-18','0',46,15,41);
  insert into song values (47,'雨に濡れて (淋湿在雨中)','album/42.jpg','songLyrics/雨に濡れて (淋湿在雨中).lrc','song/雨に濡れて (淋湿在雨中).mp3','04:47','2019-5-18','0',47,15,42);
  insert into song values (48,'Sour Candy','album/43.jpg','songLyrics/Sour Candy.lrc','song/Sour Candy.mp3','02:37','2016-4-25','0',48,26,43);
  -- insert into song values (63,'Sour Candy','album/43.jpg','songLyrics/Sour Candy.lrc','song/Sour Candy.mp3','02:37','2016-4-25','0',48,38,43);
  insert into song values (49,'Share The World','album/44.jpg','songLyrics/Share The World.lrc','song/Share The World.mp3','03:26','2017-3-18','0',49,12,44);
  insert into song values (50,'どうして君を好きになってしまったんだろう_ (为何我会喜欢上你？)','album/45.jpg','songLyrics/どうして君を好きになってしまったんだろう_ (为何我会喜欢上你？).lrc','song/どうして君を好きになってしまったんだろう_ (为何我会喜欢上你？).mp3','03:18','2015-3-18','0',50,12,45);
  insert into song values (51,'Tomorrow With You','album/46.jpg','songLyrics/Tomorrow With You.lrc','song/Tomorrow With You.mp3','03:20','2015-3-18','0',51,27,46);
  -- insert into song values (67,'Tomorrow With You','album/46.jpg','songLyrics/Tomorrow With You.lrc','song/Tomorrow With You.mp3','03:20','2015-3-18','0',55,20,46);
  insert into song values (52,'Meaningful Ways','album/47.jpg','songLyrics/Meaningful Ways.lrc','song/Meaningful Ways.mp3','03:07','2019-5-18','0',52,27,47);
  -- insert into song values (69,'Best Moments','album/48.jpg','songLyrics/Best Moments.lrc','song/Best Moments.mp3','03:29','2016-4-25','0',53,27,48);
  insert into song values (53,'Best Moments','album/48.jpg','songLyrics/Best Moments.lrc','song/Best Moments.mp3','03:29','2016-4-25','0',53,37,48);
  insert into song values (54,'Pieng ter - เพียงเธอ','album/50.jpg','songLyrics/Pieng ter - เพียงเธอ.lrc','song/Pieng ter - เพียงเธอ.mp3','04:11','2017-3-18','0',54,23,50);
  insert into song values (55,'错过','album/49.jpg','songLyrics/错过.lrc','song/错过.mp3','04:34','2015-3-18','0',55,23,49);
  insert into song values (56,'เจอกับตัวเอง___ถึงรู้','album/51.jpg','songLyrics/เจอกับตัวเอง___ถึงรู้.lrc','song/เจอกับตัวเอง___ถึงรู้.mp3','04:00','2015-3-18','0',56,41,51);
  insert into song values (57,'叛','album/52.jpg','songLyrics/叛.lrc','song/叛.mp3','03:36','2019-5-18','0',57,41,52);
  -- insert into song values (75,'叛','album/52.jpg','songLyrics/叛.lrc','song/叛.mp3','03:36','2019-5-18','0',57,6,52);
  insert into song values (58,'Strong Enough','album/53.jpg','songLyrics/Strong Enough.lrc','song/Strong Enough.mp3','03:47','2016-4-25','0',58,18,53);
  insert into song values (59,'Fake Nice','album/54.jpg','songLyrics/Fake Nice.lrc','song/Fake Nice.mp3','03:23','2017-3-18','0',59,18,54);
  insert into song values (60,'Stuck','album/53.jpg','songLyrics/Stuck.lrc','song/Stuck.mp3','04:05','2015-3-18','0',60,18,53);
  insert into song values (61,'无人之岛','album/56.jpg','songLyrics/无人之岛.lrc','song/无人之岛.mp3','04:45','2016-4-25','0',61,5,56);
  insert into song values (62,'后继者','album/57.jpg','songLyrics/后继者.lrc','song/后继者.mp3','04:02','2017-3-18','0',62,5,57);
  insert into song values (63,'走不出的回忆','album/55.jpg','songLyrics/走不出的回忆.lrc','song/走不出的回忆.mp3','03:45','2015-3-18','0',63,5,55);
  insert into song values (64,'飞鸟','album/56.jpg','songLyrics/飞鸟.lrc','song/飞鸟.mp3','04:55','2015-3-18','0',64,5,56);
  insert into song values (65,'The Spectre','album/27.jpg','songLyrics/The Spectre.lrc','song/The Spectre.mp3','03:13','2015-3-18','0',65,39,27);

}

