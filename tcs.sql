/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50536
Source Host           : localhost:3306
Source Database       : tcs

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2014-09-05 13:37:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_city`
-- ----------------------------
DROP TABLE IF EXISTS `t_city`;
CREATE TABLE `t_city` (
  `cid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '城市ID',
  `cname` varchar(255) NOT NULL COMMENT '城市名',
  `vid` int(11) NOT NULL COMMENT '城市所属省份',
  `ctime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_city
-- ----------------------------
INSERT INTO `t_city` VALUES ('1', '南京市', '1', '2014-08-13 21:19:18');
INSERT INTO `t_city` VALUES ('2', '镇江市', '1', '2014-08-13 21:19:49');
INSERT INTO `t_city` VALUES ('3', '合肥市', '2', '2014-08-13 21:20:04');
INSERT INTO `t_city` VALUES ('4', '常州市', '1', '2014-08-16 11:28:21');

-- ----------------------------
-- Table structure for `t_district`
-- ----------------------------
DROP TABLE IF EXISTS `t_district`;
CREATE TABLE `t_district` (
  `did` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '区县ID',
  `dname` varchar(255) NOT NULL COMMENT '区县名',
  `cid` int(11) NOT NULL COMMENT '区县所属城市',
  `dtime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`did`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_district
-- ----------------------------
INSERT INTO `t_district` VALUES ('1', '浦口区', '1', '2014-08-13 21:32:31');
INSERT INTO `t_district` VALUES ('2', '建邺区', '1', '2014-08-13 21:33:02');
INSERT INTO `t_district` VALUES ('3', '润州区', '2', '2014-08-13 21:33:47');
INSERT INTO `t_district` VALUES ('4', '京口区', '2', '2014-08-13 21:33:57');
INSERT INTO `t_district` VALUES ('5', '蜀山区', '3', '2014-08-13 21:34:27');
INSERT INTO `t_district` VALUES ('6', '瑶海区', '3', '2014-08-13 21:34:41');
INSERT INTO `t_district` VALUES ('7', '测试区', '4', '2014-08-16 11:28:46');
INSERT INTO `t_district` VALUES ('8', '鼓楼区', '1', '2014-08-16 13:34:15');

-- ----------------------------
-- Table structure for `t_node`
-- ----------------------------
DROP TABLE IF EXISTS `t_node`;
CREATE TABLE `t_node` (
  `nid` varchar(255) NOT NULL COMMENT '节点SIM卡号',
  `baidu_id` bigint(20) unsigned NOT NULL,
  `lng` float NOT NULL COMMENT '节点所在经度',
  `lat` float NOT NULL COMMENT '节点所在纬度',
  `nname` varchar(255) DEFAULT NULL COMMENT '节点名称',
  `first_access` datetime NOT NULL COMMENT '首次接入时间',
  `last_access` datetime NOT NULL COMMENT '最后一次接入时间',
  `nmode` enum('1','0') NOT NULL DEFAULT '1' COMMENT '模式',
  `auto_mix_scale` int(11) NOT NULL DEFAULT '0' COMMENT '药水混合比例值',
  `auto_mix_level` int(11) NOT NULL DEFAULT '0' COMMENT '药水混合总量',
  `auto_mix_freq` int(11) NOT NULL DEFAULT '0' COMMENT '自动模式喷洒频率',
  `auto_cleanup_time` int(11) NOT NULL DEFAULT '0' COMMENT '喷洒时间',
  `did` int(11) NOT NULL COMMENT '节点所属区县',
  `nnh3` int(11) NOT NULL DEFAULT '0' COMMENT '氨气喷洒阈值 自动模式有效',
  `nh2s` int(11) NOT NULL DEFAULT '0' COMMENT '硫化氢喷洒阈值 自动模式有效',
  `last_op_time` datetime DEFAULT NULL COMMENT '节点最后一次操作时间',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_node
-- ----------------------------
INSERT INTO `t_node` VALUES ('123456789012345', '455405007', '118.965', '32.4812', 'NewNode2', '2014-08-16 13:34:13', '2014-09-05 13:08:32', '1', '12', '231', '11', '0', '8', '12', '12', null);
INSERT INTO `t_node` VALUES ('861311002450046', '483801216', '118.773', '32.0569', 'Test', '2014-09-02 19:56:01', '2014-09-04 18:00:11', '1', '12', '10', '0', '0', '8', '0', '0', null);

-- ----------------------------
-- Table structure for `t_node_op`
-- ----------------------------
DROP TABLE IF EXISTS `t_node_op`;
CREATE TABLE `t_node_op` (
  `oid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '操作ID',
  `nid` varchar(255) NOT NULL COMMENT '被操作的节点ID',
  `otype` enum('3','2','0','1') NOT NULL DEFAULT '1' COMMENT '操作类型：0-设置自动模式数据，1-设置为手动模式，2-启动药水混合，3-启动清洁',
  `otime` datetime NOT NULL,
  `mix_scale` float NOT NULL COMMENT '药水混合比例值',
  `mix_level` float NOT NULL COMMENT '药水混合总量(单位待定)',
  `mix_freq` int(11) NOT NULL COMMENT '喷洒频率/时间(以秒为单位)',
  `onh3` int(11) NOT NULL DEFAULT '0' COMMENT '氨气喷洒阈值',
  `oh2s` int(11) NOT NULL DEFAULT '0' COMMENT '硫化氢喷洒阈值',
  `oresult` tinyint(1) NOT NULL DEFAULT '0' COMMENT '操作结果,0失败，1成功',
  PRIMARY KEY (`oid`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_node_op
-- ----------------------------
INSERT INTO `t_node_op` VALUES ('1', 'WDRFTGYHUJIKOLK', '0', '2014-08-13 22:37:24', '25', '15', '54', '37', '54', '0');
INSERT INTO `t_node_op` VALUES ('2', 'WDRFTGYHUJIKOLK', '1', '2014-08-13 22:39:24', '0', '0', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('3', 'WDRFTGYHUJIKOER', '2', '2014-08-13 22:41:14', '43', '23', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('4', 'WDRFTGYHUJIKOTY', '3', '2014-08-13 22:42:20', '0', '0', '18', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('5', '123456789012345', '1', '2014-08-16 13:58:52', '0', '0', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('6', '123456789012345', '2', '2014-08-16 13:59:51', '0', '0', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('7', '123456789012345', '3', '2014-08-16 14:00:08', '0', '0', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('8', '123456789012345', '0', '2014-08-16 14:00:58', '1', '2', '3', '4', '5', '1');
INSERT INTO `t_node_op` VALUES ('9', 'WDRFTGYHUJIKOLK', '0', '2014-08-16 14:06:58', '0', '0', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('10', 'WDRFTGYHUJIKOLK', '0', '2014-08-16 14:08:05', '0', '0', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('11', '123456789012345', '0', '2014-08-16 14:09:13', '1', '0', '3', '4', '5', '0');
INSERT INTO `t_node_op` VALUES ('12', '123456789012345', '0', '2014-08-16 14:30:40', '1', '2', '3', '4', '5', '1');
INSERT INTO `t_node_op` VALUES ('13', '123456789012345', '0', '2014-08-16 14:31:39', '10', '20', '30', '40', '50', '1');
INSERT INTO `t_node_op` VALUES ('14', '123456789012345', '0', '2014-08-16 14:33:33', '11', '0', '21', '31', '41', '1');
INSERT INTO `t_node_op` VALUES ('15', '123456789012345', '0', '2014-08-16 14:34:35', '12', '0', '22', '32', '42', '0');
INSERT INTO `t_node_op` VALUES ('16', '123456789012345', '0', '2014-08-16 14:42:02', '13', '0', '23', '33', '43', '0');
INSERT INTO `t_node_op` VALUES ('17', '123456789012345', '0', '2014-08-16 14:43:28', '14', '0', '24', '34', '44', '0');
INSERT INTO `t_node_op` VALUES ('18', '123456789012345', '1', '2014-08-16 14:45:13', '14', '0', '24', '34', '44', '0');
INSERT INTO `t_node_op` VALUES ('19', '123456789012345', '0', '2014-08-16 15:05:04', '11', '0', '21', '31', '41', '1');
INSERT INTO `t_node_op` VALUES ('20', '123456789012345', '1', '2014-08-16 15:07:27', '11', '0', '21', '31', '41', '1');
INSERT INTO `t_node_op` VALUES ('21', '123456789012345', '0', '2014-08-16 15:08:05', '11', '0', '21', '31', '41', '0');
INSERT INTO `t_node_op` VALUES ('22', '123456789012345', '1', '2014-08-16 15:09:42', '11', '0', '21', '31', '41', '1');
INSERT INTO `t_node_op` VALUES ('23', '123456789012345', '1', '2014-08-16 15:12:47', '11', '0', '21', '31', '41', '1');
INSERT INTO `t_node_op` VALUES ('24', '123456789012345', '1', '2014-08-16 15:13:11', '11', '0', '21', '31', '41', '0');
INSERT INTO `t_node_op` VALUES ('25', '123456789012345', '1', '2014-08-16 15:14:02', '11', '0', '21', '31', '41', '0');
INSERT INTO `t_node_op` VALUES ('26', '123456789012345', '1', '2014-08-16 15:23:28', '11', '0', '21', '31', '41', '1');
INSERT INTO `t_node_op` VALUES ('27', '123456789012345', '1', '2014-08-16 15:24:52', '11', '0', '21', '31', '41', '0');
INSERT INTO `t_node_op` VALUES ('28', '123456789012345', '1', '2014-08-16 15:26:00', '11', '0', '21', '31', '41', '0');
INSERT INTO `t_node_op` VALUES ('29', '123456789012345', '1', '2014-08-16 15:26:58', '11', '0', '21', '31', '41', '1');
INSERT INTO `t_node_op` VALUES ('30', '123456789012345', '0', '2014-08-16 15:27:23', '11', '0', '21', '31', '41', '0');
INSERT INTO `t_node_op` VALUES ('31', '123456789012345', '0', '2014-08-16 15:30:05', '11', '0', '21', '31', '41', '0');
INSERT INTO `t_node_op` VALUES ('32', '123456789012345', '0', '2014-08-16 15:34:11', '11', '0', '21', '31', '41', '0');
INSERT INTO `t_node_op` VALUES ('33', '123456789012345', '1', '2014-08-16 15:34:34', '11', '0', '21', '31', '41', '1');
INSERT INTO `t_node_op` VALUES ('34', '123456789012345', '0', '2014-08-16 15:34:45', '11', '0', '21', '31', '41', '1');
INSERT INTO `t_node_op` VALUES ('35', '123456789012345', '0', '2014-08-16 15:34:58', '11', '0', '21', '31', '41', '1');
INSERT INTO `t_node_op` VALUES ('36', '123456789012345', '0', '2014-08-16 15:57:49', '11', '0', '21', '31', '41', '1');
INSERT INTO `t_node_op` VALUES ('37', 'WDRFTGYHUJIKOER', '0', '2014-08-16 16:52:32', '56', '56', '43', '43', '43', '0');
INSERT INTO `t_node_op` VALUES ('38', '123456789012345', '0', '2014-08-16 17:00:24', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('39', 'WDRFTGYHUJIKOTY', '0', '2014-08-16 17:01:19', '34', '34', '34', '34', '4', '0');
INSERT INTO `t_node_op` VALUES ('40', 'WDRFTGYHUJIKOLK', '2', '2014-09-01 13:18:56', '0', '0', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('41', 'WDRFTGYHUJIKOLK', '2', '2014-09-01 13:19:01', '0', '0', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('42', '123456789012345', '2', '2014-09-02 19:36:37', '12', '0', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('43', '861311002450046', '0', '2014-09-02 20:44:49', '0', '0', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('44', '861311002450046', '2', '2014-09-02 21:04:50', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('45', '861311002450046', '2', '2014-09-02 21:25:27', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('46', '861311002450046', '2', '2014-09-02 21:26:17', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('47', '861311002450046', '2', '2014-09-02 21:27:37', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('48', '861311002450046', '2', '2014-09-02 21:28:14', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('49', '861311002450046', '2', '2014-09-02 21:31:57', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('50', '861311002450046', '2', '2014-09-02 21:32:30', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('51', '861311002450046', '2', '2014-09-02 21:32:58', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('52', '861311002450046', '2', '2014-09-02 21:34:04', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('53', '861311002450046', '2', '2014-09-02 21:34:32', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('54', '861311002450046', '2', '2014-09-02 21:34:57', '12', '10', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('55', '861311002450046', '2', '2014-09-02 21:35:23', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('56', '861311002450046', '2', '2014-09-02 21:35:40', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('57', '861311002450046', '2', '2014-09-02 21:35:54', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('58', '861311002450046', '2', '2014-09-02 21:36:38', '12', '10', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('59', '861311002450046', '2', '2014-09-02 21:42:38', '12', '10', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('60', '861311002450046', '2', '2014-09-02 21:42:53', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('61', '861311002450046', '2', '2014-09-02 21:43:15', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('62', '861311002450046', '2', '2014-09-02 21:43:44', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('63', '861311002450046', '2', '2014-09-02 21:44:00', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('64', '861311002450046', '2', '2014-09-02 21:44:12', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('65', '123456789012345', '2', '2014-09-02 21:46:12', '12', '0', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('66', '123456789012345', '2', '2014-09-02 21:46:17', '12', '0', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('67', '123456789012345', '3', '2014-09-02 21:46:45', '0', '0', '12', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('68', '123456789012345', '1', '2014-09-03 10:48:27', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('69', '123456789012345', '1', '2014-09-03 12:39:01', '12', '0', '12', '12', '12', '0');
INSERT INTO `t_node_op` VALUES ('70', '123456789012345', '1', '2014-09-03 12:43:11', '12', '0', '12', '12', '12', '0');
INSERT INTO `t_node_op` VALUES ('71', '123456789012345', '1', '2014-09-03 12:43:25', '12', '0', '12', '12', '12', '0');
INSERT INTO `t_node_op` VALUES ('72', '123456789012345', '1', '2014-09-03 12:44:34', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('73', '123456789012345', '1', '2014-09-03 12:48:18', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('74', '123456789012345', '1', '2014-09-03 12:49:25', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('75', '123456789012345', '1', '2014-09-03 12:49:56', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('76', '123456789012345', '1', '2014-09-03 12:50:11', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('77', '123456789012345', '1', '2014-09-03 12:50:41', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('78', '123456789012345', '1', '2014-09-03 12:51:28', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('79', '123456789012345', '1', '2014-09-03 12:52:20', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('80', '123456789012345', '1', '2014-09-03 12:52:59', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('81', '123456789012345', '1', '2014-09-03 12:53:16', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('82', '123456789012345', '1', '2014-09-03 12:58:32', '12', '0', '12', '12', '12', '0');
INSERT INTO `t_node_op` VALUES ('83', '123456789012345', '1', '2014-09-03 13:25:55', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('84', '123456789012345', '1', '2014-09-03 13:26:31', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('85', '123456789012345', '1', '2014-09-03 17:54:15', '12', '0', '12', '12', '12', '1');
INSERT INTO `t_node_op` VALUES ('86', '861311002450046', '1', '2014-09-03 17:59:56', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('87', '861311002450046', '2', '2014-09-03 19:36:41', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('88', '861311002450046', '2', '2014-09-03 19:37:24', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('89', '861311002450046', '2', '2014-09-03 19:37:33', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('90', '861311002450046', '2', '2014-09-03 19:37:49', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('91', '861311002450046', '2', '2014-09-03 19:38:07', '12', '10', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('92', '861311002450046', '2', '2014-09-03 19:43:34', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('93', '861311002450046', '2', '2014-09-03 19:47:05', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('94', '861311002450046', '2', '2014-09-03 19:49:22', '12', '10', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('95', '861311002450046', '2', '2014-09-03 19:49:32', '12', '10', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('96', '861311002450046', '2', '2014-09-03 19:49:38', '12', '10', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('97', '861311002450046', '2', '2014-09-03 19:49:57', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('98', '861311002450046', '2', '2014-09-03 19:51:32', '12', '10', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('99', '123456789012345', '2', '2014-09-03 20:46:17', '12', '0', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('100', '123456789012345', '2', '2014-09-03 20:48:46', '12', '0', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('101', '123456789012345', '2', '2014-09-03 21:34:14', '12', '0', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('102', '123456789012345', '2', '2014-09-03 21:34:33', '12', '7', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('103', '123456789012345', '2', '2014-09-03 21:34:50', '12', '7', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('104', '123456789012345', '2', '2014-09-03 21:35:28', '12', '7', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('105', '123456789012345', '2', '2014-09-04 12:05:20', '12', '7', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('106', '123456789012345', '2', '2014-09-04 12:13:21', '12', '7', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('107', '123456789012345', '2', '2014-09-04 12:13:37', '12', '98', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('108', '123456789012345', '2', '2014-09-04 12:13:51', '12', '257', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('109', '123456789012345', '3', '2014-09-04 12:14:16', '0', '0', '11', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('110', '123456789012345', '3', '2014-09-04 12:14:50', '0', '0', '11', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('111', '123456789012345', '2', '2014-09-04 12:14:59', '12', '257', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('112', '123456789012345', '3', '2014-09-04 12:15:00', '0', '0', '11', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('113', '123456789012345', '2', '2014-09-04 21:55:49', '12', '257', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('114', '123456789012345', '2', '2014-09-04 21:56:12', '12', '200', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('115', '123456789012345', '2', '2014-09-04 21:56:34', '12', '200', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('116', '123456789012345', '2', '2014-09-04 21:56:44', '12', '200', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('117', '123456789012345', '2', '2014-09-04 21:57:25', '12', '200', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('118', '123456789012345', '2', '2014-09-04 21:59:02', '12', '200', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('119', '123456789012345', '2', '2014-09-04 22:00:20', '12', '257', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('120', '123456789012345', '2', '2014-09-04 22:01:35', '12', '257', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('121', '123456789012345', '2', '2014-09-04 22:01:59', '12', '257', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('122', '123456789012345', '2', '2014-09-04 22:02:10', '12', '231', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('123', '123456789012345', '2', '2014-09-04 22:05:12', '12', '231', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('124', '123456789012345', '2', '2014-09-04 22:05:36', '12', '231', '0', '0', '0', '0');
INSERT INTO `t_node_op` VALUES ('125', '123456789012345', '2', '2014-09-04 22:06:35', '12', '231', '0', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('126', '123456789012345', '3', '2014-09-04 22:06:58', '0', '0', '11', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('127', '123456789012345', '3', '2014-09-04 22:07:03', '0', '0', '11', '0', '0', '1');
INSERT INTO `t_node_op` VALUES ('128', '123456789012345', '1', '2014-09-04 22:07:15', '12', '231', '11', '12', '12', '0');
INSERT INTO `t_node_op` VALUES ('129', '123456789012345', '1', '2014-09-04 22:09:48', '12', '231', '11', '12', '12', '0');
INSERT INTO `t_node_op` VALUES ('130', '123456789012345', '1', '2014-09-04 22:10:03', '12', '231', '11', '12', '12', '0');
INSERT INTO `t_node_op` VALUES ('131', '123456789012345', '1', '2014-09-04 23:26:51', '12', '231', '11', '12', '0', '0');
INSERT INTO `t_node_op` VALUES ('132', '123456789012345', '1', '2014-09-04 23:27:19', '12', '231', '11', '12', '12', '0');

-- ----------------------------
-- Table structure for `t_node_state`
-- ----------------------------
DROP TABLE IF EXISTS `t_node_state`;
CREATE TABLE `t_node_state` (
  `sid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '状态ID',
  `nid` char(20) NOT NULL COMMENT '节点ID',
  `stime` datetime NOT NULL COMMENT '时间',
  `snh3` int(11) DEFAULT NULL COMMENT '氨气浓度',
  `sh2s` int(11) DEFAULT NULL COMMENT '硫化氢浓度',
  `sadc` int(11) DEFAULT NULL COMMENT 'ADC测得的电压值',
  `slatitude` float DEFAULT NULL COMMENT '纬度',
  `slongitude` float(11,0) DEFAULT NULL COMMENT '经度',
  `smix_level` int(11) DEFAULT NULL COMMENT '当前混合液量',
  `smix_scale` int(11) DEFAULT NULL COMMENT '当前混合比例',
  `scleanup_time` int(11) DEFAULT NULL COMMENT '喷洒持续时间',
  `scleanup_freq` int(11) DEFAULT NULL COMMENT '喷洒频率/间隔，单位秒',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=1294 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_node_state
-- ----------------------------
INSERT INTO `t_node_state` VALUES ('1', '0', '2014-08-16 11:43:38', '44', '44', '0', null, '0', null, null, null, null);
INSERT INTO `t_node_state` VALUES ('2', '0', '2014-08-16 11:44:26', '44', '44', '0', null, '0', null, null, null, null);
INSERT INTO `t_node_state` VALUES ('3', 'QWQWQWQWQW2', '2014-08-16 11:45:15', '44', '44', '0', null, '0', null, null, null, null);
INSERT INTO `t_node_state` VALUES ('4', 'QWQWQWQWQW2', '2014-08-16 11:52:06', '44', '44', '0', null, '0', null, null, null, null);
INSERT INTO `t_node_state` VALUES ('5', 'QWQWQWQWQW2', '2014-08-16 11:52:23', '44', '44', '0', null, '0', null, null, null, null);
INSERT INTO `t_node_state` VALUES ('6', '861311002450046', '2014-09-02 19:01:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('7', '861311002450046', '2014-09-02 19:14:56', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('8', '861311002450046', '2014-09-02 19:20:38', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('9', '861311002450046', '2014-09-02 19:20:47', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('10', '861311002450046', '2014-09-02 19:20:57', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('11', '861311002450046', '2014-09-02 19:20:58', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('12', '861311002450046', '2014-09-02 19:24:20', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('13', '861311002450046', '2014-09-02 19:24:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('14', '861311002450046', '2014-09-02 19:24:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('15', '861311002450046', '2014-09-02 19:24:30', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('16', '861311002450046', '2014-09-02 19:25:16', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('17', '861311002450046', '2014-09-02 19:25:25', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('18', '861311002450046', '2014-09-02 19:25:35', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('19', '861311002450046', '2014-09-02 19:25:38', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('20', '861311002450046', '2014-09-02 19:25:47', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('21', '861311002450046', '2014-09-02 19:26:33', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('22', '861311002450046', '2014-09-02 19:30:27', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('23', '861311002450046', '2014-09-02 19:30:38', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('24', '861311002450046', '2014-09-02 19:30:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('25', '861311002450046', '2014-09-02 19:31:00', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('26', '861311002450046', '2014-09-02 19:31:11', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('27', '861311002450046', '2014-09-02 19:38:37', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('28', '861311002450046', '2014-09-02 19:38:47', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('29', '861311002450046', '2014-09-02 19:38:58', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('30', '861311002450046', '2014-09-02 19:39:10', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('31', '861311002450046', '2014-09-02 19:39:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('32', '861311002450046', '2014-09-02 19:39:32', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('33', '861311002450046', '2014-09-02 19:39:43', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('34', '861311002450046', '2014-09-02 19:39:54', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('35', '861311002450046', '2014-09-02 19:40:05', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('36', '861311002450046', '2014-09-02 19:40:16', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('37', '861311002450046', '2014-09-02 19:40:27', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('38', '861311002450046', '2014-09-02 19:40:38', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('39', '861311002450046', '2014-09-02 19:40:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('40', '861311002450046', '2014-09-02 19:41:00', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('41', '861311002450046', '2014-09-02 19:41:11', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('42', '861311002450046', '2014-09-02 19:41:22', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('43', '861311002450046', '2014-09-02 19:41:33', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('44', '861311002450046', '2014-09-02 19:41:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('45', '861311002450046', '2014-09-02 19:41:55', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('46', '861311002450046', '2014-09-02 19:42:08', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('47', '861311002450046', '2014-09-02 19:42:17', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('48', '861311002450046', '2014-09-02 19:42:28', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('49', '861311002450046', '2014-09-02 19:42:39', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('50', '861311002450046', '2014-09-02 19:47:56', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('51', '861311002450046', '2014-09-02 19:48:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('52', '861311002450046', '2014-09-02 19:49:08', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('53', '861311002450046', '2014-09-02 19:49:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('54', '861311002450046', '2014-09-02 20:02:36', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('55', '861311002450046', '2014-09-02 20:02:38', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('56', '861311002450046', '2014-09-02 20:13:37', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('57', '861311002450046', '2014-09-02 20:15:53', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('58', '861311002450046', '2014-09-02 20:16:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('59', '861311002450046', '2014-09-02 20:16:15', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('60', '861311002450046', '2014-09-02 20:16:26', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('61', '861311002450046', '2014-09-02 20:16:39', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('62', '861311002450046', '2014-09-02 20:16:48', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('63', '861311002450046', '2014-09-02 20:16:59', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('64', '861311002450046', '2014-09-02 20:17:10', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('65', '861311002450046', '2014-09-02 20:17:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('66', '861311002450046', '2014-09-02 20:17:32', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('67', '861311002450046', '2014-09-02 20:17:43', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('68', '861311002450046', '2014-09-02 20:17:54', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('69', '861311002450046', '2014-09-02 20:18:05', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('70', '861311002450046', '2014-09-02 20:18:16', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('71', '861311002450046', '2014-09-02 20:18:27', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('72', '861311002450046', '2014-09-02 20:18:38', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('73', '861311002450046', '2014-09-02 20:28:43', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('74', '861311002450046', '2014-09-02 20:28:53', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('75', '861311002450046', '2014-09-02 20:29:12', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('76', '861311002450046', '2014-09-02 20:29:15', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('77', '861311002450046', '2014-09-02 20:29:26', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('78', '861311002450046', '2014-09-02 20:29:37', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('79', '861311002450046', '2014-09-02 20:29:48', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('80', '861311002450046', '2014-09-02 20:30:10', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('81', '861311002450046', '2014-09-02 20:30:22', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('82', '861311002450046', '2014-09-02 20:30:32', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('83', '861311002450046', '2014-09-02 20:30:43', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('84', '861311002450046', '2014-09-02 20:30:54', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('85', '861311002450046', '2014-09-02 20:39:57', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('86', '861311002450046', '2014-09-02 20:59:37', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('87', '861311002450046', '2014-09-02 20:59:47', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('88', '861311002450046', '2014-09-02 21:01:22', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('89', '861311002450046', '2014-09-02 21:03:47', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('90', '861311002450046', '2014-09-02 21:03:57', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('91', '861311002450046', '2014-09-02 21:04:19', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('92', '861311002450046', '2014-09-02 21:04:28', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('93', '861311002450046', '2014-09-02 21:04:30', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('94', '861311002450046', '2014-09-02 21:04:43', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('95', '861311002450046', '2014-09-02 21:04:52', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('96', '861311002450046', '2014-09-02 21:05:03', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('97', '861311002450046', '2014-09-02 21:05:14', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('98', '861311002450046', '2014-09-02 21:05:25', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('99', '861311002450046', '2014-09-02 21:05:36', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('100', '861311002450046', '2014-09-02 21:05:47', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('101', '861311002450046', '2014-09-02 21:08:17', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('102', '861311002450046', '2014-09-02 21:08:22', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('103', '861311002450046', '2014-09-02 21:08:33', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('104', '861311002450046', '2014-09-02 21:08:45', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('105', '861311002450046', '2014-09-02 21:08:56', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('106', '861311002450046', '2014-09-02 21:09:07', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('107', '861311002450046', '2014-09-02 21:09:18', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('108', '861311002450046', '2014-09-02 21:09:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('109', '861311002450046', '2014-09-02 21:11:03', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('110', '861311002450046', '2014-09-02 21:11:05', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('111', '861311002450046', '2014-09-02 21:11:16', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('112', '861311002450046', '2014-09-02 21:13:16', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('113', '861311002450046', '2014-09-02 21:14:41', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('114', '861311002450046', '2014-09-02 21:14:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('115', '861311002450046', '2014-09-02 21:14:55', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('116', '861311002450046', '2014-09-02 21:15:08', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('117', '861311002450046', '2014-09-02 21:15:17', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('118', '861311002450046', '2014-09-02 21:15:30', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('119', '861311002450046', '2014-09-02 21:15:39', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('120', '861311002450046', '2014-09-02 21:17:16', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('121', '861311002450046', '2014-09-02 21:17:22', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('122', '861311002450046', '2014-09-02 21:17:33', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('123', '861311002450046', '2014-09-02 21:17:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('124', '861311002450046', '2014-09-02 21:20:17', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('125', '861311002450046', '2014-09-02 21:20:23', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('126', '861311002450046', '2014-09-02 21:20:38', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('127', '861311002450046', '2014-09-02 21:24:12', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('128', '861311002450046', '2014-09-02 21:24:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('129', '861311002450046', '2014-09-02 21:24:34', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('130', '861311002450046', '2014-09-02 21:24:43', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('131', '861311002450046', '2014-09-02 21:24:57', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('132', '861311002450046', '2014-09-02 21:25:05', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('133', '861311002450046', '2014-09-02 21:25:18', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('134', '861311002450046', '2014-09-02 21:25:27', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('135', '861311002450046', '2014-09-02 21:25:38', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('136', '861311002450046', '2014-09-02 21:25:59', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('137', '861311002450046', '2014-09-02 21:25:59', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('138', '861311002450046', '2014-09-02 21:26:01', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('139', '861311002450046', '2014-09-02 21:26:11', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('140', '861311002450046', '2014-09-02 21:26:36', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('141', '861311002450046', '2014-09-02 21:26:38', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('142', '861311002450046', '2014-09-02 21:26:40', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('143', '861311002450046', '2014-09-02 21:27:07', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('144', '861311002450046', '2014-09-02 21:27:07', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('145', '861311002450046', '2014-09-02 21:27:07', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('146', '861311002450046', '2014-09-02 21:27:07', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('147', '861311002450046', '2014-09-02 21:27:07', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('148', '861311002450046', '2014-09-02 21:28:00', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('149', '861311002450046', '2014-09-02 21:28:03', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('150', '861311002450046', '2014-09-02 21:28:19', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('151', '861311002450046', '2014-09-02 21:28:27', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('152', '861311002450046', '2014-09-02 21:28:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('153', '861311002450046', '2014-09-02 21:28:39', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('154', '861311002450046', '2014-09-02 21:28:50', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('155', '861311002450046', '2014-09-02 21:30:52', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('156', '861311002450046', '2014-09-02 21:30:52', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('157', '861311002450046', '2014-09-02 21:30:52', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('158', '861311002450046', '2014-09-02 21:30:53', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('159', '861311002450046', '2014-09-02 21:30:53', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('160', '861311002450046', '2014-09-02 21:30:53', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('161', '861311002450046', '2014-09-02 21:30:53', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('162', '861311002450046', '2014-09-02 21:30:58', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('163', '861311002450046', '2014-09-02 21:31:14', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('164', '861311002450046', '2014-09-02 21:31:23', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('165', '861311002450046', '2014-09-02 21:31:34', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('166', '861311002450046', '2014-09-02 21:31:45', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('167', '861311002450046', '2014-09-02 21:31:56', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('168', '861311002450046', '2014-09-02 21:32:07', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('169', '861311002450046', '2014-09-02 21:32:18', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('170', '861311002450046', '2014-09-02 21:32:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('171', '861311002450046', '2014-09-02 21:32:40', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('172', '861311002450046', '2014-09-02 21:33:11', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('173', '861311002450046', '2014-09-02 21:33:42', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('174', '861311002450046', '2014-09-02 21:33:46', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('175', '861311002450046', '2014-09-02 21:34:05', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('176', '861311002450046', '2014-09-02 21:34:12', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('177', '861311002450046', '2014-09-02 21:34:14', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('178', '861311002450046', '2014-09-02 21:34:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('179', '861311002450046', '2014-09-02 21:34:35', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('180', '861311002450046', '2014-09-02 21:34:48', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('181', '861311002450046', '2014-09-02 21:34:57', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('182', '861311002450046', '2014-09-02 21:35:09', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('183', '861311002450046', '2014-09-02 21:35:11', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('184', '861311002450046', '2014-09-02 21:35:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('185', '861311002450046', '2014-09-02 21:35:32', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('186', '861311002450046', '2014-09-02 21:35:43', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('187', '861311002450046', '2014-09-02 21:36:03', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('188', '861311002450046', '2014-09-02 21:36:05', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('189', '861311002450046', '2014-09-02 21:36:16', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('190', '861311002450046', '2014-09-02 21:36:27', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('191', '861311002450046', '2014-09-02 21:36:39', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('192', '861311002450046', '2014-09-02 21:36:51', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('193', '861311002450046', '2014-09-02 21:36:53', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('194', '861311002450046', '2014-09-02 21:37:06', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('195', '861311002450046', '2014-09-02 21:37:15', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('196', '861311002450046', '2014-09-02 21:37:28', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('197', '861311002450046', '2014-09-02 21:37:37', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('198', '861311002450046', '2014-09-02 21:42:16', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('199', '861311002450046', '2014-09-02 21:42:26', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('200', '861311002450046', '2014-09-02 21:42:39', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('201', '861311002450046', '2014-09-02 21:42:47', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('202', '861311002450046', '2014-09-02 21:42:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('203', '861311002450046', '2014-09-02 21:42:59', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('204', '861311002450046', '2014-09-02 21:43:10', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('205', '861311002450046', '2014-09-02 21:43:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('206', '861311002450046', '2014-09-02 21:43:32', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('207', '861311002450046', '2014-09-02 21:43:43', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('208', '861311002450046', '2014-09-02 21:43:54', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('209', '861311002450046', '2014-09-02 21:44:05', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('210', '861311002450046', '2014-09-02 21:44:16', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('211', '861311002450046', '2014-09-02 21:44:27', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('212', '861311002450046', '2014-09-02 21:44:40', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('213', '123456789012345', '2014-09-03 12:33:42', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('214', '123456789012345', '2014-09-03 12:34:02', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('215', '123456789012345', '2014-09-03 12:34:22', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('216', '123456789012345', '2014-09-03 12:34:42', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('217', '123456789012345', '2014-09-03 12:35:02', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('218', '123456789012345', '2014-09-03 12:35:22', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('219', '123456789012345', '2014-09-03 12:35:42', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('220', '123456789012345', '2014-09-03 12:36:02', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('221', '123456789012345', '2014-09-03 12:36:22', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('222', '123456789012345', '2014-09-03 12:36:42', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('223', '123456789012345', '2014-09-03 12:37:02', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('224', '123456789012345', '2014-09-03 12:43:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('225', '123456789012345', '2014-09-03 12:44:09', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('226', '123456789012345', '2014-09-03 12:44:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('227', '123456789012345', '2014-09-03 12:44:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('228', '123456789012345', '2014-09-03 12:45:09', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('229', '123456789012345', '2014-09-03 12:45:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('230', '123456789012345', '2014-09-03 12:45:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('231', '123456789012345', '2014-09-03 12:46:09', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('232', '123456789012345', '2014-09-03 12:46:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('233', '123456789012345', '2014-09-03 12:46:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('234', '123456789012345', '2014-09-03 12:47:10', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('235', '123456789012345', '2014-09-03 12:47:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('236', '123456789012345', '2014-09-03 12:47:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('237', '123456789012345', '2014-09-03 12:48:09', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('238', '123456789012345', '2014-09-03 12:48:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('239', '123456789012345', '2014-09-03 12:48:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('240', '123456789012345', '2014-09-03 12:49:09', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('241', '123456789012345', '2014-09-03 12:49:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('242', '123456789012345', '2014-09-03 12:49:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('243', '123456789012345', '2014-09-03 12:50:09', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('244', '123456789012345', '2014-09-03 12:50:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('245', '123456789012345', '2014-09-03 12:50:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('246', '123456789012345', '2014-09-03 12:51:09', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('247', '123456789012345', '2014-09-03 12:51:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('248', '123456789012345', '2014-09-03 12:51:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('249', '123456789012345', '2014-09-03 12:52:09', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('250', '123456789012345', '2014-09-03 12:52:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('251', '123456789012345', '2014-09-03 12:52:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('252', '123456789012345', '2014-09-03 12:53:09', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('253', '123456789012345', '2014-09-03 12:53:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('254', '123456789012345', '2014-09-03 12:53:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('255', '123456789012345', '2014-09-03 12:54:09', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('256', '123456789012345', '2014-09-03 12:54:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('257', '123456789012345', '2014-09-03 12:54:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('258', '123456789012345', '2014-09-03 12:55:09', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('259', '123456789012345', '2014-09-03 12:55:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('260', '123456789012345', '2014-09-03 12:55:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('261', '123456789012345', '2014-09-03 12:56:09', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('262', '123456789012345', '2014-09-03 12:56:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('263', '123456789012345', '2014-09-03 12:56:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('264', '123456789012345', '2014-09-03 12:57:09', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('265', '123456789012345', '2014-09-03 12:57:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('266', '123456789012345', '2014-09-03 12:58:05', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('267', '123456789012345', '2014-09-03 12:59:31', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('268', '123456789012345', '2014-09-03 13:03:43', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('269', '123456789012345', '2014-09-03 13:06:43', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('270', '123456789012345', '2014-09-03 13:07:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('271', '123456789012345', '2014-09-03 13:07:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('272', '123456789012345', '2014-09-03 13:15:56', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('273', '123456789012345', '2014-09-03 13:16:15', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('274', '123456789012345', '2014-09-03 13:16:35', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('275', '123456789012345', '2014-09-03 13:16:55', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('276', '123456789012345', '2014-09-03 13:17:15', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('277', '123456789012345', '2014-09-03 13:17:35', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('278', '123456789012345', '2014-09-03 13:17:55', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('279', '123456789012345', '2014-09-03 13:18:15', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('280', '123456789012345', '2014-09-03 13:18:35', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('281', '123456789012345', '2014-09-03 13:18:55', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('282', '123456789012345', '2014-09-03 13:19:15', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('283', '123456789012345', '2014-09-03 13:19:35', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('284', '123456789012345', '2014-09-03 13:19:55', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('285', '123456789012345', '2014-09-03 13:25:55', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('286', '123456789012345', '2014-09-03 13:26:15', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('287', '123456789012345', '2014-09-03 13:26:35', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('288', '123456789012345', '2014-09-03 13:26:55', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('289', '123456789012345', '2014-09-03 13:27:15', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('290', '123456789012345', '2014-09-03 13:27:35', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('291', '123456789012345', '2014-09-03 13:27:55', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('292', '123456789012345', '2014-09-03 13:28:15', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('293', '123456789012345', '2014-09-03 16:28:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('294', '123456789012345', '2014-09-03 16:28:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('295', '123456789012345', '2014-09-03 16:29:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('296', '123456789012345', '2014-09-03 16:29:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('297', '123456789012345', '2014-09-03 16:29:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('298', '123456789012345', '2014-09-03 16:30:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('299', '123456789012345', '2014-09-03 16:30:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('300', '123456789012345', '2014-09-03 16:30:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('301', '123456789012345', '2014-09-03 16:31:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('302', '123456789012345', '2014-09-03 16:31:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('303', '123456789012345', '2014-09-03 16:31:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('304', '123456789012345', '2014-09-03 16:32:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('305', '123456789012345', '2014-09-03 16:32:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('306', '123456789012345', '2014-09-03 16:32:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('307', '123456789012345', '2014-09-03 16:33:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('308', '123456789012345', '2014-09-03 16:33:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('309', '123456789012345', '2014-09-03 16:33:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('310', '123456789012345', '2014-09-03 16:34:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('311', '123456789012345', '2014-09-03 16:34:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('312', '123456789012345', '2014-09-03 16:34:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('313', '123456789012345', '2014-09-03 16:35:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('314', '123456789012345', '2014-09-03 16:35:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('315', '123456789012345', '2014-09-03 16:35:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('316', '123456789012345', '2014-09-03 16:36:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('317', '123456789012345', '2014-09-03 16:36:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('318', '123456789012345', '2014-09-03 16:36:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('319', '123456789012345', '2014-09-03 16:37:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('320', '123456789012345', '2014-09-03 16:37:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('321', '123456789012345', '2014-09-03 16:37:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('322', '123456789012345', '2014-09-03 16:38:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('323', '123456789012345', '2014-09-03 16:38:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('324', '123456789012345', '2014-09-03 16:38:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('325', '123456789012345', '2014-09-03 16:39:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('326', '123456789012345', '2014-09-03 16:39:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('327', '123456789012345', '2014-09-03 16:39:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('328', '123456789012345', '2014-09-03 16:40:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('329', '123456789012345', '2014-09-03 16:40:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('330', '123456789012345', '2014-09-03 16:40:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('331', '123456789012345', '2014-09-03 16:41:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('332', '123456789012345', '2014-09-03 16:41:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('333', '123456789012345', '2014-09-03 16:41:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('334', '123456789012345', '2014-09-03 16:42:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('335', '123456789012345', '2014-09-03 16:42:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('336', '123456789012345', '2014-09-03 16:42:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('337', '123456789012345', '2014-09-03 16:43:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('338', '123456789012345', '2014-09-03 16:43:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('339', '123456789012345', '2014-09-03 16:43:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('340', '123456789012345', '2014-09-03 16:44:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('341', '123456789012345', '2014-09-03 16:44:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('342', '123456789012345', '2014-09-03 16:44:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('343', '123456789012345', '2014-09-03 16:45:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('344', '123456789012345', '2014-09-03 16:45:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('345', '123456789012345', '2014-09-03 16:45:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('346', '123456789012345', '2014-09-03 16:46:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('347', '123456789012345', '2014-09-03 16:46:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('348', '123456789012345', '2014-09-03 16:46:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('349', '123456789012345', '2014-09-03 16:47:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('350', '123456789012345', '2014-09-03 16:47:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('351', '123456789012345', '2014-09-03 16:47:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('352', '123456789012345', '2014-09-03 16:48:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('353', '123456789012345', '2014-09-03 16:48:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('354', '123456789012345', '2014-09-03 16:48:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('355', '123456789012345', '2014-09-03 16:49:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('356', '123456789012345', '2014-09-03 16:49:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('357', '123456789012345', '2014-09-03 16:49:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('358', '123456789012345', '2014-09-03 16:50:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('359', '123456789012345', '2014-09-03 16:50:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('360', '123456789012345', '2014-09-03 16:50:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('361', '123456789012345', '2014-09-03 16:51:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('362', '123456789012345', '2014-09-03 16:51:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('363', '123456789012345', '2014-09-03 16:51:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('364', '123456789012345', '2014-09-03 16:52:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('365', '123456789012345', '2014-09-03 16:52:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('366', '123456789012345', '2014-09-03 16:52:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('367', '123456789012345', '2014-09-03 16:53:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('368', '123456789012345', '2014-09-03 16:53:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('369', '123456789012345', '2014-09-03 16:53:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('370', '123456789012345', '2014-09-03 16:54:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('371', '123456789012345', '2014-09-03 16:54:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('372', '123456789012345', '2014-09-03 16:54:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('373', '123456789012345', '2014-09-03 16:55:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('374', '123456789012345', '2014-09-03 16:55:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('375', '123456789012345', '2014-09-03 16:55:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('376', '123456789012345', '2014-09-03 16:56:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('377', '123456789012345', '2014-09-03 16:56:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('378', '123456789012345', '2014-09-03 16:56:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('379', '123456789012345', '2014-09-03 16:57:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('380', '123456789012345', '2014-09-03 16:57:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('381', '123456789012345', '2014-09-03 16:57:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('382', '123456789012345', '2014-09-03 16:58:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('383', '123456789012345', '2014-09-03 16:58:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('384', '123456789012345', '2014-09-03 16:58:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('385', '123456789012345', '2014-09-03 16:59:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('386', '123456789012345', '2014-09-03 16:59:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('387', '123456789012345', '2014-09-03 16:59:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('388', '123456789012345', '2014-09-03 17:00:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('389', '123456789012345', '2014-09-03 17:00:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('390', '123456789012345', '2014-09-03 17:00:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('391', '123456789012345', '2014-09-03 17:01:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('392', '123456789012345', '2014-09-03 17:01:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('393', '123456789012345', '2014-09-03 17:01:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('394', '123456789012345', '2014-09-03 17:02:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('395', '123456789012345', '2014-09-03 17:02:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('396', '123456789012345', '2014-09-03 17:02:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('397', '123456789012345', '2014-09-03 17:03:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('398', '123456789012345', '2014-09-03 17:03:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('399', '123456789012345', '2014-09-03 17:03:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('400', '123456789012345', '2014-09-03 17:04:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('401', '123456789012345', '2014-09-03 17:04:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('402', '123456789012345', '2014-09-03 17:04:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('403', '123456789012345', '2014-09-03 17:05:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('404', '123456789012345', '2014-09-03 17:05:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('405', '123456789012345', '2014-09-03 17:05:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('406', '123456789012345', '2014-09-03 17:06:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('407', '123456789012345', '2014-09-03 17:06:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('408', '123456789012345', '2014-09-03 17:06:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('409', '123456789012345', '2014-09-03 17:07:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('410', '123456789012345', '2014-09-03 17:07:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('411', '123456789012345', '2014-09-03 17:07:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('412', '123456789012345', '2014-09-03 17:08:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('413', '123456789012345', '2014-09-03 17:08:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('414', '123456789012345', '2014-09-03 17:08:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('415', '123456789012345', '2014-09-03 17:09:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('416', '123456789012345', '2014-09-03 17:09:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('417', '123456789012345', '2014-09-03 17:09:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('418', '123456789012345', '2014-09-03 17:10:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('419', '123456789012345', '2014-09-03 17:10:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('420', '123456789012345', '2014-09-03 17:10:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('421', '123456789012345', '2014-09-03 17:11:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('422', '123456789012345', '2014-09-03 17:11:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('423', '123456789012345', '2014-09-03 17:11:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('424', '123456789012345', '2014-09-03 17:12:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('425', '123456789012345', '2014-09-03 17:12:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('426', '123456789012345', '2014-09-03 17:12:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('427', '123456789012345', '2014-09-03 17:13:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('428', '123456789012345', '2014-09-03 17:13:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('429', '123456789012345', '2014-09-03 17:13:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('430', '123456789012345', '2014-09-03 17:14:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('431', '123456789012345', '2014-09-03 17:14:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('432', '123456789012345', '2014-09-03 17:14:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('433', '123456789012345', '2014-09-03 17:15:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('434', '123456789012345', '2014-09-03 17:15:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('435', '123456789012345', '2014-09-03 17:15:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('436', '123456789012345', '2014-09-03 17:16:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('437', '123456789012345', '2014-09-03 17:16:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('438', '123456789012345', '2014-09-03 17:16:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('439', '123456789012345', '2014-09-03 17:17:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('440', '123456789012345', '2014-09-03 17:17:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('441', '123456789012345', '2014-09-03 17:17:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('442', '123456789012345', '2014-09-03 17:18:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('443', '123456789012345', '2014-09-03 17:18:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('444', '123456789012345', '2014-09-03 17:18:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('445', '123456789012345', '2014-09-03 17:19:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('446', '123456789012345', '2014-09-03 17:19:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('447', '123456789012345', '2014-09-03 17:19:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('448', '123456789012345', '2014-09-03 17:20:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('449', '123456789012345', '2014-09-03 17:20:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('450', '123456789012345', '2014-09-03 17:20:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('451', '123456789012345', '2014-09-03 17:21:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('452', '123456789012345', '2014-09-03 17:21:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('453', '123456789012345', '2014-09-03 17:21:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('454', '123456789012345', '2014-09-03 17:22:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('455', '123456789012345', '2014-09-03 17:22:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('456', '123456789012345', '2014-09-03 17:22:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('457', '123456789012345', '2014-09-03 17:23:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('458', '123456789012345', '2014-09-03 17:23:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('459', '123456789012345', '2014-09-03 17:23:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('460', '123456789012345', '2014-09-03 17:24:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('461', '123456789012345', '2014-09-03 17:24:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('462', '123456789012345', '2014-09-03 17:24:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('463', '123456789012345', '2014-09-03 17:25:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('464', '123456789012345', '2014-09-03 17:25:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('465', '123456789012345', '2014-09-03 17:25:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('466', '123456789012345', '2014-09-03 17:26:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('467', '123456789012345', '2014-09-03 17:26:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('468', '123456789012345', '2014-09-03 17:26:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('469', '123456789012345', '2014-09-03 17:27:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('470', '123456789012345', '2014-09-03 17:27:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('471', '123456789012345', '2014-09-03 17:27:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('472', '123456789012345', '2014-09-03 17:28:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('473', '123456789012345', '2014-09-03 17:28:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('474', '123456789012345', '2014-09-03 17:28:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('475', '123456789012345', '2014-09-03 17:29:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('476', '123456789012345', '2014-09-03 17:29:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('477', '123456789012345', '2014-09-03 17:29:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('478', '123456789012345', '2014-09-03 17:30:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('479', '123456789012345', '2014-09-03 17:30:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('480', '123456789012345', '2014-09-03 17:30:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('481', '123456789012345', '2014-09-03 17:31:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('482', '123456789012345', '2014-09-03 17:31:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('483', '123456789012345', '2014-09-03 17:31:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('484', '123456789012345', '2014-09-03 17:32:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('485', '123456789012345', '2014-09-03 17:32:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('486', '123456789012345', '2014-09-03 17:32:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('487', '123456789012345', '2014-09-03 17:33:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('488', '123456789012345', '2014-09-03 17:33:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('489', '123456789012345', '2014-09-03 17:33:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('490', '123456789012345', '2014-09-03 17:34:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('491', '123456789012345', '2014-09-03 17:34:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('492', '123456789012345', '2014-09-03 17:34:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('493', '123456789012345', '2014-09-03 17:35:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('494', '123456789012345', '2014-09-03 17:35:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('495', '123456789012345', '2014-09-03 17:35:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('496', '123456789012345', '2014-09-03 17:36:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('497', '123456789012345', '2014-09-03 17:36:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('498', '123456789012345', '2014-09-03 17:36:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('499', '123456789012345', '2014-09-03 17:37:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('500', '123456789012345', '2014-09-03 17:37:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('501', '123456789012345', '2014-09-03 17:37:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('502', '123456789012345', '2014-09-03 17:38:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('503', '123456789012345', '2014-09-03 17:38:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('504', '123456789012345', '2014-09-03 17:38:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('505', '123456789012345', '2014-09-03 17:39:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('506', '123456789012345', '2014-09-03 17:39:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('507', '123456789012345', '2014-09-03 17:39:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('508', '123456789012345', '2014-09-03 17:40:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('509', '123456789012345', '2014-09-03 17:40:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('510', '123456789012345', '2014-09-03 17:40:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('511', '123456789012345', '2014-09-03 17:41:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('512', '123456789012345', '2014-09-03 17:41:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('513', '123456789012345', '2014-09-03 17:41:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('514', '123456789012345', '2014-09-03 17:42:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('515', '123456789012345', '2014-09-03 17:42:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('516', '123456789012345', '2014-09-03 17:42:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('517', '123456789012345', '2014-09-03 17:43:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('518', '123456789012345', '2014-09-03 17:43:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('519', '123456789012345', '2014-09-03 17:43:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('520', '123456789012345', '2014-09-03 17:44:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('521', '123456789012345', '2014-09-03 17:44:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('522', '123456789012345', '2014-09-03 17:44:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('523', '123456789012345', '2014-09-03 17:45:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('524', '123456789012345', '2014-09-03 17:45:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('525', '123456789012345', '2014-09-03 17:45:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('526', '123456789012345', '2014-09-03 17:46:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('527', '123456789012345', '2014-09-03 17:46:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('528', '123456789012345', '2014-09-03 17:46:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('529', '123456789012345', '2014-09-03 17:47:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('530', '123456789012345', '2014-09-03 17:47:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('531', '123456789012345', '2014-09-03 17:47:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('532', '123456789012345', '2014-09-03 17:48:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('533', '123456789012345', '2014-09-03 17:48:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('534', '123456789012345', '2014-09-03 17:48:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('535', '123456789012345', '2014-09-03 17:49:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('536', '123456789012345', '2014-09-03 17:49:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('537', '123456789012345', '2014-09-03 17:49:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('538', '123456789012345', '2014-09-03 17:50:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('539', '123456789012345', '2014-09-03 17:50:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('540', '123456789012345', '2014-09-03 17:50:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('541', '123456789012345', '2014-09-03 17:51:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('542', '123456789012345', '2014-09-03 17:51:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('543', '123456789012345', '2014-09-03 17:51:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('544', '123456789012345', '2014-09-03 17:52:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('545', '123456789012345', '2014-09-03 17:52:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('546', '123456789012345', '2014-09-03 17:52:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('547', '123456789012345', '2014-09-03 17:53:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('548', '123456789012345', '2014-09-03 17:53:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('549', '123456789012345', '2014-09-03 17:53:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('550', '123456789012345', '2014-09-03 17:54:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('551', '123456789012345', '2014-09-03 17:54:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('552', '123456789012345', '2014-09-03 17:54:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('553', '123456789012345', '2014-09-03 17:55:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('554', '123456789012345', '2014-09-03 17:55:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('555', '123456789012345', '2014-09-03 17:55:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('556', '123456789012345', '2014-09-03 17:56:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('557', '123456789012345', '2014-09-03 17:56:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('558', '123456789012345', '2014-09-03 17:56:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('559', '123456789012345', '2014-09-03 17:57:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('560', '123456789012345', '2014-09-03 17:57:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('561', '123456789012345', '2014-09-03 17:57:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('562', '123456789012345', '2014-09-03 17:58:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('563', '123456789012345', '2014-09-03 17:58:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('564', '123456789012345', '2014-09-03 17:58:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('565', '123456789012345', '2014-09-03 17:59:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('566', '123456789012345', '2014-09-03 17:59:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('567', '123456789012345', '2014-09-03 17:59:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('568', '123456789012345', '2014-09-03 18:00:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('569', '123456789012345', '2014-09-03 18:00:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('570', '123456789012345', '2014-09-03 18:00:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('571', '123456789012345', '2014-09-03 18:01:05', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('572', '123456789012345', '2014-09-03 18:01:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('573', '123456789012345', '2014-09-03 18:01:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('574', '123456789012345', '2014-09-03 18:02:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('575', '123456789012345', '2014-09-03 18:02:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('576', '123456789012345', '2014-09-03 18:02:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('577', '123456789012345', '2014-09-03 18:03:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('578', '123456789012345', '2014-09-03 18:03:25', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('579', '861311002450046', '2014-09-03 19:13:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('580', '861311002450046', '2014-09-03 19:13:50', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('581', '861311002450046', '2014-09-03 19:28:52', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('582', '861311002450046', '2014-09-03 19:29:13', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('583', '861311002450046', '2014-09-03 19:29:34', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('584', '123456789012345', '2014-09-03 19:29:39', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('585', '861311002450046', '2014-09-03 19:31:28', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('586', '861311002450046', '2014-09-03 19:31:30', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('587', '861311002450046', '2014-09-03 19:31:41', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('588', '861311002450046', '2014-09-03 19:32:02', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('589', '861311002450046', '2014-09-03 19:32:22', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('590', '861311002450046', '2014-09-03 19:32:44', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('591', '861311002450046', '2014-09-03 19:33:05', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('592', '861311002450046', '2014-09-03 19:33:26', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('593', '861311002450046', '2014-09-03 19:33:47', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('594', '861311002450046', '2014-09-03 19:34:08', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('595', '861311002450046', '2014-09-03 19:34:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('596', '861311002450046', '2014-09-03 19:34:50', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('597', '861311002450046', '2014-09-03 19:35:11', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('598', '861311002450046', '2014-09-03 19:35:32', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('599', '861311002450046', '2014-09-03 19:35:53', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('600', '861311002450046', '2014-09-03 19:36:14', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('601', '861311002450046', '2014-09-03 19:36:35', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('602', '861311002450046', '2014-09-03 19:36:56', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('603', '861311002450046', '2014-09-03 19:37:17', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('604', '861311002450046', '2014-09-03 19:37:36', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('605', '861311002450046', '2014-09-03 19:37:57', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('606', '861311002450046', '2014-09-03 19:38:53', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('607', '861311002450046', '2014-09-03 19:38:54', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('608', '861311002450046', '2014-09-03 19:39:00', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('609', '861311002450046', '2014-09-03 19:39:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('610', '861311002450046', '2014-09-03 19:42:31', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('611', '861311002450046', '2014-09-03 19:42:33', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('612', '861311002450046', '2014-09-03 19:42:51', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('613', '861311002450046', '2014-09-03 19:43:50', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('614', '861311002450046', '2014-09-03 19:43:52', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('615', '861311002450046', '2014-09-03 19:43:54', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('616', '861311002450046', '2014-09-03 19:44:16', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('617', '861311002450046', '2014-09-03 19:46:16', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('618', '861311002450046', '2014-09-03 19:46:37', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('619', '861311002450046', '2014-09-03 19:46:58', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('620', '861311002450046', '2014-09-03 19:47:19', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('621', '861311002450046', '2014-09-03 19:47:40', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('622', '861311002450046', '2014-09-03 19:48:01', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('623', '861311002450046', '2014-09-03 19:48:22', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('624', '861311002450046', '2014-09-03 19:48:45', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('625', '861311002450046', '2014-09-03 19:49:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('626', '861311002450046', '2014-09-03 19:49:25', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('627', '861311002450046', '2014-09-03 19:49:45', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('628', '861311002450046', '2014-09-03 19:50:07', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('629', '861311002450046', '2014-09-03 19:50:28', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('630', '861311002450046', '2014-09-03 19:50:49', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('631', '861311002450046', '2014-09-03 19:51:10', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('632', '861311002450046', '2014-09-03 19:51:31', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('633', '861311002450046', '2014-09-03 19:51:52', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('634', '861311002450046', '2014-09-03 19:52:13', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('635', '861311002450046', '2014-09-03 20:06:04', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('636', '861311002450046', '2014-09-03 20:06:12', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('637', '861311002450046', '2014-09-03 20:06:33', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('638', '861311002450046', '2014-09-03 20:06:54', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('639', '861311002450046', '2014-09-03 20:07:15', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('640', '861311002450046', '2014-09-03 20:11:46', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('641', '861311002450046', '2014-09-03 20:12:03', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('642', '861311002450046', '2014-09-03 20:12:28', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('643', '861311002450046', '2014-09-03 20:15:18', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('644', '861311002450046', '2014-09-03 20:15:36', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('645', '861311002450046', '2014-09-03 20:16:05', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('646', '861311002450046', '2014-09-03 20:16:30', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('647', '861311002450046', '2014-09-03 20:16:59', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('648', '861311002450046', '2014-09-03 20:17:25', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('649', '861311002450046', '2014-09-03 20:27:40', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('650', '861311002450046', '2014-09-03 20:27:52', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('651', '861311002450046', '2014-09-03 20:28:14', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('652', '861311002450046', '2014-09-03 20:28:34', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('653', '861311002450046', '2014-09-03 20:29:45', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('654', '861311002450046', '2014-09-03 20:31:20', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('655', '861311002450046', '2014-09-03 20:31:30', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('656', '861311002450046', '2014-09-03 20:31:51', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('657', '861311002450046', '2014-09-03 20:32:12', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('658', '861311002450046', '2014-09-03 20:32:34', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('659', '861311002450046', '2014-09-03 20:33:00', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('660', '861311002450046', '2014-09-03 20:33:23', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('661', '861311002450046', '2014-09-03 20:33:53', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('662', '861311002450046', '2014-09-03 20:36:48', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('663', '861311002450046', '2014-09-03 20:39:37', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('664', '861311002450046', '2014-09-03 20:39:47', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('665', '861311002450046', '2014-09-03 20:40:08', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('666', '861311002450046', '2014-09-03 20:40:29', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('667', '861311002450046', '2014-09-03 20:40:50', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('668', '861311002450046', '2014-09-03 20:41:11', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('669', '861311002450046', '2014-09-03 20:46:24', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('670', '123456789012345', '2014-09-03 20:47:41', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('671', '123456789012345', '2014-09-03 20:48:01', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('672', '123456789012345', '2014-09-03 20:48:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('673', '123456789012345', '2014-09-03 20:48:41', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('674', '123456789012345', '2014-09-03 20:49:01', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('675', '123456789012345', '2014-09-03 20:49:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('676', '123456789012345', '2014-09-03 20:49:41', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('677', '123456789012345', '2014-09-03 20:50:01', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('678', '123456789012345', '2014-09-03 20:50:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('679', '123456789012345', '2014-09-03 20:50:41', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('680', '123456789012345', '2014-09-03 20:51:01', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('681', '123456789012345', '2014-09-03 20:51:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('682', '123456789012345', '2014-09-03 20:51:41', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('683', '123456789012345', '2014-09-03 20:52:01', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('684', '123456789012345', '2014-09-03 20:52:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('685', '123456789012345', '2014-09-03 20:52:41', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('686', '123456789012345', '2014-09-03 20:53:01', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('687', '861311002450046', '2014-09-03 20:53:08', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('688', '861311002450046', '2014-09-03 20:53:10', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('689', '123456789012345', '2014-09-03 20:53:21', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('690', '861311002450046', '2014-09-03 20:53:31', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('691', '123456789012345', '2014-09-03 20:53:41', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('692', '861311002450046', '2014-09-03 20:55:10', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `t_node_state` VALUES ('837', '123456789012345', '2014-09-04 12:38:58', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('838', '123456789012345', '2014-09-04 12:39:18', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('839', '123456789012345', '2014-09-04 12:39:38', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('840', '123456789012345', '2014-09-04 12:39:58', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('841', '123456789012345', '2014-09-04 12:40:18', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('842', '123456789012345', '2014-09-04 12:40:38', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('843', '123456789012345', '2014-09-04 12:40:58', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('844', '123456789012345', '2014-09-04 12:41:18', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('845', '123456789012345', '2014-09-04 12:41:38', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('846', '123456789012345', '2014-09-04 12:41:58', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('847', '123456789012345', '2014-09-04 12:42:18', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('848', '123456789012345', '2014-09-04 12:42:38', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('849', '123456789012345', '2014-09-04 12:42:58', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('850', '123456789012345', '2014-09-04 12:43:18', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('851', '123456789012345', '2014-09-04 12:43:38', null, null, '18', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('852', '123456789012345', '2014-09-04 13:30:26', null, null, '119', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('853', '', '2014-09-04 13:32:30', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('854', '123456789012345', '2014-09-04 13:33:08', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('855', '123456789012345', '2014-09-04 13:33:28', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('856', '123456789012345', '2014-09-04 13:35:07', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('857', '123456789012345', '2014-09-04 13:35:27', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('858', '123456789012345', '2014-09-04 13:35:47', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('859', '123456789012345', '2014-09-04 13:36:07', null, null, '111', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('860', '123456789012345', '2014-09-04 13:36:27', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('861', '123456789012345', '2014-09-04 13:36:47', null, null, '114', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('862', '123456789012345', '2014-09-04 13:37:07', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('863', '123456789012345', '2014-09-04 13:37:27', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('864', '123456789012345', '2014-09-04 13:37:47', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('865', '123456789012345', '2014-09-04 13:38:07', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('866', '123456789012345', '2014-09-04 13:38:27', null, null, '114', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('867', '123456789012345', '2014-09-04 13:38:47', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('868', '123456789012345', '2014-09-04 13:39:07', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('869', '123456789012345', '2014-09-04 13:39:27', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('870', '123456789012345', '2014-09-04 13:39:47', null, null, '119', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('871', '123456789012345', '2014-09-04 13:40:07', null, null, '119', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('872', '123456789012345', '2014-09-04 13:40:27', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('873', '123456789012345', '2014-09-04 13:40:47', null, null, '111', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('874', '123456789012345', '2014-09-04 13:41:07', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('875', '123456789012345', '2014-09-04 13:41:27', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('876', '123456789012345', '2014-09-04 13:41:47', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('877', '123456789012345', '2014-09-04 13:42:07', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('878', '123456789012345', '2014-09-04 13:42:27', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('879', '123456789012345', '2014-09-04 13:42:47', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('880', '123456789012345', '2014-09-04 13:43:07', null, null, '119', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('881', '123456789012345', '2014-09-04 13:43:27', null, null, '114', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('882', '123456789012345', '2014-09-04 13:43:47', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('883', '123456789012345', '2014-09-04 13:44:07', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('884', '123456789012345', '2014-09-04 13:44:27', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('885', '123456789012345', '2014-09-04 13:44:47', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('886', '123456789012345', '2014-09-04 13:45:07', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('887', '123456789012345', '2014-09-04 13:45:27', null, null, '114', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('888', '123456789012345', '2014-09-04 13:45:47', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('889', '123456789012345', '2014-09-04 13:46:07', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('890', '123456789012345', '2014-09-04 13:46:27', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('891', '123456789012345', '2014-09-04 13:46:47', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('892', '123456789012345', '2014-09-04 13:47:07', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('893', '123456789012345', '2014-09-04 13:47:27', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('894', '123456789012345', '2014-09-04 13:47:47', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('895', '123456789012345', '2014-09-04 13:48:07', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('896', '123456789012345', '2014-09-04 13:48:27', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('897', '123456789012345', '2014-09-04 13:48:47', null, null, '111', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('898', '123456789012345', '2014-09-04 13:49:07', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('899', '123456789012345', '2014-09-04 13:49:27', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('900', '123456789012345', '2014-09-04 13:49:47', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('901', '123456789012345', '2014-09-04 13:50:07', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('902', '123456789012345', '2014-09-04 13:50:27', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('903', '123456789012345', '2014-09-04 13:50:47', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('904', '123456789012345', '2014-09-04 13:51:07', null, null, '119', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('905', '123456789012345', '2014-09-04 13:51:27', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('906', '123456789012345', '2014-09-04 13:51:47', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('907', '123456789012345', '2014-09-04 13:52:07', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('908', '123456789012345', '2014-09-04 13:52:27', null, null, '119', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('909', '123456789012345', '2014-09-04 13:52:47', null, null, '119', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('910', '123456789012345', '2014-09-04 13:53:07', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('911', '123456789012345', '2014-09-04 13:53:27', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('912', '123456789012345', '2014-09-04 13:53:47', null, null, '114', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('913', '123456789012345', '2014-09-04 13:54:07', null, null, '111', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('914', '123456789012345', '2014-09-04 13:54:27', null, null, '114', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('915', '123456789012345', '2014-09-04 13:54:47', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('916', '123456789012345', '2014-09-04 13:55:07', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('917', '123456789012345', '2014-09-04 13:55:27', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('918', '123456789012345', '2014-09-04 13:55:47', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('919', '123456789012345', '2014-09-04 13:56:07', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('920', '123456789012345', '2014-09-04 13:56:27', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('921', '123456789012345', '2014-09-04 13:56:47', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('922', '123456789012345', '2014-09-04 13:57:07', null, null, '111', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('923', '123456789012345', '2014-09-04 13:57:28', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('924', '123456789012345', '2014-09-04 13:57:47', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('925', '123456789012345', '2014-09-04 13:58:07', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('926', '123456789012345', '2014-09-04 13:58:27', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('927', '123456789012345', '2014-09-04 13:58:47', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('928', '123456789012345', '2014-09-04 13:59:07', null, null, '114', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('929', '123456789012345', '2014-09-04 13:59:27', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('930', '123456789012345', '2014-09-04 13:59:47', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('931', '123456789012345', '2014-09-04 14:00:07', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('932', '123456789012345', '2014-09-04 14:00:27', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('933', '123456789012345', '2014-09-04 14:00:47', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('934', '123456789012345', '2014-09-04 14:01:07', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('935', '123456789012345', '2014-09-04 14:01:27', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('936', '123456789012345', '2014-09-04 14:01:47', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('937', '123456789012345', '2014-09-04 14:02:07', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('938', '123456789012345', '2014-09-04 14:02:27', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('939', '123456789012345', '2014-09-04 14:02:47', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('940', '123456789012345', '2014-09-04 14:03:07', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('941', '123456789012345', '2014-09-04 14:03:27', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('942', '123456789012345', '2014-09-04 14:03:47', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('943', '123456789012345', '2014-09-04 14:04:07', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('944', '123456789012345', '2014-09-04 14:04:28', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('945', '123456789012345', '2014-09-04 14:04:47', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('946', '123456789012345', '2014-09-04 14:05:07', null, null, '111', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('947', '123456789012345', '2014-09-04 14:05:27', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('948', '123456789012345', '2014-09-04 14:05:47', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('949', '123456789012345', '2014-09-04 14:06:07', null, null, '111', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('950', '123456789012345', '2014-09-04 14:06:27', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('951', '123456789012345', '2014-09-04 14:24:39', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('952', '123456789012345', '2014-09-04 14:30:07', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('953', '861311002450046', '2014-09-04 14:56:30', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('954', '861311002450046', '2014-09-04 14:56:51', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('955', '861311002450046', '2014-09-04 14:57:12', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('956', '861311002450046', '2014-09-04 14:57:33', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('957', '861311002450046', '2014-09-04 14:57:55', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('958', '861311002450046', '2014-09-04 14:58:15', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('959', '861311002450046', '2014-09-04 14:58:37', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('960', '861311002450046', '2014-09-04 14:58:58', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('961', '861311002450046', '2014-09-04 14:59:19', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('962', '861311002450046', '2014-09-04 14:59:39', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('963', '861311002450046', '2014-09-04 15:01:12', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('964', '861311002450046', '2014-09-04 15:01:23', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('965', '861311002450046', '2014-09-04 15:01:45', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('966', '861311002450046', '2014-09-04 15:02:07', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('967', '861311002450046', '2014-09-04 15:02:28', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('968', '861311002450046', '2014-09-04 15:02:49', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('969', '861311002450046', '2014-09-04 15:03:10', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('970', '861311002450046', '2014-09-04 15:04:22', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('971', '861311002450046', '2014-09-04 15:04:43', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('972', '861311002450046', '2014-09-04 15:05:04', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('973', '861311002450046', '2014-09-04 15:05:26', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('974', '861311002450046', '2014-09-04 15:05:48', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('975', '861311002450046', '2014-09-04 15:06:07', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('976', '861311002450046', '2014-09-04 15:06:28', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('977', '861311002450046', '2014-09-04 15:06:50', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('978', '861311002450046', '2014-09-04 15:07:10', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('979', '861311002450046', '2014-09-04 15:08:00', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('980', '861311002450046', '2014-09-04 15:08:12', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('981', '861311002450046', '2014-09-04 15:08:33', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('982', '861311002450046', '2014-09-04 15:10:08', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('983', '861311002450046', '2014-09-04 15:10:18', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('984', '861311002450046', '2014-09-04 15:10:40', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('985', '861311002450046', '2014-09-04 15:11:01', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('986', '861311002450046', '2014-09-04 15:11:22', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('987', '861311002450046', '2014-09-04 15:11:43', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('988', '861311002450046', '2014-09-04 15:12:04', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('989', '861311002450046', '2014-09-04 15:12:25', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('990', '861311002450046', '2014-09-04 15:12:45', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('991', '861311002450046', '2014-09-04 15:13:08', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('992', '861311002450046', '2014-09-04 15:13:28', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('993', '861311002450046', '2014-09-04 15:13:49', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('994', '861311002450046', '2014-09-04 15:14:10', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('995', '861311002450046', '2014-09-04 15:14:32', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('996', '861311002450046', '2014-09-04 15:14:52', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('997', '861311002450046', '2014-09-04 15:15:13', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('998', '861311002450046', '2014-09-04 15:15:34', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('999', '861311002450046', '2014-09-04 15:15:55', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1000', '861311002450046', '2014-09-04 15:16:17', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1001', '861311002450046', '2014-09-04 15:17:48', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1002', '861311002450046', '2014-09-04 15:18:00', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1003', '861311002450046', '2014-09-04 15:18:22', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1004', '861311002450046', '2014-09-04 15:18:44', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1005', '861311002450046', '2014-09-04 15:19:04', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1006', '861311002450046', '2014-09-04 15:19:26', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1007', '861311002450046', '2014-09-04 15:19:46', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1008', '861311002450046', '2014-09-04 15:20:06', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1009', '861311002450046', '2014-09-04 15:20:29', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1010', '861311002450046', '2014-09-04 15:20:49', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1011', '861311002450046', '2014-09-04 15:21:10', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1012', '861311002450046', '2014-09-04 15:21:32', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1013', '861311002450046', '2014-09-04 15:21:57', null, null, '1793', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1014', '861311002450046', '2014-09-04 15:22:13', null, null, '1793', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1015', '861311002450046', '2014-09-04 15:22:34', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1016', '861311002450046', '2014-09-04 15:22:55', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1017', '861311002450046', '2014-09-04 15:23:16', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1018', '861311002450046', '2014-09-04 15:23:37', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1019', '861311002450046', '2014-09-04 15:23:59', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1020', '861311002450046', '2014-09-04 15:24:19', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1021', '861311002450046', '2014-09-04 15:24:44', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1022', '861311002450046', '2014-09-04 15:25:02', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1023', '861311002450046', '2014-09-04 17:07:38', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1024', '861311002450046', '2014-09-04 17:07:59', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1025', '861311002450046', '2014-09-04 17:08:20', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1026', '861311002450046', '2014-09-04 17:08:43', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1027', '861311002450046', '2014-09-04 17:09:03', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1028', '861311002450046', '2014-09-04 17:09:24', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1029', '861311002450046', '2014-09-04 17:09:45', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1030', '861311002450046', '2014-09-04 17:10:06', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1031', '861311002450046', '2014-09-04 17:10:27', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1032', '861311002450046', '2014-09-04 17:10:48', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1033', '861311002450046', '2014-09-04 17:11:08', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1034', '861311002450046', '2014-09-04 17:11:31', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1035', '861311002450046', '2014-09-04 17:11:52', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1036', '861311002450046', '2014-09-04 17:12:12', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1037', '861311002450046', '2014-09-04 17:12:33', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1038', '861311002450046', '2014-09-04 17:12:54', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1039', '861311002450046', '2014-09-04 17:13:17', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1040', '861311002450046', '2014-09-04 17:13:37', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1041', '861311002450046', '2014-09-04 17:13:57', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1042', '861311002450046', '2014-09-04 17:14:19', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1043', '861311002450046', '2014-09-04 17:14:39', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1044', '861311002450046', '2014-09-04 17:15:01', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1045', '861311002450046', '2014-09-04 17:15:21', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1046', '861311002450046', '2014-09-04 17:15:42', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1047', '861311002450046', '2014-09-04 17:16:03', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1048', '861311002450046', '2014-09-04 17:16:24', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1049', '861311002450046', '2014-09-04 17:16:45', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1050', '861311002450046', '2014-09-04 17:17:06', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1051', '861311002450046', '2014-09-04 17:17:51', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1052', '861311002450046', '2014-09-04 17:18:08', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1053', '861311002450046', '2014-09-04 17:18:29', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1054', '861311002450046', '2014-09-04 17:18:51', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1055', '861311002450046', '2014-09-04 17:19:13', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1056', '861311002450046', '2014-09-04 17:19:32', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1057', '861311002450046', '2014-09-04 17:19:55', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1058', '861311002450046', '2014-09-04 17:20:18', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1059', '861311002450046', '2014-09-04 17:21:05', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1060', '861311002450046', '2014-09-04 17:21:17', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1061', '861311002450046', '2014-09-04 17:21:40', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1062', '861311002450046', '2014-09-04 17:22:00', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1063', '861311002450046', '2014-09-04 17:22:21', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1064', '861311002450046', '2014-09-04 17:22:43', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1065', '861311002450046', '2014-09-04 17:23:04', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1066', '861311002450046', '2014-09-04 17:23:25', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1067', '861311002450046', '2014-09-04 17:23:46', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1068', '861311002450046', '2014-09-04 17:24:07', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1069', '861311002450046', '2014-09-04 17:24:28', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1070', '861311002450046', '2014-09-04 17:24:49', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1071', '861311002450046', '2014-09-04 17:25:10', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1072', '861311002450046', '2014-09-04 17:25:31', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1073', '861311002450046', '2014-09-04 17:25:50', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1074', '861311002450046', '2014-09-04 17:26:17', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1075', '861311002450046', '2014-09-04 17:26:34', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1076', '861311002450046', '2014-09-04 17:26:55', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1077', '861311002450046', '2014-09-04 17:27:16', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1078', '861311002450046', '2014-09-04 17:27:53', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1079', '861311002450046', '2014-09-04 17:28:27', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1080', '861311002450046', '2014-09-04 17:28:38', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1081', '861311002450046', '2014-09-04 17:29:01', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1082', '861311002450046', '2014-09-04 17:29:22', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1083', '861311002450046', '2014-09-04 17:29:43', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1084', '861311002450046', '2014-09-04 17:30:04', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1085', '861311002450046', '2014-09-04 17:30:25', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1086', '861311002450046', '2014-09-04 17:30:46', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1087', '861311002450046', '2014-09-04 17:31:07', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1088', '861311002450046', '2014-09-04 17:31:28', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1089', '861311002450046', '2014-09-04 17:31:49', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1090', '861311002450046', '2014-09-04 17:32:10', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1091', '861311002450046', '2014-09-04 17:32:31', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1092', '861311002450046', '2014-09-04 17:32:52', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1093', '861311002450046', '2014-09-04 17:33:13', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1094', '861311002450046', '2014-09-04 17:33:34', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1095', '861311002450046', '2014-09-04 17:33:55', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1096', '861311002450046', '2014-09-04 17:34:16', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1097', '861311002450046', '2014-09-04 17:34:37', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1098', '861311002450046', '2014-09-04 17:34:58', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1099', '861311002450046', '2014-09-04 17:35:20', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1100', '861311002450046', '2014-09-04 17:35:38', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1101', '861311002450046', '2014-09-04 17:36:01', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1102', '861311002450046', '2014-09-04 17:36:20', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1103', '861311002450046', '2014-09-04 17:36:41', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1104', '861311002450046', '2014-09-04 17:37:02', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1105', '861311002450046', '2014-09-04 17:37:52', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1106', '861311002450046', '2014-09-04 17:38:25', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1107', '861311002450046', '2014-09-04 17:38:49', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1108', '861311002450046', '2014-09-04 17:39:10', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1109', '861311002450046', '2014-09-04 17:39:31', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1110', '861311002450046', '2014-09-04 17:39:52', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1111', '861311002450046', '2014-09-04 17:40:13', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1112', '861311002450046', '2014-09-04 17:40:35', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1113', '861311002450046', '2014-09-04 17:40:55', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1114', '861311002450046', '2014-09-04 17:41:16', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1115', '861311002450046', '2014-09-04 17:41:37', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1116', '861311002450046', '2014-09-04 17:41:59', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1117', '861311002450046', '2014-09-04 17:42:19', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1118', '861311002450046', '2014-09-04 17:42:40', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1119', '861311002450046', '2014-09-04 17:43:01', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1120', '861311002450046', '2014-09-04 17:43:23', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1121', '861311002450046', '2014-09-04 17:43:43', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1122', '861311002450046', '2014-09-04 17:44:04', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1123', '861311002450046', '2014-09-04 17:44:25', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1124', '861311002450046', '2014-09-04 17:44:46', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1125', '861311002450046', '2014-09-04 17:45:07', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1126', '861311002450046', '2014-09-04 17:45:29', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1127', '861311002450046', '2014-09-04 17:45:49', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1128', '861311002450046', '2014-09-04 17:46:10', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1129', '861311002450046', '2014-09-04 17:46:31', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1130', '861311002450046', '2014-09-04 17:46:54', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1131', '861311002450046', '2014-09-04 17:47:13', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1132', '861311002450046', '2014-09-04 17:47:50', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1133', '861311002450046', '2014-09-04 17:47:55', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1134', '861311002450046', '2014-09-04 17:48:16', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1135', '861311002450046', '2014-09-04 17:48:39', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1136', '861311002450046', '2014-09-04 17:48:58', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1137', '861311002450046', '2014-09-04 17:49:19', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1138', '861311002450046', '2014-09-04 17:49:41', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1139', '861311002450046', '2014-09-04 17:50:02', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1140', '861311002450046', '2014-09-04 17:50:22', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1141', '861311002450046', '2014-09-04 17:50:44', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1142', '861311002450046', '2014-09-04 17:51:03', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1143', '861311002450046', '2014-09-04 17:51:25', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1144', '861311002450046', '2014-09-04 17:51:47', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1145', '861311002450046', '2014-09-04 17:52:08', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1146', '861311002450046', '2014-09-04 17:52:29', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1147', '861311002450046', '2014-09-04 17:52:52', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1148', '861311002450046', '2014-09-04 17:53:10', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1149', '861311002450046', '2014-09-04 17:53:31', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1150', '861311002450046', '2014-09-04 17:53:53', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1151', '861311002450046', '2014-09-04 17:54:13', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1152', '861311002450046', '2014-09-04 17:54:35', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1153', '861311002450046', '2014-09-04 17:54:55', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1154', '861311002450046', '2014-09-04 17:55:16', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1155', '861311002450046', '2014-09-04 17:55:36', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1156', '861311002450046', '2014-09-04 17:55:59', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1157', '861311002450046', '2014-09-04 17:56:20', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1158', '861311002450046', '2014-09-04 17:56:40', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1159', '861311002450046', '2014-09-04 17:57:01', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1160', '861311002450046', '2014-09-04 17:57:54', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1161', '861311002450046', '2014-09-04 17:58:04', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1162', '861311002450046', '2014-09-04 17:58:25', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1163', '861311002450046', '2014-09-04 17:59:08', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1164', '861311002450046', '2014-09-04 17:59:29', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1165', '861311002450046', '2014-09-04 17:59:50', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1166', '861311002450046', '2014-09-04 18:00:11', null, null, '1281', null, null, '10', '12', '0', '0');
INSERT INTO `t_node_state` VALUES ('1167', '123456789012345', '2014-09-04 21:05:11', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1168', '123456789012345', '2014-09-04 21:05:31', null, null, '119', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1169', '123456789012345', '2014-09-04 21:05:51', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1170', '123456789012345', '2014-09-04 21:06:11', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1171', '123456789012345', '2014-09-04 21:06:31', null, null, '114', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1172', '123456789012345', '2014-09-04 21:06:51', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1173', '123456789012345', '2014-09-04 21:07:11', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1174', '123456789012345', '2014-09-04 21:23:40', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1175', '123456789012345', '2014-09-04 21:24:00', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1176', '123456789012345', '2014-09-04 21:24:20', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1177', '123456789012345', '2014-09-04 21:24:40', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1178', '123456789012345', '2014-09-04 21:25:00', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1179', '123456789012345', '2014-09-04 21:27:17', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1180', '123456789012345', '2014-09-04 21:27:37', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1181', '123456789012345', '2014-09-04 21:27:57', null, null, '111', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1182', '123456789012345', '2014-09-04 21:29:48', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1183', '123456789012345', '2014-09-04 21:30:08', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1184', '123456789012345', '2014-09-04 21:30:13', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1185', '123456789012345', '2014-09-04 21:30:18', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1186', '123456789012345', '2014-09-04 21:30:23', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1187', '123456789012345', '2014-09-04 21:30:28', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1188', '123456789012345', '2014-09-04 21:30:33', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1189', '123456789012345', '2014-09-04 21:30:39', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1190', '123456789012345', '2014-09-04 21:30:44', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1191', '123456789012345', '2014-09-04 21:39:07', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1192', '123456789012345', '2014-09-04 21:39:27', null, null, '119', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1193', '123456789012345', '2014-09-04 21:45:43', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1194', '123456789012345', '2014-09-04 21:46:03', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1195', '123456789012345', '2014-09-04 21:46:23', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1196', '123456789012345', '2014-09-04 21:50:24', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1197', '123456789012345', '2014-09-04 21:53:00', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1198', '123456789012345', '2014-09-04 21:54:15', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1199', '123456789012345', '2014-09-04 21:54:35', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1200', '123456789012345', '2014-09-04 21:54:55', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1201', '123456789012345', '2014-09-04 21:55:15', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1202', '123456789012345', '2014-09-04 21:55:35', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1203', '123456789012345', '2014-09-04 21:55:55', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1204', '123456789012345', '2014-09-04 21:56:15', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1205', '123456789012345', '2014-09-04 21:56:35', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1206', '123456789012345', '2014-09-04 21:56:55', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1207', '123456789012345', '2014-09-04 21:57:15', null, null, '119', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1208', '123456789012345', '2014-09-04 21:57:35', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1209', '123456789012345', '2014-09-04 21:57:55', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1210', '123456789012345', '2014-09-04 21:58:15', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1211', '123456789012345', '2014-09-04 21:58:35', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1212', '123456789012345', '2014-09-04 21:58:55', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1213', '123456789012345', '2014-09-04 21:59:15', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1214', '123456789012345', '2014-09-04 22:00:04', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1215', '123456789012345', '2014-09-04 22:00:24', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1216', '123456789012345', '2014-09-04 22:00:44', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1217', '123456789012345', '2014-09-04 22:01:04', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1218', '123456789012345', '2014-09-04 22:01:24', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1219', '123456789012345', '2014-09-04 22:01:44', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1220', '123456789012345', '2014-09-04 22:02:04', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1221', '123456789012345', '2014-09-04 22:02:24', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1222', '123456789012345', '2014-09-04 22:02:44', null, null, '119', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1223', '123456789012345', '2014-09-04 22:03:04', null, null, '111', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1224', '123456789012345', '2014-09-04 22:03:24', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1225', '123456789012345', '2014-09-04 22:04:04', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1226', '123456789012345', '2014-09-04 22:04:24', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1227', '123456789012345', '2014-09-04 22:04:44', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1228', '123456789012345', '2014-09-04 22:05:04', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1229', '123456789012345', '2014-09-04 22:05:24', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1230', '123456789012345', '2014-09-04 22:05:44', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1231', '123456789012345', '2014-09-04 22:06:04', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1232', '123456789012345', '2014-09-04 22:06:48', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1233', '123456789012345', '2014-09-04 22:07:09', null, null, '114', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1234', '123456789012345', '2014-09-04 22:07:28', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1235', '123456789012345', '2014-09-04 22:07:48', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1236', '123456789012345', '2014-09-04 22:08:08', null, null, '119', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1237', '123456789012345', '2014-09-04 22:08:28', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1238', '123456789012345', '2014-09-04 22:08:49', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1239', '123456789012345', '2014-09-04 22:09:08', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1240', '123456789012345', '2014-09-04 22:09:28', null, null, '114', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1241', '123456789012345', '2014-09-04 22:09:48', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1242', '123456789012345', '2014-09-04 22:10:08', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1243', '123456789012345', '2014-09-04 22:10:28', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1244', '123456789012345', '2014-09-04 22:10:48', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1245', '123456789012345', '2014-09-04 22:11:08', null, null, '111', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1246', '123456789012345', '2014-09-04 22:11:28', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1247', '123456789012345', '2014-09-04 22:11:48', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1248', '123456789012345', '2014-09-04 22:12:08', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1249', '123456789012345', '2014-09-04 22:12:28', null, null, '111', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1250', '123456789012345', '2014-09-04 22:12:48', null, null, '119', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1251', '123456789012345', '2014-09-04 22:13:09', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1252', '123456789012345', '2014-09-04 22:13:29', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1253', '123456789012345', '2014-09-04 22:44:50', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1254', '123456789012345', '2014-09-04 22:45:10', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1255', '123456789012345', '2014-09-04 22:45:44', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1256', '123456789012345', '2014-09-04 22:47:08', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1257', '123456789012345', '2014-09-04 22:47:28', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1258', '123456789012345', '2014-09-04 22:47:48', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1259', '123456789012345', '2014-09-04 22:48:08', null, null, '114', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1260', '123456789012345', '2014-09-04 22:48:28', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1261', '123456789012345', '2014-09-04 22:48:48', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1262', '123456789012345', '2014-09-04 22:49:08', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1263', '123456789012345', '2014-09-04 22:49:28', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1264', '123456789012345', '2014-09-04 22:49:48', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1265', '123456789012345', '2014-09-04 22:50:08', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1266', '123456789012345', '2014-09-04 22:50:28', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1267', '123456789012345', '2014-09-04 22:50:48', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1268', '123456789012345', '2014-09-04 22:51:08', null, null, '116', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1269', '123456789012345', '2014-09-04 22:51:28', null, null, '114', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1270', '123456789012345', '2014-09-04 22:51:48', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1271', '123456789012345', '2014-09-04 22:52:08', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1272', '123456789012345', '2014-09-04 22:52:28', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1273', '123456789012345', '2014-09-04 22:52:48', null, null, '114', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1274', '123456789012345', '2014-09-04 22:53:08', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1275', '123456789012345', '2014-09-04 22:53:28', null, null, '117', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1276', '123456789012345', '2014-09-04 22:53:48', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1277', '123456789012345', '2014-09-04 22:54:08', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1278', '123456789012345', '2014-09-04 22:54:28', null, null, '111', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1279', '123456789012345', '2014-09-04 22:54:48', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1280', '123456789012345', '2014-09-04 22:55:08', null, null, '121', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1281', '123456789012345', '2014-09-04 22:55:28', null, null, '111', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1282', '123456789012345', '2014-09-04 22:55:48', null, null, '112', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1283', '123456789012345', '2014-09-04 22:56:08', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1284', '123456789012345', '2014-09-04 22:56:28', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1285', '123456789012345', '2014-09-04 22:56:48', null, null, '114', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1286', '123456789012345', '2014-09-04 22:57:08', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1287', '123456789012345', '2014-09-04 22:57:28', null, null, '115', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1288', '123456789012345', '2014-09-04 22:57:48', null, null, '118', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1289', '123456789012345', '2014-09-04 22:58:08', null, null, '113', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1290', '123456789012345', '2014-09-04 22:58:28', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1291', '123456789012345', '2014-09-05 13:07:53', null, null, '120', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1292', '123456789012345', '2014-09-05 13:08:12', null, null, '110', null, null, '17', '6', '3', '257');
INSERT INTO `t_node_state` VALUES ('1293', '123456789012345', '2014-09-05 13:08:32', null, null, '117', null, null, '17', '6', '3', '257');

-- ----------------------------
-- Table structure for `t_perm`
-- ----------------------------
DROP TABLE IF EXISTS `t_perm`;
CREATE TABLE `t_perm` (
  `pid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `uid` char(20) NOT NULL COMMENT '管理员',
  `did` int(11) NOT NULL COMMENT '区县',
  `pcheck` tinyint(2) NOT NULL COMMENT '是否可以查看',
  `pcontrol` tinyint(2) NOT NULL COMMENT '是否可控制',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_perm
-- ----------------------------
INSERT INTO `t_perm` VALUES ('15', 'test', '3', '0', '1');
INSERT INTO `t_perm` VALUES ('21', 'test3', '3', '1', '0');
INSERT INTO `t_perm` VALUES ('22', 'test3', '4', '1', '0');
INSERT INTO `t_perm` VALUES ('23', 'test3', '7', '1', '0');
INSERT INTO `t_perm` VALUES ('24', 'test3', '8', '1', '1');
INSERT INTO `t_perm` VALUES ('25', 'test3', '1', '1', '0');
INSERT INTO `t_perm` VALUES ('28', 'user001', '8', '1', '0');
INSERT INTO `t_perm` VALUES ('29', 'user001', '6', '0', '0');
INSERT INTO `t_perm` VALUES ('39', 'test', '1', '0', '1');
INSERT INTO `t_perm` VALUES ('40', 'test', '4', '0', '1');
INSERT INTO `t_perm` VALUES ('41', 'test', '5', '0', '1');

-- ----------------------------
-- Table structure for `t_province`
-- ----------------------------
DROP TABLE IF EXISTS `t_province`;
CREATE TABLE `t_province` (
  `vid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '省份ID',
  `vname` varchar(255) NOT NULL COMMENT '省份名',
  `vtime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_province
-- ----------------------------
INSERT INTO `t_province` VALUES ('1', '江苏省', '2014-08-13 21:03:23');
INSERT INTO `t_province` VALUES ('2', '安徽省', '2014-08-13 21:04:34');

-- ----------------------------
-- Table structure for `t_sys_msg`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_msg`;
CREATE TABLE `t_sys_msg` (
  `mid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统操作ID',
  `uid` char(20) NOT NULL COMMENT '短信接收者ID',
  `mtime` datetime NOT NULL COMMENT '发送时间',
  `mcontent` text NOT NULL COMMENT '短信内容',
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sys_msg
-- ----------------------------
INSERT INTO `t_sys_msg` VALUES ('1', 'user001', '2014-08-13 23:46:44', '警告：节点DRFREFWERFERFWE(nname:小粉桥旁, loc:江苏省南京市鼓楼区)药量不足！');
INSERT INTO `t_sys_msg` VALUES ('2', 'user001', '2014-08-13 23:47:23', '警告：节点DRFREFWERFERFWE(nname:小粉桥旁, loc:江苏省南京市鼓楼区)混合液不足！');
INSERT INTO `t_sys_msg` VALUES ('3', 'test', '2014-09-04 22:47:00', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('4', 'test3', '2014-09-04 22:47:00', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('5', 'test', '2014-09-04 22:47:48', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('6', 'test3', '2014-09-04 22:47:48', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('7', 'test', '2014-09-04 22:48:11', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('8', 'test3', '2014-09-04 22:48:11', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('9', 'test', '2014-09-04 22:48:14', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('10', 'test3', '2014-09-04 22:48:14', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('11', 'test', '2014-09-04 22:48:29', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('12', 'test3', '2014-09-04 22:48:29', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('13', 'test', '2014-09-04 22:48:40', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('14', 'test3', '2014-09-04 22:48:40', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('15', 'test', '2014-09-04 22:48:43', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('16', 'test3', '2014-09-04 22:48:43', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('17', 'test', '2014-09-04 22:48:44', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('18', 'test3', '2014-09-04 22:48:44', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('19', 'test', '2014-09-04 22:48:44', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('20', 'test3', '2014-09-04 22:48:44', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('21', 'test', '2014-09-04 22:50:56', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('22', 'test3', '2014-09-04 22:50:56', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('23', 'test', '2014-09-04 22:50:56', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('24', 'test3', '2014-09-04 22:50:56', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('25', 'test', '2014-09-04 22:50:57', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('26', 'test3', '2014-09-04 22:50:57', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('27', 'test', '2014-09-04 22:57:52', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('28', 'test3', '2014-09-04 22:57:52', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('29', 'user001', '2014-09-04 22:57:52', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');
INSERT INTO `t_sys_msg` VALUES ('30', 'test3', '2014-09-05 13:07:44', '警告：节点(SN=123456789012345, Loc=江苏省南京市鼓楼区)药水不足！');

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `uid` char(20) NOT NULL COMMENT '用户ID',
  `uname` varchar(255) NOT NULL COMMENT '用户昵称',
  `password` varchar(255) NOT NULL COMMENT '用户密码',
  `create_time` datetime NOT NULL COMMENT '用户被创建时间',
  `last_login` datetime DEFAULT NULL COMMENT '用户上次登录时间，未登录过为null',
  `email` varchar(255) DEFAULT NULL COMMENT '用户邮箱',
  `mobilephone` char(11) NOT NULL COMMENT '用户手机号',
  `utype` enum('3','2','1') NOT NULL DEFAULT '3' COMMENT '1-超管，2-普管，3-巡检',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('admin', '超级管理员', '123', '2014-07-26 11:01:08', '2014-09-04 23:28:26', 'sysadmin@tcs.com', '15900000000', '1');
INSERT INTO `t_user` VALUES ('test', '管理员0030', '12345', '0000-00-00 00:00:00', '2014-09-05 00:21:57', '', '15900000008', '3');
INSERT INTO `t_user` VALUES ('test3', 'test3', '123', '2014-08-16 18:24:57', null, '444@qq.com', '1590000000', '2');
INSERT INTO `t_user` VALUES ('user001', '管理员0031', '123456', '2014-08-13 23:46:00', null, 'user001@tcs.com', '15900040007', '2');

-- ----------------------------
-- View structure for `t_city_view`
-- ----------------------------
DROP VIEW IF EXISTS `t_city_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `t_city_view` AS select `t_city`.`cid` AS `cid`,`t_city`.`cname` AS `cname`,`t_city`.`vid` AS `vid`,`t_city`.`ctime` AS `ctime`,`t_province`.`vname` AS `vname` from (`t_city` join `t_province`) where (`t_city`.`vid` = `t_province`.`vid`) ;

-- ----------------------------
-- View structure for `t_district_view`
-- ----------------------------
DROP VIEW IF EXISTS `t_district_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `t_district_view` AS select `t_district`.`did` AS `did`,`t_district`.`dname` AS `dname`,`t_district`.`cid` AS `cid`,`t_district`.`dtime` AS `dtime`,`t_city`.`cname` AS `cname`,`t_province`.`vname` AS `vname` from ((`t_district` join `t_city`) join `t_province`) where ((`t_district`.`cid` = `t_city`.`cid`) and (`t_city`.`vid` = `t_province`.`vid`)) ;

-- ----------------------------
-- View structure for `t_node_op_view`
-- ----------------------------
DROP VIEW IF EXISTS `t_node_op_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `t_node_op_view` AS select `t_node_op`.`oid` AS `oid`,`t_node_op`.`nid` AS `nid`,`t_node_op`.`otype` AS `otype`,`t_node_op`.`otime` AS `otime`,`t_node_op`.`mix_scale` AS `mix_scale`,`t_node_op`.`mix_level` AS `mix_level`,`t_node_op`.`mix_freq` AS `mix_freq`,`t_node_op`.`onh3` AS `onh3`,`t_node_op`.`oh2s` AS `oh2s`,`t_node_view`.`nname` AS `nname`,concat(`t_node_view`.`vname`,`t_node_view`.`cname`,`t_node_view`.`dname`) AS `oloc` from (`t_node_op` join `t_node_view`) where (`t_node_op`.`nid` = `t_node_view`.`nid`) ;

-- ----------------------------
-- View structure for `t_node_view`
-- ----------------------------
DROP VIEW IF EXISTS `t_node_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `t_node_view` AS select `t_node`.`nid` AS `nid`,`t_node`.`baidu_id` AS `baidu_id`,`t_node`.`lng` AS `lng`,`t_node`.`lat` AS `lat`,`t_node`.`nname` AS `nname`,`t_node`.`first_access` AS `first_access`,`t_node`.`last_access` AS `last_access`,`t_node`.`nmode` AS `nmode`,`t_node`.`auto_mix_scale` AS `auto_mix_scale`,`t_node`.`auto_mix_level` AS `auto_mix_level`,`t_node`.`auto_mix_freq` AS `auto_mix_freq`,`t_node`.`did` AS `did`,`t_node`.`nnh3` AS `nnh3`,`t_node`.`nh2s` AS `nh2s`,`t_district_view`.`vname` AS `vname`,`t_district_view`.`cname` AS `cname`,`t_district_view`.`dname` AS `dname` from (`t_node` join `t_district_view`) where (`t_node`.`did` = `t_district_view`.`did`) ;

-- ----------------------------
-- View structure for `t_perm_node_view`
-- ----------------------------
DROP VIEW IF EXISTS `t_perm_node_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `t_perm_node_view` AS select `t_perm_view`.`uid` AS `uid`,`t_perm_view`.`uname` AS `uname`,`t_perm_view`.`mobilephone` AS `mobilephone`,`t_perm_view`.`did` AS `did`,`t_node`.`nid` AS `nid` from (`t_perm_view` join `t_node`) where ((`t_perm_view`.`did` = `t_node`.`did`) and (`t_perm_view`.`pcontrol` = 1)) ;

-- ----------------------------
-- View structure for `t_perm_view`
-- ----------------------------
DROP VIEW IF EXISTS `t_perm_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `t_perm_view` AS select `t_user`.`uid` AS `uid`,`t_user`.`uname` AS `uname`,`t_user`.`email` AS `email`,`t_user`.`mobilephone` AS `mobilephone`,`t_user`.`utype` AS `utype`,`t_district_view`.`did` AS `did`,concat(`t_district_view`.`vname`,`t_district_view`.`cname`,`t_district_view`.`dname`) AS `dfullname`,`t_district_view`.`cid` AS `cid`,`t_district_view`.`dtime` AS `dtime`,`t_perm`.`pcheck` AS `pcheck`,`t_perm`.`pcontrol` AS `pcontrol` from ((`t_user` join `t_district_view`) left join `t_perm` on(((`t_user`.`uid` = `t_perm`.`uid`) and (`t_district_view`.`did` = `t_perm`.`did`)))) order by `t_user`.`uid`,`t_district_view`.`vname`,`t_district_view`.`cname`,`t_district_view`.`dname` ;

-- ----------------------------
-- View structure for `t_sys_msg_view`
-- ----------------------------
DROP VIEW IF EXISTS `t_sys_msg_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `t_sys_msg_view` AS select `t_sys_msg`.`mid` AS `mid`,`t_sys_msg`.`uid` AS `uid`,`t_sys_msg`.`mtime` AS `mtime`,`t_sys_msg`.`mcontent` AS `mcontent`,`t_user`.`uname` AS `uname`,`t_user`.`utype` AS `utype`,`t_user`.`mobilephone` AS `mobilephone` from (`t_sys_msg` join `t_user`) where (`t_sys_msg`.`uid` = `t_user`.`uid`) ;
