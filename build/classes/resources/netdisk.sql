/*
 Navicat Premium Data Transfer

 Source Server         : 1024
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : netdisk

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 24/12/2019 17:38:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for diskinfo
-- ----------------------------
DROP TABLE IF EXISTS `diskinfo`;
CREATE TABLE `diskinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '云盘id',
  `disk_userid` int(11) NULL DEFAULT NULL COMMENT '所属用户',
  `total_size` bigint(20) NULL DEFAULT NULL COMMENT '总大小',
  `used_size` bigint(20) NULL DEFAULT NULL COMMENT '已使用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `disk_userid`(`disk_userid`) USING BTREE,
  CONSTRAINT `diskinfo_ibfk_1` FOREIGN KEY (`disk_userid`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diskinfo
-- ----------------------------
INSERT INTO `diskinfo` VALUES (1, 1, 1048576, 936635);
INSERT INTO `diskinfo` VALUES (9, 20, 1048576, 194382);
INSERT INTO `diskinfo` VALUES (12, 23, 1048577, 0);

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `file` varchar(8000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件保存路径',
  `filename` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_size` bigint(20) NULL DEFAULT NULL COMMENT '文件大小',
  `fileparent` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件父节点',
  `time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `filetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件类型 ',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `file_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `diskinfo` (`disk_userid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 186 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file
-- ----------------------------
INSERT INTO `file` VALUES (173, 1, 'assets\\attached\\sorray\\新建文本文档.txt', '新建文本文档.txt', 48, '0', '2019-12-23 12:47:16', 'text/plain');
INSERT INTO `file` VALUES (177, 20, 'assets\\attached\\dabao\\新建文件夹', '新建文件夹', 0, '0', '2019-12-23 13:48:54', 'folder');
INSERT INTO `file` VALUES (179, 1, 'assets\\attached\\sorray\\新建文件夹', '新建文件夹', 0, '0', '2019-12-23 14:05:40', 'folder');
INSERT INTO `file` VALUES (183, 1, 'assets\\attached\\sorray\\新建文件夹\\新建文本文档.txt', '新建文本文档.txt', 48, '179', '2019-12-23 14:46:11', 'text/plain');
INSERT INTO `file` VALUES (184, 20, 'assets\\attached\\sorray\\bootstrap.css', 'bootstrap.css', 192348, '0', '2019-12-23 15:53:17', 'text/css');
INSERT INTO `file` VALUES (185, 1, 'assets\\attached\\sorray\\新建文件夹\\bootstrap-grid.min.css', 'bootstrap-grid.min.css', 48488, '179', '2019-12-23 15:54:53', 'text/css');
INSERT INTO `file` VALUES (186, 20, 'assets\\attached\\dabao\\新建文本文档.txt', '新建文本文档.txt', 48, '0', '2019-12-24 07:49:39', 'text/plain');
INSERT INTO `file` VALUES (187, 1, 'assets\\attached\\sorray\\0', '0', 0, '0', '2019-12-24 07:54:06', 'folder');
INSERT INTO `file` VALUES (190, 1, 'assets\\attached\\sorray\\0.html', '0.html', 1986, '0', '2019-12-24 08:02:55', 'text/html');
INSERT INTO `file` VALUES (203, 20, 'assets\\attached\\sorray\\0.html', '0.html', 1986, '0', '2019-12-24 09:34:41', 'text/html');
INSERT INTO `file` VALUES (204, 1, 'assets\\attached\\sorray\\1.gif', '1.gif', 837577, '0', '2019-12-24 09:38:50', 'image/gif');
INSERT INTO `file` VALUES (205, 1, 'assets\\attached\\sorray\\学习', '学习', 0, '0', '2019-12-24 09:44:20', 'folder');
INSERT INTO `file` VALUES (206, 1, 'assets\\attached\\sorray\\bootstrap-grid.min.css', 'bootstrap-grid.min.css', 48488, '0', '2019-12-24 10:46:00', 'text/css');

-- ----------------------------
-- Table structure for share
-- ----------------------------
DROP TABLE IF EXISTS `share`;
CREATE TABLE `share`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `sharelink` varchar(800) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件链接',
  `sharecode` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提取码',
  `filename` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名',
  `time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `share_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `diskinfo` (`disk_userid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of share
-- ----------------------------
INSERT INTO `share` VALUES (10, 1, 'assets\\attached\\sorray\\0.html', 'SPEH', '0.html', '2019-12-23 13:20:35');
INSERT INTO `share` VALUES (11, 1, 'assets\\attached\\sorray\\bootstrap.css', 'S5DE', 'bootstrap.css', '2019-12-23 15:50:09');
INSERT INTO `share` VALUES (12, 1, 'assets\\attached\\sorray\\0.html', 'SBWW', '0.html', '2019-12-24 09:31:28');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `regTime` datetime(0) NULL DEFAULT NULL,
  `disk_id` int(11) NULL DEFAULT NULL,
  `disk_userid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK2hwhe8bhahd6rkufyo65e3yjw`(`disk_id`) USING BTREE,
  CONSTRAINT `FK2hwhe8bhahd6rkufyo65e3yjw` FOREIGN KEY (`disk_id`) REFERENCES `diskinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKpl7b91x47rhb4v5q0nry6l4p1` FOREIGN KEY (`disk_id`) REFERENCES `diskinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'sorray', '123', 'sorray.h@gmail.com', '2019-12-07 00:00:00', 1, NULL);
INSERT INTO `users` VALUES (20, 'dabao', '111', 'sorray.h@gmail.com', '2019-12-17 11:26:22', 9, NULL);
INSERT INTO `users` VALUES (23, 'manager', 'manager', 'sorray.h@gmail.com', '2019-12-22 20:55:21', 12, NULL);

SET FOREIGN_KEY_CHECKS = 1;
