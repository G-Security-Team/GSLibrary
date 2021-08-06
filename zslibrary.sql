/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : zslibrary

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 25/07/2021 09:27:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
BEGIN;
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (25, 'Can add article', 7, 'add_article');
INSERT INTO `auth_permission` VALUES (26, 'Can change article', 7, 'change_article');
INSERT INTO `auth_permission` VALUES (27, 'Can delete article', 7, 'delete_article');
INSERT INTO `auth_permission` VALUES (28, 'Can view article', 7, 'view_article');
INSERT INTO `auth_permission` VALUES (29, 'Can add user', 8, 'add_user');
INSERT INTO `auth_permission` VALUES (30, 'Can change user', 8, 'change_user');
INSERT INTO `auth_permission` VALUES (31, 'Can delete user', 8, 'delete_user');
INSERT INTO `auth_permission` VALUES (32, 'Can view user', 8, 'view_user');
INSERT INTO `auth_permission` VALUES (33, 'Can add classify', 9, 'add_classify');
INSERT INTO `auth_permission` VALUES (34, 'Can change classify', 9, 'change_classify');
INSERT INTO `auth_permission` VALUES (35, 'Can delete classify', 9, 'delete_classify');
INSERT INTO `auth_permission` VALUES (36, 'Can view classify', 9, 'view_classify');
INSERT INTO `auth_permission` VALUES (37, 'Can add tag', 10, 'add_tag');
INSERT INTO `auth_permission` VALUES (38, 'Can change tag', 10, 'change_tag');
INSERT INTO `auth_permission` VALUES (39, 'Can delete tag', 10, 'delete_tag');
INSERT INTO `auth_permission` VALUES (40, 'Can view tag', 10, 'view_tag');
INSERT INTO `auth_permission` VALUES (41, 'Can add update_log', 11, 'add_update_log');
INSERT INTO `auth_permission` VALUES (42, 'Can change update_log', 11, 'change_update_log');
INSERT INTO `auth_permission` VALUES (43, 'Can delete update_log', 11, 'delete_update_log');
INSERT INTO `auth_permission` VALUES (44, 'Can view update_log', 11, 'view_update_log');
INSERT INTO `auth_permission` VALUES (45, 'Can add article', 12, 'add_article');
INSERT INTO `auth_permission` VALUES (46, 'Can change article', 12, 'change_article');
INSERT INTO `auth_permission` VALUES (47, 'Can delete article', 12, 'delete_article');
INSERT INTO `auth_permission` VALUES (48, 'Can view article', 12, 'view_article');
INSERT INTO `auth_permission` VALUES (49, 'Can add tool', 13, 'add_tool');
INSERT INTO `auth_permission` VALUES (50, 'Can change tool', 13, 'change_tool');
INSERT INTO `auth_permission` VALUES (51, 'Can delete tool', 13, 'delete_tool');
INSERT INTO `auth_permission` VALUES (52, 'Can view tool', 13, 'view_tool');
INSERT INTO `auth_permission` VALUES (53, 'Can add collect', 14, 'add_collect');
INSERT INTO `auth_permission` VALUES (54, 'Can change collect', 14, 'change_collect');
INSERT INTO `auth_permission` VALUES (55, 'Can delete collect', 14, 'delete_collect');
INSERT INTO `auth_permission` VALUES (56, 'Can view collect', 14, 'view_collect');
COMMIT;

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for backadmin_article
-- ----------------------------
DROP TABLE IF EXISTS `backadmin_article`;
CREATE TABLE `backadmin_article` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of backadmin_article
-- ----------------------------
BEGIN;
INSERT INTO `backadmin_article` VALUES (1, '111111', '#11111\r\nasasdasd\r\n###qqqqq');
INSERT INTO `backadmin_article` VALUES (2, '123', '#123\r\nqqqq\r\n###wwwww');
INSERT INTO `backadmin_article` VALUES (3, '222312', '![](/media/editor/test_20201103123524488022.png)\r\n#第一\r\n##第二\r\n	aaa\r\n		aaaa');
INSERT INTO `backadmin_article` VALUES (4, '1111ddd', '```python\r\nimport requests\r\ndef start():\r\n	print(\"ls\")\r\n```');
INSERT INTO `backadmin_article` VALUES (5, '11134567', '```python\r\ndef index():\r\n	pass\r\n```\r\n\r\n![](/media/editor/test_20201113020506333316.png)\r\n\r\n');
COMMIT;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
BEGIN;
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (7, 'backadmin', 'article');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (12, 'Gr33kLibrary', 'article');
INSERT INTO `django_content_type` VALUES (9, 'Gr33kLibrary', 'classify');
INSERT INTO `django_content_type` VALUES (14, 'Gr33kLibrary', 'collect');
INSERT INTO `django_content_type` VALUES (10, 'Gr33kLibrary', 'tag');
INSERT INTO `django_content_type` VALUES (13, 'Gr33kLibrary', 'tool');
INSERT INTO `django_content_type` VALUES (11, 'Gr33kLibrary', 'update_log');
INSERT INTO `django_content_type` VALUES (8, 'Gr33kLibrary', 'user');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');
COMMIT;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
BEGIN;
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2020-11-03 12:10:15.377293');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2020-11-03 12:10:15.545860');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2020-11-03 12:10:15.587829');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2020-11-03 12:10:15.595990');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2020-11-03 12:10:15.604982');
INSERT INTO `django_migrations` VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2020-11-03 12:10:15.656311');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2020-11-03 12:10:15.681907');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0003_alter_user_email_max_length', '2020-11-03 12:10:15.702171');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0004_alter_user_username_opts', '2020-11-03 12:10:15.710614');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0005_alter_user_last_login_null', '2020-11-03 12:10:15.752818');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0006_require_contenttypes_0002', '2020-11-03 12:10:15.755539');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2020-11-03 12:10:15.764831');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0008_alter_user_username_max_length', '2020-11-03 12:10:15.801175');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2020-11-03 12:10:15.835708');
INSERT INTO `django_migrations` VALUES (15, 'sessions', '0001_initial', '2020-11-03 12:10:15.858086');
INSERT INTO `django_migrations` VALUES (16, 'backadmin', '0001_initial', '2020-11-03 12:27:39.335527');
INSERT INTO `django_migrations` VALUES (17, 'Gr33kLibrary', '0001_initial', '2020-12-15 04:36:23.086913');
INSERT INTO `django_migrations` VALUES (18, 'Gr33kLibrary', '0002_user_create_time', '2020-12-15 13:37:32.429299');
INSERT INTO `django_migrations` VALUES (19, 'Gr33kLibrary', '0003_classify_tag', '2020-12-16 14:30:54.262922');
INSERT INTO `django_migrations` VALUES (20, 'Gr33kLibrary', '0004_auto_20201216_1435', '2020-12-16 14:35:32.447241');
INSERT INTO `django_migrations` VALUES (21, 'Gr33kLibrary', '0005_update_log', '2020-12-16 15:20:33.991307');
INSERT INTO `django_migrations` VALUES (22, 'Gr33kLibrary', '0006_article', '2020-12-17 12:39:32.374550');
INSERT INTO `django_migrations` VALUES (23, 'Gr33kLibrary', '0007_article_state', '2020-12-17 12:41:31.104304');
INSERT INTO `django_migrations` VALUES (24, 'Gr33kLibrary', '0008_auto_20201217_1327', '2020-12-17 13:27:11.547183');
INSERT INTO `django_migrations` VALUES (25, 'Gr33kLibrary', '0009_tool', '2020-12-17 14:02:47.920992');
INSERT INTO `django_migrations` VALUES (26, 'Gr33kLibrary', '0010_auto_20201217_1404', '2020-12-17 14:04:39.384513');
INSERT INTO `django_migrations` VALUES (27, 'Gr33kLibrary', '0011_tool_upload_user', '2020-12-17 14:08:55.634460');
INSERT INTO `django_migrations` VALUES (28, 'Gr33kLibrary', '0012_tool_file_size', '2020-12-17 14:15:26.403617');
INSERT INTO `django_migrations` VALUES (29, 'Gr33kLibrary', '0013_auto_20201217_1417', '2020-12-17 14:17:53.725482');
INSERT INTO `django_migrations` VALUES (30, 'Gr33kLibrary', '0014_auto_20201218_1043', '2020-12-18 10:43:10.534926');
INSERT INTO `django_migrations` VALUES (31, 'Gr33kLibrary', '0015_user_invitation_num', '2020-12-18 10:57:45.262145');
INSERT INTO `django_migrations` VALUES (32, 'Gr33kLibrary', '0016_article_read_num', '2020-12-19 14:37:03.468379');
INSERT INTO `django_migrations` VALUES (33, 'Gr33kLibrary', '0017_article_back_info', '2020-12-19 15:14:54.921853');
INSERT INTO `django_migrations` VALUES (34, 'Gr33kLibrary', '0018_user_article_num', '2020-12-20 05:40:58.866002');
INSERT INTO `django_migrations` VALUES (35, 'Gr33kLibrary', '0019_article_type', '2020-12-20 06:53:12.142052');
INSERT INTO `django_migrations` VALUES (36, 'Gr33kLibrary', '0020_article_article_link', '2020-12-20 07:00:52.583127');
INSERT INTO `django_migrations` VALUES (37, 'Gr33kLibrary', '0021_auto_20201220_1506', '2020-12-20 07:06:41.128621');
INSERT INTO `django_migrations` VALUES (38, 'Gr33kLibrary', '0022_collect', '2020-12-22 01:24:28.684118');
INSERT INTO `django_migrations` VALUES (39, 'Gr33kLibrary', '0023_auto_20210717_1447', '2021-07-17 06:47:42.270304');
COMMIT;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of django_session
-- ----------------------------
BEGIN;
INSERT INTO `django_session` VALUES ('09mryrdth0253bng4uyu5xky28u6j4s0', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 10:58:00.053613');
INSERT INTO `django_session` VALUES ('0dq1ujsn39qf7w7ytvh4n1yp4dlzz6o6', 'ZjcyZGY3MDFjZTA1MGMxZDFjNTY0YWM5MjcxMzI0ZThiYjBlYWUyNzp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 10:56:38.995136');
INSERT INTO `django_session` VALUES ('0dvpce44f655rvx7j6kd7cznk5pymckk', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-03-18 12:10:59.232439');
INSERT INTO `django_session` VALUES ('0n5erwfx0ni5z7lli7y3i424ikn117ih', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-28 07:36:41.337774');
INSERT INTO `django_session` VALUES ('0ovmkgzvjc0uhwdf6i4f6pkich4tomkr', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-15 16:38:06.468555');
INSERT INTO `django_session` VALUES ('0yzj23dhofd9norefagzeyyzwb4683yj', 'ZGIwYmI4YTZlNTdjOTljNzI4ZDIzOTkxMWNjOTU5NTFjMjc0ZWViNjp7InVzZXIiOjE1LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-20 13:24:55.828732');
INSERT INTO `django_session` VALUES ('0zt4bjr8trvvtpz4bhuc92ci4hk2n28x', 'ZTM5OWQwZjFiNzM5YjJhYTU3YzI1MTcxYTNlY2I1Yjk1MzA3YTNjZDp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-05 16:11:48.054000');
INSERT INTO `django_session` VALUES ('11sasph0cfwojc8iwpez70klosrhrrob', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 10:21:13.132123');
INSERT INTO `django_session` VALUES ('1cyvzxxqiskho1pgsitlma3tz449pytx', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-06 23:44:13.723226');
INSERT INTO `django_session` VALUES ('1mgtwx0zj7lwn4qsolnwjq1gjybchkvz', 'NGQ1ZDUxMTE2MzdlZmExN2NlOTAxNGJhNTVkODFiMDU4OWYwYzJkYzp7InVzZXIiOjQwLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 11:35:52.718972');
INSERT INTO `django_session` VALUES ('1zz4qokn892zcg9jv794nx2khf9km7e9', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 09:44:21.824118');
INSERT INTO `django_session` VALUES ('206o897nzj118zc7wijcg5qm21suxbtg', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 03:09:56.264622');
INSERT INTO `django_session` VALUES ('23iofv95bkg3gzxjlk3u09j7u7dtfeqz', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-28 09:40:47.391900');
INSERT INTO `django_session` VALUES ('26j5wfgkq4vkt5fphiiqcr63x4zxp0zo', 'YWFkNTRmYjM3N2NhYjdlNTIwYmUxMzNkMzJkZWIzMDU4MjQxOWY5NDp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2020-12-30 16:21:37.882058');
INSERT INTO `django_session` VALUES ('2oaz7ybgqrvgwyjgesu58y4zcjcxhp4j', 'MDVmZDk3ZDZmODk1YTRmN2EyNGI0NGI1MjQxYzMyMWRmYjUyYzZiNzp7InVzZXIiOjQxLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 10:34:24.370526');
INSERT INTO `django_session` VALUES ('37uu5rv6aptwvozp2o943mx6h878ojhz', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-05 12:55:46.385248');
INSERT INTO `django_session` VALUES ('3a5ifmdk3aaf82mi1mgm5jrc9iqalukh', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 08:40:45.564909');
INSERT INTO `django_session` VALUES ('3a8h8em29vta8qaqtmnfkyvgvnjxrr5x', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-18 15:16:27.564825');
INSERT INTO `django_session` VALUES ('3bt9s2krma0urt21vc5tysd043ikpw3v', 'ZTM5OWQwZjFiNzM5YjJhYTU3YzI1MTcxYTNlY2I1Yjk1MzA3YTNjZDp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2020-12-31 17:36:25.019048');
INSERT INTO `django_session` VALUES ('3gv4s4f746orxn9kbktgwt7w2zr5k5zx', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-16 13:33:16.387955');
INSERT INTO `django_session` VALUES ('3s5w2ja5jro0k9juzrp26grkcljvyrv6', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 02:49:58.444076');
INSERT INTO `django_session` VALUES ('3uwr0a93fh80fo1jzd2az2prjvmk0jld', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 16:48:55.955511');
INSERT INTO `django_session` VALUES ('436vri3yo15ls8sccy403yfxta91gaix', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 04:00:15.201575');
INSERT INTO `django_session` VALUES ('441vxwutt130egk8huoovrjl9n97u89y', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 02:55:44.121092');
INSERT INTO `django_session` VALUES ('4dadv5j96d1omhtr635bd29xbqf1t5ww', 'N2EzMzRhNDIzNDVhMmQ3OGE1OTkwZTk4YzkxMjg1ZWU0ZThiYjYwYTp7InVzZXIiOjQyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 09:22:58.096988');
INSERT INTO `django_session` VALUES ('4j1a1uvwmvcl3gpdrasebt63m7kc3ueg', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-19 00:33:07.406438');
INSERT INTO `django_session` VALUES ('4s3mqzqf5fjldih1kzn0ej1a44g6pcht', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 09:07:18.209043');
INSERT INTO `django_session` VALUES ('59dkcgtjcum9qu8b1lzs8mcb8x4sy8s3', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 10:20:51.951355');
INSERT INTO `django_session` VALUES ('5r8y8ip3lts8avgdve3s8rnyem8sfobf', 'MTNhZTcyYWJhNjQxMDg0ZTQxOTFkOTU4ODk3MTYwNjdmNGYwYjdiMTp7InVzZXIiOjM5LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 10:21:49.669621');
INSERT INTO `django_session` VALUES ('5vbm71y7mrm5r9dfgrbvy59hzjo2qn24', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2020-12-31 17:57:23.308187');
INSERT INTO `django_session` VALUES ('65nbpen5liwjiidek63cg82h7i2nec20', 'MTNhZTcyYWJhNjQxMDg0ZTQxOTFkOTU4ODk3MTYwNjdmNGYwYjdiMTp7InVzZXIiOjM5LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 04:50:23.170687');
INSERT INTO `django_session` VALUES ('670v1qox0vahszmxf24ihip2vgfsqog4', 'ZTM5OWQwZjFiNzM5YjJhYTU3YzI1MTcxYTNlY2I1Yjk1MzA3YTNjZDp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-05 14:33:29.340531');
INSERT INTO `django_session` VALUES ('6aira0p31uw2xfn0zkgr9lxr744m77wk', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 09:56:30.541222');
INSERT INTO `django_session` VALUES ('6b8hovfwikvs2i95ws1p12pj6b9c2837', 'ZjcyZGY3MDFjZTA1MGMxZDFjNTY0YWM5MjcxMzI0ZThiYjBlYWUyNzp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 03:18:56.980241');
INSERT INTO `django_session` VALUES ('6kdmu3nxh9hbtfsimczp8f67vs23cg5k', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-19 17:49:27.332255');
INSERT INTO `django_session` VALUES ('6qz9w8pyzpcazye8a519y8tibiy9x0a2', 'ZjcyZGY3MDFjZTA1MGMxZDFjNTY0YWM5MjcxMzI0ZThiYjBlYWUyNzp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 09:40:23.932126');
INSERT INTO `django_session` VALUES ('6zefriobwusf5fhpncn1f26c8p1n7cnv', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 02:24:42.567872');
INSERT INTO `django_session` VALUES ('72assbwzwx5lwuacte665xkobm20oao3', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 03:55:25.197040');
INSERT INTO `django_session` VALUES ('75v1g5kymry2dsoocypyjjf104jxx2bp', 'YmFkNWU1YmE4MTE1MjllOGQxMGE5M2U3MTA3OGEwNWNjZDFlMzJjMjp7InVzZXIiOjE0LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-18 11:08:32.178888');
INSERT INTO `django_session` VALUES ('79ttk1ar9pgloxkm8n6za8svy85gb26l', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2020-12-30 17:05:49.786683');
INSERT INTO `django_session` VALUES ('7bknjcgoo5d2zha8fhsbxm4rh6c63vrz', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 09:39:21.680590');
INSERT INTO `django_session` VALUES ('7d1s96649n4sympuo0voxyarpvi2yyw1', 'MDVmZDk3ZDZmODk1YTRmN2EyNGI0NGI1MjQxYzMyMWRmYjUyYzZiNzp7InVzZXIiOjQxLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-30 03:33:32.485777');
INSERT INTO `django_session` VALUES ('7hx0bj33z4sjuknuq6ny57tquqi3nooi', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 10:29:25.834230');
INSERT INTO `django_session` VALUES ('7i01bhzb2jlc6lgymm9pwm39fjltd3o2', 'NGQ1ZDUxMTE2MzdlZmExN2NlOTAxNGJhNTVkODFiMDU4OWYwYzJkYzp7InVzZXIiOjQwLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 03:20:29.642089');
INSERT INTO `django_session` VALUES ('7jq3pfvu9kpttdh85jfqzi779g16xgcb', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-20 06:14:25.544876');
INSERT INTO `django_session` VALUES ('7p8u6l13sqnb4i3dhpi4hqdzntjdxx6k', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 14:45:16.538680');
INSERT INTO `django_session` VALUES ('84xaww1v0ebo7vmrj9z0i2v6opza8ps7', 'ZjcyZGY3MDFjZTA1MGMxZDFjNTY0YWM5MjcxMzI0ZThiYjBlYWUyNzp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-30 03:08:31.686189');
INSERT INTO `django_session` VALUES ('8boyfuisn13b5u37bihdwltxo24xj6dh', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 03:20:32.211507');
INSERT INTO `django_session` VALUES ('8bx5e4xxurzyoukqh1icxf3jnc283jvr', 'YWFkNTRmYjM3N2NhYjdlNTIwYmUxMzNkMzJkZWIzMDU4MjQxOWY5NDp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2020-12-30 14:18:37.063821');
INSERT INTO `django_session` VALUES ('8gynlv43wpob71nuzik2w9gpwoq4brdm', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 09:30:00.608944');
INSERT INTO `django_session` VALUES ('8hzipkxl2qkadk8jd7c49a90iu9n9pjv', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-30 03:23:12.071514');
INSERT INTO `django_session` VALUES ('8iukmyybum724gu4k8ttrguyfsiwloj5', 'N2EzMzRhNDIzNDVhMmQ3OGE1OTkwZTk4YzkxMjg1ZWU0ZThiYjYwYTp7InVzZXIiOjQyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 03:01:19.059939');
INSERT INTO `django_session` VALUES ('8jj37xvrrebcysysmubo11wgo1s4nyzu', 'YWFkNTRmYjM3N2NhYjdlNTIwYmUxMzNkMzJkZWIzMDU4MjQxOWY5NDp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-15 16:35:54.380255');
INSERT INTO `django_session` VALUES ('8nakdibi2n13jultylu8fpw3qjl77a18', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-30 04:24:34.293278');
INSERT INTO `django_session` VALUES ('8tw5abzu2cranpybjxm5ve2rj5gx8v6v', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 10:45:05.771665');
INSERT INTO `django_session` VALUES ('91x94sjro4wji7qdfiu7vfe342xeiwuh', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-20 07:46:29.499428');
INSERT INTO `django_session` VALUES ('9qbc89di9izgjeq49r3al9rh43o16x8u', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-30 04:00:52.868581');
INSERT INTO `django_session` VALUES ('9tgoyp5ikqwplajwzn3wwutgwtw3eu3e', 'NGQ1ZDUxMTE2MzdlZmExN2NlOTAxNGJhNTVkODFiMDU4OWYwYzJkYzp7InVzZXIiOjQwLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 07:52:10.591449');
INSERT INTO `django_session` VALUES ('9vgqnwlccg0ecq9pr4z1c49w9n6vvkvv', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-20 19:04:36.459148');
INSERT INTO `django_session` VALUES ('9vkf8u1yio5qc1bk52rc30q5cw6fz8gb', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-03-12 19:16:55.259852');
INSERT INTO `django_session` VALUES ('aa2sqws7wveebeiai1a9n7ook6ga8u05', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 03:57:19.232097');
INSERT INTO `django_session` VALUES ('ab67yahtjzkvw37wxxpyht6eepxw88fc', 'NGQ1ZDUxMTE2MzdlZmExN2NlOTAxNGJhNTVkODFiMDU4OWYwYzJkYzp7InVzZXIiOjQwLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 03:15:38.006148');
INSERT INTO `django_session` VALUES ('ac6tpzm6ywr5fr8mum9l3f1u4r2yz86h', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 02:17:50.967787');
INSERT INTO `django_session` VALUES ('agdn4s742qv46cwm0h194sxl1p9uz684', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-19 13:34:29.227483');
INSERT INTO `django_session` VALUES ('antvxin2q4zwfj65i6hyw7zw69dg7lr5', 'NGQ1ZDUxMTE2MzdlZmExN2NlOTAxNGJhNTVkODFiMDU4OWYwYzJkYzp7InVzZXIiOjQwLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 08:55:35.760898');
INSERT INTO `django_session` VALUES ('aovsw47vqompr712uw1b473vzoaxcrd9', 'N2EzMzRhNDIzNDVhMmQ3OGE1OTkwZTk4YzkxMjg1ZWU0ZThiYjYwYTp7InVzZXIiOjQyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 10:40:53.490165');
INSERT INTO `django_session` VALUES ('aqelg5ce7pj9updregumaj69x49mehfp', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 03:18:23.909433');
INSERT INTO `django_session` VALUES ('ar2xoq2d5gpu6ehnmnzijxf9zoz3f3e1', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-15 16:26:50.789242');
INSERT INTO `django_session` VALUES ('arkgrrbhow31fc6o6lgoon411zsd1bd2', 'MTNhZTcyYWJhNjQxMDg0ZTQxOTFkOTU4ODk3MTYwNjdmNGYwYjdiMTp7InVzZXIiOjM5LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 02:18:05.851647');
INSERT INTO `django_session` VALUES ('b44chhi1mmgmfamnf1az8x0b83ozsd4b', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-06 23:54:05.598420');
INSERT INTO `django_session` VALUES ('b4mmlr4qfoyxow2ca06s7f8yr7ypty6s', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 02:59:45.272965');
INSERT INTO `django_session` VALUES ('biegi6sbfo5a2w23cpc8hy5gvj34y9sf', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 10:06:18.522647');
INSERT INTO `django_session` VALUES ('bnsnlncea4nfn8gon6vtuhavr3y0ro40', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 03:38:46.520905');
INSERT INTO `django_session` VALUES ('botheogq7x219jukrc3cqmc7xqyk0q2s', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 03:38:59.601990');
INSERT INTO `django_session` VALUES ('bux4mhjvj4up6swogzj1vpthb559raem', 'MTNhZTcyYWJhNjQxMDg0ZTQxOTFkOTU4ODk3MTYwNjdmNGYwYjdiMTp7InVzZXIiOjM5LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 09:30:45.985178');
INSERT INTO `django_session` VALUES ('by5msex93ncouxsik4vxcc9wgrizykxl', 'NGQ1ZDUxMTE2MzdlZmExN2NlOTAxNGJhNTVkODFiMDU4OWYwYzJkYzp7InVzZXIiOjQwLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 03:00:30.300723');
INSERT INTO `django_session` VALUES ('c01tj66f6njg6c7ukp3jx84tdlunsoxn', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 09:27:58.663151');
INSERT INTO `django_session` VALUES ('cof20a4hk42syqpgx37cww3ew6yiq4w2', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-28 07:35:30.653809');
INSERT INTO `django_session` VALUES ('dbdgew4ph6ytuyelrcbzfcc0mehcszfm', 'ZTM5OWQwZjFiNzM5YjJhYTU3YzI1MTcxYTNlY2I1Yjk1MzA3YTNjZDp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-15 16:32:40.434731');
INSERT INTO `django_session` VALUES ('dchfwknxmbxb4rd9don87euszf5j7f9t', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 02:21:18.201983');
INSERT INTO `django_session` VALUES ('dszruta7ltuv0kawvay5uowppvqej33o', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 02:09:03.114282');
INSERT INTO `django_session` VALUES ('e8czffc4czdvedobja8f9v27hbehep3w', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-05 16:35:38.311679');
INSERT INTO `django_session` VALUES ('ejrgs5cfxsj0luouhj2r8s12qo9dfhjq', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 03:17:48.622765');
INSERT INTO `django_session` VALUES ('eneon0yekc6f2vsempfvxc9wgbha8x2x', 'Njk3NjRhOWNhNWM0ZmRjYjVhOTAzMTc0ZjY4Y2YzZWU4YTdhMWY5Yzp7InVzZXIiOjQ1LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-05 16:18:13.918824');
INSERT INTO `django_session` VALUES ('enqyuwob9ffkkrk8g296hyegodttj8br', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-28 08:12:24.277253');
INSERT INTO `django_session` VALUES ('euwi1k4q2k0622yf3bsjfn6mzb01m4sg', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 11:20:28.550219');
INSERT INTO `django_session` VALUES ('f1igk5okergi96oadpzxe7irv3m03821', 'NGQ1ZDUxMTE2MzdlZmExN2NlOTAxNGJhNTVkODFiMDU4OWYwYzJkYzp7InVzZXIiOjQwLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-28 07:36:57.530991');
INSERT INTO `django_session` VALUES ('fi3gla97vxr8564ndr9w4zlcth93jazm', 'NGQ1ZDUxMTE2MzdlZmExN2NlOTAxNGJhNTVkODFiMDU4OWYwYzJkYzp7InVzZXIiOjQwLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 10:28:00.690866');
INSERT INTO `django_session` VALUES ('fxcqmvce9wzwnoebtkcg9eugzedv8ewz', 'NGQ1ZDUxMTE2MzdlZmExN2NlOTAxNGJhNTVkODFiMDU4OWYwYzJkYzp7InVzZXIiOjQwLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 10:29:10.594955');
INSERT INTO `django_session` VALUES ('fz17ptg9x1kr5de97icn9c3ehe4bzkzd', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-24 08:12:37.831808');
INSERT INTO `django_session` VALUES ('g1jyt9d98xby8vtghd1t3slstwf2kwj7', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 04:59:36.070908');
INSERT INTO `django_session` VALUES ('g44r0qwfv7lh2j1xy72gafapqz0tu1sp', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-19 17:37:03.251820');
INSERT INTO `django_session` VALUES ('ghyf82pyojwb00qdgyqj5sr1lr64t5uv', 'NGQ1ZDUxMTE2MzdlZmExN2NlOTAxNGJhNTVkODFiMDU4OWYwYzJkYzp7InVzZXIiOjQwLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 02:20:39.240016');
INSERT INTO `django_session` VALUES ('h1rbazqld9esiblpwyxj0xtkymr9dovj', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 14:00:27.715743');
INSERT INTO `django_session` VALUES ('hcka6ryg4o4gpwvp6qtek2vj8f3k5ddw', 'MDVmZDk3ZDZmODk1YTRmN2EyNGI0NGI1MjQxYzMyMWRmYjUyYzZiNzp7InVzZXIiOjQxLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-30 05:17:44.785091');
INSERT INTO `django_session` VALUES ('hls6afwh6wa5k8n3ymgjyqy8fvqmeupi', 'MTNhZTcyYWJhNjQxMDg0ZTQxOTFkOTU4ODk3MTYwNjdmNGYwYjdiMTp7InVzZXIiOjM5LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 11:05:20.071582');
INSERT INTO `django_session` VALUES ('hnlr2to7hpd1lckylnaie0clyrpuav0o', 'MDVmZDk3ZDZmODk1YTRmN2EyNGI0NGI1MjQxYzMyMWRmYjUyYzZiNzp7InVzZXIiOjQxLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 03:24:17.134768');
INSERT INTO `django_session` VALUES ('i2aidmqyuxl7vk0ph0rwid1g913dk19c', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-08 11:14:45.622160');
INSERT INTO `django_session` VALUES ('idxjal3hajvjz4nz7fxgtw1ub9iwaxws', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 11:31:50.723734');
INSERT INTO `django_session` VALUES ('j084v13vacplhnwm8l7m5e4sm8jdsakq', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-30 03:53:39.182884');
INSERT INTO `django_session` VALUES ('jce2brey6q286763xi8w6u8kwug41awl', 'NGQ1ZDUxMTE2MzdlZmExN2NlOTAxNGJhNTVkODFiMDU4OWYwYzJkYzp7InVzZXIiOjQwLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 02:23:33.008133');
INSERT INTO `django_session` VALUES ('js72mxx6r2knrnkfso1d8zq5p32wiw4m', 'MDc0YmE2OTdlZDgyZTJjNjgyYTYyOWU1YWU3MTdiNmQ3YjUwYzRhZjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-05 15:37:25.454601');
INSERT INTO `django_session` VALUES ('jtzrbjtq8vooshpzmbigs57kk7ojw4ae', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-05 16:39:57.870593');
INSERT INTO `django_session` VALUES ('jwch5wx2lnwcr9uoi5u4rb75grzz51qw', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 02:16:51.166220');
INSERT INTO `django_session` VALUES ('jzygcw3ykzsr14j0p7tue8cmo3pp1gwb', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-20 02:32:18.552054');
INSERT INTO `django_session` VALUES ('k1gsbulzlng6zjee2bicrzdpodgiudjk', 'ZjcyZGY3MDFjZTA1MGMxZDFjNTY0YWM5MjcxMzI0ZThiYjBlYWUyNzp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 03:16:16.389183');
INSERT INTO `django_session` VALUES ('k3jg509bhh8p6qgmqda9cgv9kljmr9ri', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 12:29:15.070864');
INSERT INTO `django_session` VALUES ('k5y49ytncibvijhahhsi83mndhlg6zfg', 'NmIxODUyNDA3NmNmZDY5YzU5ODQxOTlhZmRhMjRhZDZkMDJkZDZmOTp7InVzZXIiOjM5LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2020-12-31 17:41:39.593755');
INSERT INTO `django_session` VALUES ('k9ksg4etzofpo8ebc9hcrk6aueai9dt2', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 09:31:34.448659');
INSERT INTO `django_session` VALUES ('kbt1131m5qcbkabnzomgp2vshs16jxhj', 'ZjcyZGY3MDFjZTA1MGMxZDFjNTY0YWM5MjcxMzI0ZThiYjBlYWUyNzp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 10:41:18.732277');
INSERT INTO `django_session` VALUES ('keowp2cdwbcqf5u0hgauqiimiq9x16cb', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-19 13:13:07.393650');
INSERT INTO `django_session` VALUES ('khhls8zg4q7o2mzb2tskk7bp0ihtldhb', 'ZGIwYmI4YTZlNTdjOTljNzI4ZDIzOTkxMWNjOTU5NTFjMjc0ZWViNjp7InVzZXIiOjE1LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-19 11:08:16.168311');
INSERT INTO `django_session` VALUES ('l6vc019bxxxg2y0tdd1u5hp4s9ho2y9g', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-28 09:48:10.899341');
INSERT INTO `django_session` VALUES ('l9ebi5i6e5swf1ks49r4qvg5bwkr8tco', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 02:26:12.920257');
INSERT INTO `django_session` VALUES ('l9w8ook6smgtzlfkb3r9gdi8a6gu57pq', 'ZjcyZGY3MDFjZTA1MGMxZDFjNTY0YWM5MjcxMzI0ZThiYjBlYWUyNzp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-30 04:13:31.968251');
INSERT INTO `django_session` VALUES ('lhfc51xg2yyj483nruxp18cx1yllw4nb', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-20 14:25:09.234440');
INSERT INTO `django_session` VALUES ('lpdr35zjqg9n851t34j9jy7n5yfq395p', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-21 11:46:58.457364');
INSERT INTO `django_session` VALUES ('lrpmf3etfoqtznbbgwmm2yge2vtkki6f', 'ZjcyZGY3MDFjZTA1MGMxZDFjNTY0YWM5MjcxMzI0ZThiYjBlYWUyNzp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 02:59:45.261309');
INSERT INTO `django_session` VALUES ('ltgom38tnejstsngohd8701mmqoj5yc8', 'ZjcyZGY3MDFjZTA1MGMxZDFjNTY0YWM5MjcxMzI0ZThiYjBlYWUyNzp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-28 08:36:43.340976');
INSERT INTO `django_session` VALUES ('ltzw26sfz6h6l8tj6u47wse5i9dasttq', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 07:52:37.600216');
INSERT INTO `django_session` VALUES ('lxws9vd0mym7ubj50zx0pcpvb7z5df0r', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-20 07:36:09.515918');
INSERT INTO `django_session` VALUES ('m0csbm18dxkt2wjczv5exgr8k5olgvmp', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 10:42:37.193726');
INSERT INTO `django_session` VALUES ('m5p9ugxd4pir32878xrv6yrg94i6wj6x', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 02:23:26.942671');
INSERT INTO `django_session` VALUES ('mh9g8t7mf6jyt4cnnukxtaqp9dilf2am', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 14:44:36.891295');
INSERT INTO `django_session` VALUES ('mhlhp674rw4mw4uswru17ida47n4u4a8', 'MTNhZTcyYWJhNjQxMDg0ZTQxOTFkOTU4ODk3MTYwNjdmNGYwYjdiMTp7InVzZXIiOjM5LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 03:00:21.899541');
INSERT INTO `django_session` VALUES ('mnetpdinq3olqfe123ys98hsxgy8mwhu', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-06 23:43:52.462025');
INSERT INTO `django_session` VALUES ('n28tz2g4m5b01n0tmyb8c347qoi2frd3', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-14 11:49:42.917389');
INSERT INTO `django_session` VALUES ('n41kldioxxq7zy0rhdryuda16miv3tp5', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-18 10:41:32.519402');
INSERT INTO `django_session` VALUES ('nae7j40lo5ugvlmnkbk750cnr8524m5i', 'ZGIwYmI4YTZlNTdjOTljNzI4ZDIzOTkxMWNjOTU5NTFjMjc0ZWViNjp7InVzZXIiOjE1LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-19 11:53:15.251804');
INSERT INTO `django_session` VALUES ('nk8gzopjhdul15bphgt6wct3q3pz1c1w', 'MDVmZDk3ZDZmODk1YTRmN2EyNGI0NGI1MjQxYzMyMWRmYjUyYzZiNzp7InVzZXIiOjQxLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 09:28:12.594666');
INSERT INTO `django_session` VALUES ('nvsqmgguiy5oyqxrb862l5gh5hpn50gh', 'Njk3NjRhOWNhNWM0ZmRjYjVhOTAzMTc0ZjY4Y2YzZWU4YTdhMWY5Yzp7InVzZXIiOjQ1LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-05 12:59:54.470985');
INSERT INTO `django_session` VALUES ('o6rfoddxubctpb5b013ef8hdej3wcw44', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 03:02:07.194700');
INSERT INTO `django_session` VALUES ('odq2uq6zqr9o8qv1vkan4sinlt1yjc1v', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 03:17:55.621069');
INSERT INTO `django_session` VALUES ('opa6una7dq8km9qe0cwe9482jdt1frw4', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-20 16:17:29.125052');
INSERT INTO `django_session` VALUES ('pj4zwnqfytxuc1cplrw37pqadswhn5ty', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-07 08:05:13.592417');
INSERT INTO `django_session` VALUES ('pl0jkad7u7ou6wekeawz56o0f64m2kaz', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-20 07:31:44.044150');
INSERT INTO `django_session` VALUES ('po7o0aucobldhxg3g6bx4tw761vji1sh', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-22 18:51:19.388765');
INSERT INTO `django_session` VALUES ('q74i28s2jgcc3w3am3ekw8rlzb0h0xs4', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-30 02:59:23.393575');
INSERT INTO `django_session` VALUES ('qcyfjmgqypiccwy4v3jwqsbcfx5ccy1y', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-21 22:08:54.198428');
INSERT INTO `django_session` VALUES ('qge76v2sakittndewjnpgvjg54g459d8', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-15 20:28:15.377676');
INSERT INTO `django_session` VALUES ('qiady3ufxwqao68j643xgj6666m5w0b4', 'MTNhZTcyYWJhNjQxMDg0ZTQxOTFkOTU4ODk3MTYwNjdmNGYwYjdiMTp7InVzZXIiOjM5LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 10:30:24.848070');
INSERT INTO `django_session` VALUES ('qr65tpsly6s5371zerecql9j5vn87oa0', 'MTNhZTcyYWJhNjQxMDg0ZTQxOTFkOTU4ODk3MTYwNjdmNGYwYjdiMTp7InVzZXIiOjM5LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 04:12:21.562790');
INSERT INTO `django_session` VALUES ('qrz620u8uh0d9n9k1j43bpw1oeog6vu5', 'N2EzMzRhNDIzNDVhMmQ3OGE1OTkwZTk4YzkxMjg1ZWU0ZThiYjYwYTp7InVzZXIiOjQyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 02:23:10.539343');
INSERT INTO `django_session` VALUES ('qz67bi0god2n2djq3lt4bkamq03lo8oi', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 10:59:37.711174');
INSERT INTO `django_session` VALUES ('rb3khmrz890ve6u6d5qqz1lqn67nak1p', 'N2EzMzRhNDIzNDVhMmQ3OGE1OTkwZTk4YzkxMjg1ZWU0ZThiYjYwYTp7InVzZXIiOjQyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 02:56:43.960656');
INSERT INTO `django_session` VALUES ('rysm28xomfix594xi1lumstoexjsuci1', 'ZjcyZGY3MDFjZTA1MGMxZDFjNTY0YWM5MjcxMzI0ZThiYjBlYWUyNzp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 02:30:37.446865');
INSERT INTO `django_session` VALUES ('s15kktoe7fnql58q2havzkba1yhoxulz', 'ZjcyZGY3MDFjZTA1MGMxZDFjNTY0YWM5MjcxMzI0ZThiYjBlYWUyNzp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 04:16:27.834393');
INSERT INTO `django_session` VALUES ('s77scgsbgyewe34gnkn05vdejekd5xn8', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-20 13:19:57.844340');
INSERT INTO `django_session` VALUES ('sq835o57hd26fyvdefd26fewybj9i1l2', 'Njk3NjRhOWNhNWM0ZmRjYjVhOTAzMTc0ZjY4Y2YzZWU4YTdhMWY5Yzp7InVzZXIiOjQ1LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-15 16:43:07.624613');
INSERT INTO `django_session` VALUES ('t0rl81akb5jtfeme0289crc7dei9acu5', 'Njk3NjRhOWNhNWM0ZmRjYjVhOTAzMTc0ZjY4Y2YzZWU4YTdhMWY5Yzp7InVzZXIiOjQ1LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-12 11:35:21.209632');
INSERT INTO `django_session` VALUES ('te6pv3dnv9l23yhhtu789f348cm3yz1s', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 09:27:56.114377');
INSERT INTO `django_session` VALUES ('tesplztiv30wretofiqkgzcodt5rm72a', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-19 10:36:26.957180');
INSERT INTO `django_session` VALUES ('tq6wkrwemtma9k3m9m6vz43q8won6vbt', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-05 16:13:00.246416');
INSERT INTO `django_session` VALUES ('ubbyoln5rjrdyckredgkdny0xu2gdott', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-18 17:42:41.147173');
INSERT INTO `django_session` VALUES ('ubyaxlomsiyphpcrz5k9079a4585iy29', 'MTNhZTcyYWJhNjQxMDg0ZTQxOTFkOTU4ODk3MTYwNjdmNGYwYjdiMTp7InVzZXIiOjM5LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 09:28:35.341449');
INSERT INTO `django_session` VALUES ('udjw2jidqmclhqjr3fzd65jug953s9o9', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-20 22:33:07.041801');
INSERT INTO `django_session` VALUES ('uld2s74mt6stwhg6admod99bwmk6hgkt', 'NGQ1ZDUxMTE2MzdlZmExN2NlOTAxNGJhNTVkODFiMDU4OWYwYzJkYzp7InVzZXIiOjQwLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 02:23:28.018786');
INSERT INTO `django_session` VALUES ('um3d8lasiyfj8k2wwta5aj32knaj172p', 'YWFkNTRmYjM3N2NhYjdlNTIwYmUxMzNkMzJkZWIzMDU4MjQxOWY5NDp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2020-12-31 18:21:15.749162');
INSERT INTO `django_session` VALUES ('uqm1uli7desrc8i9atcvaw4j25o1q6yv', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-21 11:28:09.439162');
INSERT INTO `django_session` VALUES ('uxbzf7uogihm51srtbv628lbhydhu4oz', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 15:08:16.924222');
INSERT INTO `django_session` VALUES ('v6fyqp1s3dl7v7bv5s6mysxjv75whfbd', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-20 08:19:30.858721');
INSERT INTO `django_session` VALUES ('w6qhao9rob8srdokg0c6brz0n8gk4rf7', 'YjYyMGI3NGNiOWIzZjUyNjUwYWZmN2RjODk5NDA5OWFmZDU3NDE0Mjp7InVzZXIiOjQxLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2020-12-30 16:03:08.586838');
INSERT INTO `django_session` VALUES ('wbrik3bs6oyrqg5puiw2djvn0brvlqa6', 'YWFkNTRmYjM3N2NhYjdlNTIwYmUxMzNkMzJkZWIzMDU4MjQxOWY5NDp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-05 15:33:13.036003');
INSERT INTO `django_session` VALUES ('x1kdo7lxz72set1jy4dloiwamcnj4t5g', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 07:55:01.968355');
INSERT INTO `django_session` VALUES ('x86z0o8pr949kyolmgc4t0qddx8a6bhq', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-19 16:36:03.512661');
INSERT INTO `django_session` VALUES ('xkinkf8mmc9agz7c14yp5cip7nfhtyat', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 13:44:40.327777');
INSERT INTO `django_session` VALUES ('xmqxfda15pvzp2ufk7rgi6r2wsavlak4', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 09:44:46.187478');
INSERT INTO `django_session` VALUES ('xvktqxnxqphy84a7zomyyjq7c7f1ledn', 'ZTc2Y2RkNjAyZDJiNGMzZjM0YzYwYjBjOGFhZTFmMzlhNDA0ZTljMjp7InVzZXIiOjM4LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 09:08:02.395923');
INSERT INTO `django_session` VALUES ('y1c6z5vss2bqnk5u2wss8mi1deyvqspv', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-18 14:13:53.250846');
INSERT INTO `django_session` VALUES ('y5q06m0x7cfbm44hbv6l18tf5fpvw648', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-18 12:09:44.911884');
INSERT INTO `django_session` VALUES ('y7qolvgjonx1io4we1zzq4bkqf2miq1r', 'N2EzMzRhNDIzNDVhMmQ3OGE1OTkwZTk4YzkxMjg1ZWU0ZThiYjYwYTp7InVzZXIiOjQyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 03:56:57.862511');
INSERT INTO `django_session` VALUES ('y7rbn58lunc5hfts7a0pwu7el2fra5w9', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-30 02:38:22.840204');
INSERT INTO `django_session` VALUES ('y89j0kge0f1vrcwlnidsx9sjlb8m3y56', 'NmIxODUyNDA3NmNmZDY5YzU5ODQxOTlhZmRhMjRhZDZkMDJkZDZmOTp7InVzZXIiOjM5LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-05 16:18:13.553197');
INSERT INTO `django_session` VALUES ('ybche8ab4w178amrzr6m8dfmg8uphvoy', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-28 08:38:08.014913');
INSERT INTO `django_session` VALUES ('ycefyvcn2o1ee2v4pgyehgy5hwzbkxo0', 'ZTM5OWQwZjFiNzM5YjJhYTU3YzI1MTcxYTNlY2I1Yjk1MzA3YTNjZDp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-12 12:29:00.407468');
INSERT INTO `django_session` VALUES ('yh0fj77yjwxkuxiyey2jfohuakna7md1', 'ZjcyZGY3MDFjZTA1MGMxZDFjNTY0YWM5MjcxMzI0ZThiYjBlYWUyNzp7InVzZXIiOjM3LCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-28 07:35:55.053121');
INSERT INTO `django_session` VALUES ('yj28j58hg0v851rkydd0vi9s24tvbp9c', 'MDVmZDk3ZDZmODk1YTRmN2EyNGI0NGI1MjQxYzMyMWRmYjUyYzZiNzp7InVzZXIiOjQxLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-21 03:05:55.633121');
INSERT INTO `django_session` VALUES ('ynp51rjxpgl42b6zfm3xxcs8rxbfz7qb', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-17 21:37:58.886664');
INSERT INTO `django_session` VALUES ('yphhdiyvmmbgvhvo5ui7d1oywmnfku7m', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-28 09:07:18.008486');
INSERT INTO `django_session` VALUES ('yqhcba5eers0ufx0z6uyik38h1c1lwbz', 'YzhjODBhYzczZjViZWI5MDNjNjhlMzkyMTdmMDc3MmU0YTE1MmE2MTp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-23 11:21:15.055390');
INSERT INTO `django_session` VALUES ('ywajopzbsp4vc2i382g3bjzd4bavs4oq', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-25 11:04:42.787959');
INSERT INTO `django_session` VALUES ('yxmlrhuct4fzg43pdwfni7poxwasfnym', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-07-24 19:11:09.878948');
INSERT INTO `django_session` VALUES ('z9zw2dt49vq935cxncd9ikv86k7az25k', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-22 03:17:02.704138');
INSERT INTO `django_session` VALUES ('zhuv9rzo9e77cr1ql1kb4snn98qxf1ql', 'YjYyMGI3NGNiOWIzZjUyNjUwYWZmN2RjODk5NDA5OWFmZDU3NDE0Mjp7InVzZXIiOjQxLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2020-12-30 16:22:55.911040');
INSERT INTO `django_session` VALUES ('zhzbdig9kfo7pfbkq6ixub3m9b5m9cg1', 'NGZiMzFmODNhOWQ2NTdjYTA0NGU2NjM1ZmUyZTc3ODliNmI4OWQwNzp7InVzZXIiOjQzLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDB9', '2020-12-24 02:23:17.538514');
INSERT INTO `django_session` VALUES ('zv806gr2a4yo6qt1xgjcb84f1cat0b2i', 'NjZmNzc2OGY5OTM5MGEzMmQxNGRiOWIxN2UzNTIxNGM0NWU4MGJhNDp7InVzZXIiOjEyLCJfc2Vzc2lvbl9leHBpcnkiOjM2MDAwfQ==', '2021-01-05 15:44:16.118929');
COMMIT;

-- ----------------------------
-- Table structure for Gr33kLibrary_article
-- ----------------------------
DROP TABLE IF EXISTS `Gr33kLibrary_article`;
CREATE TABLE `Gr33kLibrary_article` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tags` varchar(255) DEFAULT NULL,
  `content` longtext NOT NULL,
  `title` varchar(255) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `author_id` int DEFAULT NULL,
  `classify_id` int DEFAULT NULL,
  `state` int NOT NULL,
  `read_num` int NOT NULL,
  `back_info` longtext NOT NULL,
  `type` int NOT NULL,
  `article_link` longtext,
  PRIMARY KEY (`id`),
  KEY `Gr33kLibrary_article_author_id_23b74cb9_fk_Gr33kLibrary_user_id` (`author_id`),
  KEY `Gr33kLibrary_article_classify_id_c7457b16_fk_Gr33kLibr` (`classify_id`),
  CONSTRAINT `Gr33kLibrary_article_author_id_23b74cb9_fk_Gr33kLibrary_user_id` FOREIGN KEY (`author_id`) REFERENCES `Gr33kLibrary_user` (`id`),
  CONSTRAINT `Gr33kLibrary_article_classify_id_c7457b16_fk_Gr33kLibr` FOREIGN KEY (`classify_id`) REFERENCES `Gr33kLibrary_classify` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62952 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for Gr33kLibrary_classify
-- ----------------------------
DROP TABLE IF EXISTS `Gr33kLibrary_classify`;
CREATE TABLE `Gr33kLibrary_classify` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Gr33kLibrary_classify_name_e51e98b5_uniq` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for Gr33kLibrary_collect
-- ----------------------------
DROP TABLE IF EXISTS `Gr33kLibrary_collect`;
CREATE TABLE `Gr33kLibrary_collect` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `article_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Gr33kLibrary_collect_article_id_63d7f4e2_fk_Gr33kLibr` (`article_id`),
  KEY `Gr33kLibrary_collect_user_id_b01c4f2d_fk_Gr33kLibrary_user_id` (`user_id`),
  CONSTRAINT `Gr33kLibrary_collect_article_id_63d7f4e2_fk_Gr33kLibr` FOREIGN KEY (`article_id`) REFERENCES `Gr33kLibrary_article` (`id`),
  CONSTRAINT `Gr33kLibrary_collect_user_id_b01c4f2d_fk_Gr33kLibrary_user_id` FOREIGN KEY (`user_id`) REFERENCES `Gr33kLibrary_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for Gr33kLibrary_tag
-- ----------------------------
DROP TABLE IF EXISTS `Gr33kLibrary_tag`;
CREATE TABLE `Gr33kLibrary_tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Gr33kLibrary_tag_name_4e50a7e1_uniq` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=482 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for Gr33kLibrary_tool
-- ----------------------------
DROP TABLE IF EXISTS `Gr33kLibrary_tool`;
CREATE TABLE `Gr33kLibrary_tool` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `upload_user_id` int DEFAULT NULL,
  `file_size` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Gr33kLibrary_tool_upload_user_id_388ef206_fk_Gr33kLibr` (`upload_user_id`),
  CONSTRAINT `Gr33kLibrary_tool_upload_user_id_388ef206_fk_Gr33kLibr` FOREIGN KEY (`upload_user_id`) REFERENCES `Gr33kLibrary_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for Gr33kLibrary_update_log
-- ----------------------------
DROP TABLE IF EXISTS `Gr33kLibrary_update_log`;
CREATE TABLE `Gr33kLibrary_update_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for Gr33kLibrary_user
-- ----------------------------
DROP TABLE IF EXISTS `Gr33kLibrary_user`;
CREATE TABLE `Gr33kLibrary_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `is_lock` tinyint(1) NOT NULL,
  `login_fail` int NOT NULL,
  `invitation_code` varchar(255) DEFAULT NULL,
  `invitation_user` int DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `invitation_num` int NOT NULL,
  `article_num` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `Gr33kLibrary_user_invitation_code_4adaa8d1_uniq` (`invitation_code`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of Gr33kLibrary_user
-- ----------------------------
BEGIN;
INSERT INTO `Gr33kLibrary_user` VALUES (12, 'Gr33k', 'e10adc3949ba59abbe56e057f20f883e', '', 'GST', 0, 0, NULL, NULL, '2021-07-25 01:27:07.850200', 0, 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
