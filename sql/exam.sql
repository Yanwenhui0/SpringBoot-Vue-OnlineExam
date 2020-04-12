/*
Navicat MySQL Data Transfer

Source Server         : YWH_Connection
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : exam

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2020-04-12 23:34:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `adminId` int(9) NOT NULL AUTO_INCREMENT COMMENT 'ID号',
  `adminName` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '姓名',
  `sex` varchar(2) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
  `tel` varchar(11) COLLATE utf8_bin DEFAULT NULL COMMENT '电话号码',
  `email` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '电子邮箱',
  `pwd` varchar(16) COLLATE utf8_bin DEFAULT NULL COMMENT '密码',
  `cardId` varchar(18) COLLATE utf8_bin DEFAULT NULL COMMENT '身份证号',
  `role` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '角色(0管理员，1教师，2学生)',
  PRIMARY KEY (`adminId`) USING BTREE,
  KEY `sex` (`sex`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9528 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='管理员信息表';

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('9527', '超级管理员', '男', '18262552709', '1697479326@qq.com', 'ywh169747', '3132', '0');

-- ----------------------------
-- Table structure for `exam_manage`
-- ----------------------------
DROP TABLE IF EXISTS `exam_manage`;
CREATE TABLE `exam_manage` (
  `examCode` int(9) NOT NULL AUTO_INCREMENT COMMENT '考试编号',
  `description` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '该次考试介绍',
  `source` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '课程名称',
  `paperId` int(10) DEFAULT NULL COMMENT '试卷编号',
  `examDate` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '考试日期',
  `totalTime` int(3) DEFAULT NULL COMMENT '持续时长',
  `grade` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '年级',
  `term` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '学期',
  `major` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '专业',
  `institute` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '学院',
  `totalScore` int(4) DEFAULT NULL COMMENT '总分',
  `type` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '考试类型',
  `tips` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '考生须知',
  PRIMARY KEY (`examCode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20190016 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='考试管理表';

-- ----------------------------
-- Records of exam_manage
-- ----------------------------
INSERT INTO `exam_manage` VALUES ('20190001', '2019年上期期末考试', '计算机网络', '1001', '2019-03-21', '120', '2018', '1', '计算机科学与技术', '软件工程学院', '100', '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `exam_manage` VALUES ('20190002', '2019年上期期末考试', '数据库理论', '1002', '2019-03-07', '90', '2018', '2', '网络工程', '软件工程学院', '100', '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `exam_manage` VALUES ('20190003', '2018年下期期末考试', '数据结构', '1003', '2019-02-27', '90', '2017', '1', '软件工程', '软件工程学院', '100', '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `exam_manage` VALUES ('20190005', '2018年上期期末考试', '计算机导论', '1004', '2019-03-14', '90', '2018', '1', '计算机科学与技术', '软件工程学院', '100', '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `exam_manage` VALUES ('20190006', '2017年上期期末考试', '软件工程', '1005', '2019-03-21', '120', '2018', '1', '计算机科学与技术', '软件工程学院', '100', '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `exam_manage` VALUES ('20190007', '2018年上期期末考试', '操作系统', '1006', '2019-03-13', '120', '2018', '2', '计算机科学与技术', '软件工程学院', '100', '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `exam_manage` VALUES ('20190008', '2018年下期期末考试', 'C语言', '1007', '2019-03-13', '120', '2018', '1', '信息工程', '软件工程学院', '100', '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `exam_manage` VALUES ('20190009', '2018年上期期末考试', '高等数学', '1008', '2019-03-07', '90', '2018', '1', '信息工程', '软件工程学院', '100', '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `exam_manage` VALUES ('20190013', '测试', '测试', '1009', '2019-04-24', '120', '2017', null, '测试', '测试', '100', '期末考试', '请不要带与考试无关的书籍。');
INSERT INTO `exam_manage` VALUES ('20190014', 'test', 'test001', '1010', '2019-11-30', '120', '大四', null, '软件工程', '计算机与信息工程学院', '100', '考试', '不要带笔');
INSERT INTO `exam_manage` VALUES ('20190015', 'tttt', '网络层', '1011', '2019-12-10', '120', '大三', null, '软件工程', '计算机与信息工程学院', '100', '考试', '不用代笔');

-- ----------------------------
-- Table structure for `exercise`
-- ----------------------------
DROP TABLE IF EXISTS `exercise`;
CREATE TABLE `exercise` (
  `exerciseId` int(9) NOT NULL AUTO_INCREMENT,
  `studentId` int(9) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `score` int(5) DEFAULT '0',
  `total` int(5) DEFAULT '0',
  `multi` varchar(255) DEFAULT NULL,
  `fill` varchar(255) DEFAULT NULL,
  `judge` varchar(255) DEFAULT NULL,
  `created` date DEFAULT NULL,
  PRIMARY KEY (`exerciseId`),
  KEY `sid` (`studentId`),
  CONSTRAINT `sid` FOREIGN KEY (`studentId`) REFERENCES `student` (`studentId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of exercise
-- ----------------------------
INSERT INTO `exercise` VALUES ('1', '20154084', '我的test', '计算机网络', 'tttest', '0', '18', '10030,10027,10026', '10011,10010,10007', '10013,10003,10012', '2019-12-10');
INSERT INTO `exercise` VALUES ('2', '20154084', 'good', '计算机网络', 'hao', '0', '30', '10005,10004,10021,10023,10024', '10001,10011,10000,10003,10005', '10011,10008,10009,10002,10010', '2019-12-11');
INSERT INTO `exercise` VALUES ('3', '20154084', '又是一个练习', '计算机网络', '这次还是计算机网络，这次多加点题目，多练练，多练才能挂科，逢考避过，网络必挂，必挂万岁，万岁万岁万万岁！！！', '0', '52', '10030,10028,10020,10021,10003,10024,10026,10001,10029,10007', '10000,10001,10014,10004,10005,10010,10012,10009', '10003,10008,10004,10007,10013,10002,10001,10010', '2019-12-10');
INSERT INTO `exercise` VALUES ('4', '20154084', '在来一个短的', '计算机网络', '好短', '0', '6', '10024', '10008', '10003', '2019-12-10');

-- ----------------------------
-- Table structure for `fill_question`
-- ----------------------------
DROP TABLE IF EXISTS `fill_question`;
CREATE TABLE `fill_question` (
  `questionId` int(9) NOT NULL AUTO_INCREMENT COMMENT '试题编号',
  `question` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '试题内容',
  `answer` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '正确答案',
  `analysis` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '题目解析',
  `score` int(2) DEFAULT '2' COMMENT '分数',
  `level` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '难度等级',
  `subject` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '所属章节',
  `collect` int(1) DEFAULT '0',
  `ok` int(9) DEFAULT '0',
  `total` int(9) DEFAULT '0',
  PRIMARY KEY (`questionId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10029 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='填空题题库';

-- ----------------------------
-- Records of fill_question
-- ----------------------------
INSERT INTO `fill_question` VALUES ('10000', '从计算机网络系统组成的角度看，计算机网络可以分为()和()', '通信子网资源子网', null, '4', '3', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10001', '收发电子邮件，属于ISO/OSI RM中 ()层的功能。', '应用', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10002', '在TCP/IP层次模型中与OSI参考模型第四层相对应的主要协议有()和(),其中后者提供无连接的不可靠传输服', 'TCP（传输控制协议） UDP（用户数据报协议） ', null, '4', '2', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10003', '计算机网络中常用的三种有线媒体是 (),()和 ()', '同轴电缆.双绞线 光纤', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10004', '国内最早的四大网络包括原邮电部的ChinaNet. 原电子部的ChinaGBN. 教育部的()和中科院的CSTnet', 'CERnet (或中国教育科研网)', null, '4', '4', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10005', '复盖一个国家，地区或几个洲的计算机网络称为()，在同一建筑或复盖几公里内范围的网络称为()，而介于两者之间的是()', ' 广域网       局域网     城域网', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10006', 'Outlook等常用电子邮件软件接收邮件使用的协议是(),发送邮件时使用的协议是()', 'POP3    SMTP    ', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10007', '通信系统中，称调制前的电信号为()信号，调制后的信号为调制信号', '基带', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10008', '按照IPV4标准,IP地址205.3.127.13属于()类地址', 'C', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10009', '计算机网络采用()技术，而传统电话网络则采用()技术', '分组交换电路交换', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10010', '计算机内传输的信号是()，而公用电话系统的传输系统只能传输()', '数字信号模拟信号', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10011', '通信系统中，称调制前的电信号为()，调制后的信号叫()。', '基带信号调制信号', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10012', 'IP地址分()和()两个部分', '网络号主机号', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10013', ' IP地址协议作网间网中()层协议，提供无连接的数据报传输机制，IP数据报也分为()和()两个部分', '网络报头数据区', null, '4', '2', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10014', '()是一个简单的远程终端协议。', 'TELNET', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10015', '在同一个系统内，相邻层之间交换信息的连接点称之为()，而低层模块向高层提供功能性的支持称之为()。', '接口服务', null, '4', '1', '操作系统', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10016', 'Internet广泛使用的电子邮件传送协议是()', 'SMTP', null, '4', '1', '操作系统', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10017', '按交换方式来分类，计算机网络可以分为电路交换网，  报文交换网  和()三种', '分组交换网', null, '4', '3', '操作系统', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10018', 'Intranet分层结构包括网络、(),应用三个层次。', '服务', null, '4', '1', '操作系统', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10019', 'WWW上的每一个网页都有一个独立的地址，这些地址称为  ()', '统一资源定位器/URL ', null, '4', '2', '操作系统', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10020', '分组交换网中，附加信息用来在网络中进行路由选择、() 和流量控制', '差错纠正  ', null, '4', '4', '操作系统', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10021', '根据IEEE802模型的标准将数据链路层划分为LLC子层和 ()子层。', ' MAC ', null, '4', '3', '操作系统', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10022', '据交换的路由信息的不同，路由算法可以分为两大类：  ()  和链路状态算法', '距离向量算法', null, '4', '3', '操作系统', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10023', '假定某信道受奈氏准则限制的最高码元速率为2000码元/秒。如果采用振幅调制，把码元的振幅划分为16个不同等级来传送，那么可以获得的数据率为 () b/s。', '80000 ', null, '4', '5', '操作系统', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10024', '交换型以太网系统中的 ()  ，以其为核心联接站点或者网段，端口之间帧的输入和输出已不再受到CSMA/CD媒体访问控制协议的约束。', '以太网交换器 ', null, '4', '5', '操作系统', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10025', '局域网络参考模型是以 ()标准为基础的', 'IEEE802', null, '4', '5', '操作系统', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10026', '路由器的核心是 () 。', ' 路由表', null, '4', '3', '操作系统', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10027', '若 HDLC 帧数据段中出现比特串“ 01011111110 ”，则比特填充后的输出为()', '10111110110', null, '4', '5', '操作系统', '0', '0', '0');
INSERT INTO `fill_question` VALUES ('10028', '数字调制的三种基本形式：移幅键控法ASK、 ()、移相键控法PSK', '移频键控法FSK', null, '4', '5', '操作系统', '0', '0', '0');

-- ----------------------------
-- Table structure for `judge_question`
-- ----------------------------
DROP TABLE IF EXISTS `judge_question`;
CREATE TABLE `judge_question` (
  `questionId` int(9) NOT NULL AUTO_INCREMENT COMMENT '试题编号',
  `question` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '试题内容',
  `answer` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '正确答案',
  `analysis` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '题目解析',
  `score` int(2) DEFAULT '2' COMMENT '分数',
  `level` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '难度等级',
  `subject` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '所属章节',
  `collect` int(1) DEFAULT '0',
  `ok` int(9) DEFAULT '0',
  `total` int(9) DEFAULT '0',
  PRIMARY KEY (`questionId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10014 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='判断题题库表';

-- ----------------------------
-- Records of judge_question
-- ----------------------------
INSERT INTO `judge_question` VALUES ('10001', '与有线网相比,无线网的数据传输率一般相对较慢', 'T', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `judge_question` VALUES ('10002', 'OSI参考模型中,不同节点的同等层具有不同的功能', 'F', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `judge_question` VALUES ('10003', '普通电脑不能作为服务器', 'F', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `judge_question` VALUES ('10004', '没有网线的电脑不能连入互联网', 'F', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `judge_question` VALUES ('10005', '网卡必须安装驱动程序', 'T', null, '4', '2', '计算机网络', '0', '0', '0');
INSERT INTO `judge_question` VALUES ('10006', 'UTP为屏蔽双绞线', 'F', null, '4', '2', '计算机网络', '0', '0', '0');
INSERT INTO `judge_question` VALUES ('10007', '网络接口卡又称为网卡,它是构成网络的基本部件', 'T', null, '4', '2', '计算机网络', '0', '0', '0');
INSERT INTO `judge_question` VALUES ('10008', '无线AP可以成倍地扩展网络覆盖范围', 'T', null, '4', '3', '计算机网络', '0', '0', '0');
INSERT INTO `judge_question` VALUES ('10009', 'SMTP是一组用于由源地址到目的地址传送邮件的协议', 'T', null, '4', '4', '计算机网络', '0', '0', '0');
INSERT INTO `judge_question` VALUES ('10010', '任务管理器可以关闭所有的进程', 'F', null, '4', '3', '计算机网络', '0', '0', '0');
INSERT INTO `judge_question` VALUES ('10011', '利用BT下载时,用户越多,下载速度越快', 'T', null, '4', '2', '计算机网络', '0', '0', '0');
INSERT INTO `judge_question` VALUES ('10012', 'INTERNET上向朋友发送电子邮件,必须知道对方的真实姓名和家庭住址', 'F', null, '4', '1', '计算机网络', '0', '0', '0');
INSERT INTO `judge_question` VALUES ('10013', '1234', 'F', '', '4', '3', '计算机网络', '0', '0', '0');

-- ----------------------------
-- Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(9) NOT NULL AUTO_INCREMENT COMMENT '留言编号',
  `title` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '标题',
  `content` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '留言内容',
  `time` date DEFAULT NULL COMMENT '留言时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='留言表';

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('2', '晚上加班,这感觉非常的nice', '今天是星期一的晚上,下班后回到宿舍继续写我的毕业设计,看着项目功能日渐丰满好开心哦,你们也要元气满满哦！', '2019-03-18');
INSERT INTO `message` VALUES ('15', '咸鱼', '我是一条咸鱼', '2019-03-18');
INSERT INTO `message` VALUES ('16', '今天中午吃什么', '今天去吃莲藕排骨汤吧，虽然也不好吃，但这里真的没什么东西可以吃了', '2019-03-18');
INSERT INTO `message` VALUES ('20', '这个网站不错', '博主大大好厉害，网页看着很清新呢，喜欢这样嘞风格。', '2019-03-18');
INSERT INTO `message` VALUES ('21', '男孩子', '哇，这么可爱，那肯定是男孩子呀。', '2019-03-18');
INSERT INTO `message` VALUES ('22', '好人', '你是个好人，可是我们不合适。', '2019-03-18');
INSERT INTO `message` VALUES ('25', '小乔', '花会枯萎，爱永不凋零，小乔要努力变强。', '2019-03-18');
INSERT INTO `message` VALUES ('26', '妲己', '妲己会一直爱主人，因为被设定成这样，来和妲己玩耍吧。', '2019-03-18');
INSERT INTO `message` VALUES ('27', '土味情话', '妈妈从小对我讲，不要早恋，遇到你以后，我决定不听妈妈的话了。', '2019-03-31');
INSERT INTO `message` VALUES ('35', '贝塔', '开坦克', '2019-09-05');
INSERT INTO `message` VALUES ('36', 'qqqqqq', '1111111', '2019-11-26');
INSERT INTO `message` VALUES ('37', '哈哈哈', '不知道说些什么啊\n', '2020-01-10');

-- ----------------------------
-- Table structure for `multi_question`
-- ----------------------------
DROP TABLE IF EXISTS `multi_question`;
CREATE TABLE `multi_question` (
  `questionId` int(9) NOT NULL AUTO_INCREMENT COMMENT '试题编号',
  `question` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '问题题目',
  `answerA` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '选项A',
  `answerB` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '选项B',
  `answerC` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '选项C',
  `answerD` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '选项D',
  `rightAnswer` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '正确答案',
  `analysis` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '题目解析',
  `score` int(2) DEFAULT '2' COMMENT '分数',
  `subject` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '所属章节',
  `level` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '难度等级',
  `collect` int(1) DEFAULT '0',
  `ok` int(9) DEFAULT '0',
  `total` int(9) DEFAULT '0',
  PRIMARY KEY (`questionId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10033 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='选择题题库表';

-- ----------------------------
-- Records of multi_question
-- ----------------------------
INSERT INTO `multi_question` VALUES ('10000', 'DNS 服务器和DHCP服务器的作用是（）', '将IP地址翻译为计算机名，为客户机分配IP地址', '将IP地址翻译为计算机名、解析计算机的MAC地址', '将计算机名翻译为IP地址、为客户机分配IP地址', '将计算机名翻译为IP地址、解析计算机的MAC地址', 'C', null, '4', '计算机网络', '2', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10001', 'HTTP协议通常使用什么协议进行传输（）', 'ARP', 'DHCP', 'UDP', 'TCP', 'D', null, '4', '计算机网络', '2', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10003', '查看DNS缓存记录的命令（）', 'ipconfig/displaydns', 'nslookup', 'ipconfig/release', 'ipconfig/flushdns', 'A', null, '4', '计算机网络', '3', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10004', 'DHCP(        )报文的目的IP地址为255.255.255.255', 'DhcpDisover', 'DhcpOffer', 'DhcpAck', 'DhcpNack', 'A', null, '4', '计算机网络', '2', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10005', '下列地址中，（  ）不是DHCP服务器分配的IP地址', '196.254.109.100', '169.254.12.42', '69.254.48.45', '96.254.54.15', 'B', null, '4', '计算机网络', '2', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10006', 'DHCP通常可以为客户端自动配置哪些网络参数（）', 'IP，掩码，网关，DNS', 'IP，掩码，域名，SMTP', '网关，掩码，浏览器，FTP', 'IP，网关，DNS，服务器', 'A', null, '4', '计算机网络', '2', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10007', 'DNS服务器在名称解析过程中正确的查询顺序为（）', '本地缓存记录→区域记录→转发域名服务器→根域名服务器', '区域记录→本地缓存记录→转发域名服务器→根域名服务器', '本地缓存记录→区域记录→根域名服务器→转发域名服务器', '区域记录→本地缓存记录→根域名服务器→转发域名服务器', 'A', null, '4', '计算机网络', '3', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10008', '在TCP/IP协议中，序号小于（  ）的端口称为熟知端口(well-known port)。', '1024', '64', '256', '128', 'A', null, '4', '操作系统', '1', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10009', '在Internet上用TCP/IP播放视频，想用传输层的最快协议，以减少时延，要使用（ ）', 'UDP协议的低开销特性', 'UDP协议的高开销特性', 'TCP协议的低开销特性', 'TCP协议的高开销特性', 'A', null, '4', '操作系统', '2', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10010', '在TCP协议中采用（ ）来区分不同的应用进程', '端口号', 'IP地址', '协议类型', 'MAC地址', 'A', null, '4', '操作系统', '3', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10011', '可靠的传输协议中的“可靠”指的是（ ）', '使用面向连接的会话', '使用“尽力而为”的传输', '使用滑动窗口来维持可靠性', '使用确认重传机制来确保传输的数据不丢失', 'D', null, '4', '操作系统', '2', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10012', '假设拥塞窗口为50KB，接收窗口为80KB，TCP能够发送的最大字节数为（ ）', '50KB', '80KB', '130KB', '30KB', 'A', null, '4', '操作系统', '4', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10013', '主机A向主机B发送一个（SYN=1，seq=2000）的TCP报文，期望与主机B建立连接，若主机B接受连接请求，则主机B发送的正确有TCP报文可能是（ ）', '（SYN=0,ACK=0,seq=2001,ack=2001）', '（SYN=1,ACK=1,seq=2000,ack=2000）', '•	C.（SYN=1,ACK=1,seq=2001,ack=2001）', '（SYN=0,ACK=1,seq=2000,ack=2000）', 'C', null, '4', '操作系统', '2', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10014', '主机A向主机B连续发送了两个TCP报文段，其序号分别为70和100。试问： （1）第一个报文段携带了（）个字节的数据？', ' 70', '30', '100', '170', 'B', null, '4', '操作系统', '3', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10015', 'PCM脉码调制的过程（ ）', '采样、量化、编码', '量化、编码、采样', '编码、量化、采样', '采样、编码、量化', 'A', null, '4', '计算机硬件基础', '4', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10016', '若某采用4相位调制的通信链路的数据传输速率为2400bps，则该链路的波特率为（）', '600Baud', '1200Baud', '4800Baud', '9600Baud', 'B', null, '4', '计算机硬件基础', '1', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10017', '以下关于数据传输速率的描述中，错误的是( )', '数据传输速率表示每秒钟传输构成数据代码的二进制比特数', '对于二进制数据，数据传输速率为S=1/T (bps)', '常用的数据传输速率单位有: 1Mbps=1.024×106bps', '数据传输速率是描述数据传输系统性能的重要技术指标之一', 'C', null, '4', '计算机硬件基础', '2', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10018', '以下关于时分多路复用概念的描述中，错误的是.(  ).', '时分多路复用将线路使用的时间分成多个时间片', '时分多路复用分为同步时分多路复用与统计时分多路复用', '时分多路复用使用“帧”与数据链路层“帧”的概念、作用是不同的', '统计时分多路复用将时间片预先分配给各个信道', 'D', null, '4', '计算机硬件基础', '2', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10019', '1000BASE-T标准支持的传输介质是（）', '双绞线', '同轴电缆', '光纤', '无线电', 'A', null, '4', '计算机硬件基础', '1', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10020', '一个以太网交换机，读取整个数据帧，对数据帧进行差错校验后再转发出去，这种交换方式称为 （）', '直通交换', '无碎片交换', '无差错交换', '存储转发交换', 'D', null, '4', '计算机网络', '2', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10021', '关于VLAN，下面的描述中正确的是（）', '一个新的交换机没有配置VLAN', '通过配置VLAN减少了冲突域的数量', '一个VLAN不能跨越多个交换机', '各个VLAN属于不同的广播域', 'D', null, '4', '计算机网络', '2', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10022', '以太网协议中使用物理地址作用是什么？', '.用于不同子网中的主机进行通信', '作为第二层设备的唯一标识', '用于区别第二层第三层的协议数据单元', '保存主机可检测未知的远程设备', 'B', null, '4', '计算机网络', '2', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10023', '以太网采用的CSMA/CD协议，当冲突发生时要通过二进制指数后退算法计算后退延时， 关于这个算法，以下论述中错误的是 （）', '冲突次数越多，后退的时间越短', '平均后退次数的多少与负载大小有关', '后退时延的平均值与负载大小有关', '重发次数达到一定极限后放弃发送', 'A', null, '4', '计算机网络', '3', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10024', '以下关于交换机获取与其端口连接设备的MAC地址的叙述中，正确的是（）', '交换机从路由表中提取设备的MAC地址', '交换机检查端口流入分组的源地址', '交换机之间互相交换地址表', '网络管理员手工输入设备的MAC地址', 'B', null, '4', '计算机网络', '2', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10025', '如果G (x）为11010010，以下4个CRC校验比特序列中只有哪个可能是正确的 ？', '1101011001', '101011011', '11011011', '1011001', 'B', null, '4', '计算机网络', '1', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10026', '以下关于Ethernet物理地址的描述中，错误的是', 'Ethernet物理地址又叫做MAC地址', '48位的Ethernet物理地址允许分配的地址数达到247个', '网卡的物理地址写入主机的EPROM中', '每一块网卡的物理地址在全世界是唯一的', 'C', null, '4', '计算机网络', '3', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10027', '下列帧类型中，不属于HDLC帧类型的是（）', '信息帧', '确认帧', '监控帧', '无编号帧', 'B', null, '4', '计算机网络', '1', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10028', '通过交换机连接的一组站点，关于它们的广播域和冲突域说法正确的是（）', '组成一个冲突域，但不是一个广播域', '组成一个广播域，但不是一个冲突域', '组成一个冲突域，也是一个广播域', '既不一个冲突域，也不是一个广播域', 'B', null, '4', '计算机网络', '3', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10029', '数据链路层的数据单位是（）', '帧', '字节', '比特', '分组', 'A', null, '4', '计算机网络', '1', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10030', 'LAN参考模型可分为物理层、（ ）', 'MAC，LLC等三层', 'LLC，MHS等三层', 'MAC，FTAM等三层', 'LLC，VT等三层', 'A', null, '4', '计算机网络', '3', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10031', '测试', 'A', 'B', 'C', 'D', 'B', '解析', '4', '操作系统', '4', '0', '0', '0');
INSERT INTO `multi_question` VALUES ('10032', 'DNS 服务器和DHCP服务器的作用是（）', 'A', 'B', 'C', 'D', 'B', '哦解析', '4', '操作系统', '2', '0', '0', '0');

-- ----------------------------
-- Table structure for `package`
-- ----------------------------
DROP TABLE IF EXISTS `package`;
CREATE TABLE `package` (
  `packageId` varchar(50) NOT NULL,
  `studentId` varchar(20) NOT NULL,
  `questionType` varchar(10) NOT NULL,
  `questionId` varchar(10) NOT NULL,
  PRIMARY KEY (`packageId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of package
-- ----------------------------
INSERT INTO `package` VALUES ('061de5e0b51e0b33c6a4494a33f06ef4', '20154084', '填空题', '10014');
INSERT INTO `package` VALUES ('10cb5e083a5757b38dde1d4b2e2d53eb', '20154084', '填空题', '10009');
INSERT INTO `package` VALUES ('2a659b33f111b7a8e4a2b8f8348c3b16', '20154084', '选择题', '10028');
INSERT INTO `package` VALUES ('677dba18755a84c3fe0898b68a3a2323', '20154084', '选择题', '10001');
INSERT INTO `package` VALUES ('6955e5c8bfbaec520d7ab4109364238f', '20154084', '选择题', '10024');
INSERT INTO `package` VALUES ('6e0a4151d7c8aa04d5d33dcb175357ed', '20154084', '判断题', '10010');
INSERT INTO `package` VALUES ('90d651a72c3bedc5e67a70876a20620d', '20154084', '判断题', '10003');
INSERT INTO `package` VALUES ('b46f9007383f2235366fdcd2c3eca7a8', '20154084', '填空题', '10005');
INSERT INTO `package` VALUES ('bf3b9f9f1fdcceb0a754f947d15ec5f1', '20154084', '判断题', '10008');
INSERT INTO `package` VALUES ('c5e06fc8e6100fa42783fd58df9c7cc7', '20154084', '选择题', '10020');
INSERT INTO `package` VALUES ('caaec351e433bea26cd4de5f0c9e040a', '20154084', '填空题', '10001');
INSERT INTO `package` VALUES ('cdc6b79e1b682f0ece1b1edc214055f3', '20154084', '选择题', '10026');
INSERT INTO `package` VALUES ('d7d4f85f5ea6805e6532dcaa5c218fb0', '20154084', '判断题', '10012');
INSERT INTO `package` VALUES ('e5c3bece313cc517e297b5d7e7b69018', '20154084', '判断题', '10002');

-- ----------------------------
-- Table structure for `paper_manage`
-- ----------------------------
DROP TABLE IF EXISTS `paper_manage`;
CREATE TABLE `paper_manage` (
  `paperId` int(9) DEFAULT NULL COMMENT '试卷编号',
  `questionType` int(1) DEFAULT NULL COMMENT '题目类型',
  `questionId` int(9) DEFAULT NULL COMMENT '题目编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='试卷管理表';

-- ----------------------------
-- Records of paper_manage
-- ----------------------------
INSERT INTO `paper_manage` VALUES ('1001', '1', '10001');
INSERT INTO `paper_manage` VALUES ('1001', '1', '10003');
INSERT INTO `paper_manage` VALUES ('1001', '1', '10004');
INSERT INTO `paper_manage` VALUES ('1001', '1', '10000');
INSERT INTO `paper_manage` VALUES ('1001', '1', '10005');
INSERT INTO `paper_manage` VALUES ('1001', '1', '10006');
INSERT INTO `paper_manage` VALUES ('1001', '2', '10000');
INSERT INTO `paper_manage` VALUES ('1001', '2', '10001');
INSERT INTO `paper_manage` VALUES ('1001', '2', '10002');
INSERT INTO `paper_manage` VALUES ('1001', '2', '10003');
INSERT INTO `paper_manage` VALUES ('1001', '2', '10004');
INSERT INTO `paper_manage` VALUES ('1001', '2', '10005');
INSERT INTO `paper_manage` VALUES ('1001', '3', '10001');
INSERT INTO `paper_manage` VALUES ('1001', '3', '10002');
INSERT INTO `paper_manage` VALUES ('1001', '3', '10003');
INSERT INTO `paper_manage` VALUES ('1001', '3', '10004');
INSERT INTO `paper_manage` VALUES ('1001', '3', '10005');
INSERT INTO `paper_manage` VALUES ('1001', '3', '10006');

-- ----------------------------
-- Table structure for `replay`
-- ----------------------------
DROP TABLE IF EXISTS `replay`;
CREATE TABLE `replay` (
  `messageId` int(255) DEFAULT NULL COMMENT '留言编号',
  `replayId` int(9) NOT NULL AUTO_INCREMENT COMMENT '回复编号',
  `replay` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '内容',
  `replayTime` date DEFAULT NULL COMMENT '回复时间',
  PRIMARY KEY (`replayId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='回复表';

-- ----------------------------
-- Records of replay
-- ----------------------------
INSERT INTO `replay` VALUES ('26', '3', '好呀，我来了，你别跑！', '2019-03-18');
INSERT INTO `replay` VALUES ('22', '4', '心疼你2秒钟', '2019-03-18');
INSERT INTO `replay` VALUES ('25', '5', '我也要变强', '2019-03-19');
INSERT INTO `replay` VALUES ('25', '6', '俺也一样', '2019-03-19');
INSERT INTO `replay` VALUES ('21', '7', '既然这样，那就迎男而上吧', '2019-03-19');
INSERT INTO `replay` VALUES ('16', '8', '那条街确实没什么东西可以吃了。。。', '2019-03-19');
INSERT INTO `replay` VALUES ('15', '9', '咸鱼其实还可以吃，而你,emmmm', '2019-03-19');
INSERT INTO `replay` VALUES ('21', '11', '我不怕人多', '2019-03-19');
INSERT INTO `replay` VALUES ('20', '12', '是嘞，还行。', '2019-03-19');
INSERT INTO `replay` VALUES ('26', '13', '我也爱你ε=(´ο｀*)))唉', '2019-03-19');
INSERT INTO `replay` VALUES ('27', '14', '你这个坏孩子', '2019-03-31');
INSERT INTO `replay` VALUES ('33', '18', '是的，今天是周一。', '2019-04-14');
INSERT INTO `replay` VALUES ('34', '19', '1111', '2019-04-16');
INSERT INTO `replay` VALUES ('34', '20', '2222', '2019-04-16');
INSERT INTO `replay` VALUES ('35', '21', '666', '2019-09-05');
INSERT INTO `replay` VALUES ('36', '22', 'asgas ', '2019-11-26');
INSERT INTO `replay` VALUES ('36', '23', 'sagas ', '2019-11-26');

-- ----------------------------
-- Table structure for `score`
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score` (
  `scoreId` int(9) NOT NULL AUTO_INCREMENT COMMENT '分数编号',
  `examCode` int(9) DEFAULT NULL COMMENT '考试编号',
  `studentId` int(9) DEFAULT NULL COMMENT '学号',
  `subject` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '课程名称',
  `ptScore` int(5) DEFAULT NULL COMMENT '平时成绩',
  `etScore` int(5) DEFAULT NULL COMMENT '期末成绩',
  `score` int(5) DEFAULT NULL COMMENT '总成绩',
  `answerDate` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '答题日期',
  PRIMARY KEY (`scoreId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='成绩管理表';

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES ('4', '20190001', '20154084', '计算机网络', null, '70', null, '2019-04-03');
INSERT INTO `score` VALUES ('14', '20190002', '20154084', '数据库理论', null, '78', null, '2019-04-20');
INSERT INTO `score` VALUES ('15', '20190002', '20154084', '数据库理论', null, '80', null, '2019-04-20');
INSERT INTO `score` VALUES ('16', '20190002', '20154084', '数据库理论', null, '83', null, '2019-04-20');
INSERT INTO `score` VALUES ('17', '20190001', '20154001', '计算机网络', null, '74', null, '2019-04-13');
INSERT INTO `score` VALUES ('18', '20190001', '20154001', '计算机网络', null, '70', null, '2019-04-10');
INSERT INTO `score` VALUES ('19', '20190001', '20155003', '计算机网络', null, '86', null, '2019-04-14');
INSERT INTO `score` VALUES ('20', '20190001', '20155007', '计算机网络', null, '90', null, '2019-04-11');
INSERT INTO `score` VALUES ('21', '20190001', '20155007', '计算机网络', null, '92', null, '2019-04-12');
INSERT INTO `score` VALUES ('22', '20190001', '20155008', '计算机网络', null, '80', null, '2019-04-12');
INSERT INTO `score` VALUES ('23', '20190001', '20155003', '计算机网络', null, '90', null, '2019-04-13');
INSERT INTO `score` VALUES ('24', '20190001', '20155008', '计算机网络', null, '88', null, '2019-04-14');
INSERT INTO `score` VALUES ('27', '20190001', '20154084', '计算机网络', null, '80', null, '2019-04-25');
INSERT INTO `score` VALUES ('30', '20190001', '20154084', '计算机网络', null, '0', null, '2019-04-29');
INSERT INTO `score` VALUES ('31', '20190001', '20154084', '计算机网络', null, '0', null, '2019-09-06');
INSERT INTO `score` VALUES ('32', '20190014', '20154084', 'test001', null, '0', null, '2019-11-27');
INSERT INTO `score` VALUES ('33', '20190001', '20154084', '计算机网络', null, '0', null, '2019-12-09');
INSERT INTO `score` VALUES ('34', '20190001', '20154084', '计算机网络', null, '4', null, '2019-12-09');
INSERT INTO `score` VALUES ('35', '20190001', '20154084', '计算机网络', null, '0', null, '2019-12-09');
INSERT INTO `score` VALUES ('36', null, '20154084', '又是一个练习', null, '2', null, '2019-12-18');
INSERT INTO `score` VALUES ('37', '20190001', '20154084', '计算机网络', null, '0', null, '2020-01-11');
INSERT INTO `score` VALUES ('38', '20190001', '20154084', '计算机网络', null, '0', null, '2020-01-11');
INSERT INTO `score` VALUES ('39', '20190001', '20154084', '计算机网络', null, '0', null, '2020-01-11');
INSERT INTO `score` VALUES ('40', '20190001', '20154084', '计算机网络', null, '8', null, '2020-01-11');
INSERT INTO `score` VALUES ('41', '20190001', '20154084', '计算机网络', null, '4', null, '2020-01-11');

-- ----------------------------
-- Table structure for `student`
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `studentId` int(9) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `studentName` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '姓名',
  `grade` varchar(4) COLLATE utf8_bin DEFAULT NULL COMMENT '年级',
  `major` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '专业',
  `clazz` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '班级',
  `institute` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '学院',
  `tel` varchar(11) COLLATE utf8_bin DEFAULT NULL COMMENT '电话号码',
  `email` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '电子邮件',
  `pwd` varchar(16) COLLATE utf8_bin DEFAULT NULL COMMENT '密码',
  `cardId` varchar(18) COLLATE utf8_bin DEFAULT NULL COMMENT '身份证号',
  `sex` varchar(2) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
  `role` varchar(1) COLLATE utf8_bin DEFAULT '2' COMMENT '角色(0管理员，1教师，2学生)',
  PRIMARY KEY (`studentId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20155013 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='学生信息表';

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('20154001', '隔壁老王', '2018', '计算机科学与技术', '2', '软件工程学院', '13585439532', 'gblw@163.com', '123456', '3412312', '男', '2');
INSERT INTO `student` VALUES ('20154084', '大咸鱼', '2018', '计算机科学与技术', '2', '软件工程学院', '13658377857', '13658377857@sina.cn', '123456', '124123124535', '男', '2');
INSERT INTO `student` VALUES ('20155003', '张大宝', '2015', '信息工程', '1', '软件工程学院', '15583829425', '15583829425@163.com', '123456', '3242342', '男', '2');
INSERT INTO `student` VALUES ('20155007', '翠花', '2015', '网络工程', '1', '软件工程学院', '18734538457', '18734538457@163.com', '123456', '2423423', '女', '2');
INSERT INTO `student` VALUES ('20155008', '小王', '2015', '信息工程', '2', '软件工程学院', '15523619564', '15523619564@163.com', '123456', '500234199704022353', '男', '2');
INSERT INTO `student` VALUES ('20155010', '小米', '大二', '国际金融贸易', '金融3班', '商学院', '161651', '2116516186', '165126', '4981651651', '男', '2');
INSERT INTO `student` VALUES ('20155011', 'aaaa', 'sd', 'sd', 'gj', '23', '124325', '15436', '57658', '35346', '男', '2');
INSERT INTO `student` VALUES ('20155012', '徐工', '电话打', '说大话', '收到', '萨基', '25646', '1616', '6516', '164616', '男', '2');

-- ----------------------------
-- Table structure for `teacher`
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `teacherId` int(9) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `teacherName` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '姓名',
  `institute` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '学院',
  `sex` varchar(2) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
  `tel` varchar(11) COLLATE utf8_bin DEFAULT NULL COMMENT '电话号码',
  `email` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `pwd` varchar(16) COLLATE utf8_bin DEFAULT NULL COMMENT '密码',
  `cardId` varchar(18) COLLATE utf8_bin DEFAULT NULL COMMENT '身份证号',
  `type` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '职称',
  `role` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '角色（0管理员，1教师，2学生）',
  PRIMARY KEY (`teacherId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20081003 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='教师信息表';

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('20081001', '张', '软件工程学院', '男', '13598458442', '13598458442@163.com', '123456', '423423283498', '讲师', '1');
INSERT INTO `teacher` VALUES ('20081002', '王大志', '软件工程学院', '男', '1231221312', '1231221312@163.com', '123456', '24241234', '讲师', '1');
