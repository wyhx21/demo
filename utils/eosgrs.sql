/*
Navicat MySQL Data Transfer

Source Server         : 通用配班
Source Server Version : 50621
Source Host           : 10.203.15.199:3306
Source Database       : eosgrs

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2018-04-25 19:20:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tl_exception_log
-- ----------------------------
DROP TABLE IF EXISTS `tl_exception_log`;
CREATE TABLE `tl_exception_log` (
  `SEQ_NO` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `PROCEDURE_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '存储过程名或方法名',
  `EXCEPTION_TM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '异常时间',
  `EXCEPTION_CODE` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '异常编码',
  `EXCU_STATUS` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '执行结果SUCCESS,ERROR',
  `EXCEPTION_DESC` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '异常说明',
  `EXCEPTION_REMK` varchar(600) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '异常备注',
  `LINE_NO` int(5) DEFAULT NULL COMMENT '执行行号',
  `PACKAGE_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '包名',
  `PROCESS_NO` bigint(22) DEFAULT NULL COMMENT '批次号',
  PRIMARY KEY (`SEQ_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='存储过程异常记录日志';

-- ----------------------------
-- Table structure for tl_grs_user_group
-- ----------------------------
DROP TABLE IF EXISTS `tl_grs_user_group`;
CREATE TABLE `tl_grs_user_group` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `EMP_CODE` varchar(30) NOT NULL COMMENT '工号',
  `PLAN_DT` date NOT NULL COMMENT '排班日期',
  `GROUP_CODE` varchar(30) NOT NULL COMMENT '小组编码',
  `CREATED_TM` datetime NOT NULL COMMENT '创建时间',
  `CREATED_EMP_CODE` varchar(30) NOT NULL COMMENT '创建人',
  `RECORD_CREATED_TM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录备份时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IDX_TL_GRS_USER_GROUP_01` (`EMP_CODE`,`PLAN_DT`,`GROUP_CODE`),
  KEY `IDX_TL_GRS_USER_GROUP_02` (`EMP_CODE`),
  KEY `IDX_TL_GRS_USER_GROUP_03` (`PLAN_DT`)
) ENGINE=InnoDB AUTO_INCREMENT=1337 DEFAULT CHARSET=utf8 COMMENT='员工与小组组对应关系(历史数据)每日备份';

-- ----------------------------
-- Table structure for tl_grs_user_ownership
-- ----------------------------
DROP TABLE IF EXISTS `tl_grs_user_ownership`;
CREATE TABLE `tl_grs_user_ownership` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增长',
  `EMP_CODE` varchar(30) NOT NULL COMMENT '工号',
  `SYSTEM_OWNERSHIP` varchar(20) DEFAULT NULL COMMENT '系统归属，SAP/PMP',
  `PLAN_DT` date NOT NULL COMMENT '排班日期',
  `CREATED_TM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IDX_TL_GRS_USER_OWNERSHIP_01` (`EMP_CODE`,`PLAN_DT`),
  KEY `IDX_TL_GRS_USER_OWNERSHIP_02` (`PLAN_DT`)
) ENGINE=InnoDB AUTO_INCREMENT=2145 DEFAULT CHARSET=utf8 COMMENT='员工归属系统（SAP/PMP）每日备份';

-- ----------------------------
-- Table structure for tl_op_recovery_task
-- ----------------------------
DROP TABLE IF EXISTS `tl_op_recovery_task`;
CREATE TABLE `tl_op_recovery_task` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `PROCESS_NO` varchar(100) NOT NULL COMMENT '批次号',
  `CREATED_EMP` varchar(30) NOT NULL COMMENT '人员排班还原：EMP_01，资源排班还原：EMP_02，',
  `CREATED_TM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `MODIFIED_TM` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`),
  KEY `idx_tl_grs_etl_pull_log_01` (`CREATED_TM`),
  KEY `idx_tl_grs_etl_pull_log_02` (`PROCESS_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8 COMMENT='SAP和PMP抽数批次号';

-- ----------------------------
-- Table structure for tl_op_recovery_task_data
-- ----------------------------
DROP TABLE IF EXISTS `tl_op_recovery_task_data`;
CREATE TABLE `tl_op_recovery_task_data` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增长',
  `PROCESS_NO` varchar(100) NOT NULL COMMENT '批次号',
  `EMP_CODE` varchar(30) NOT NULL COMMENT '员工工号',
  `PLAN_DT` date NOT NULL COMMENT '日期',
  `CREATED_TM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATED_EMP` varchar(30) NOT NULL COMMENT '创建人',
  PRIMARY KEY (`ID`),
  KEY `idx_tl_grs_etl_pull_detail_log_01` (`PROCESS_NO`),
  KEY `idx_tl_grs_etl_pull_detail_log_02` (`CREATED_TM`),
  KEY `idx_tl_grs_etl_pull_detail_log_03` (`PLAN_DT`)
) ENGINE=InnoDB AUTO_INCREMENT=350 DEFAULT CHARSET=utf8 COMMENT='班次还原记录创建批次号详情表';

-- ----------------------------
-- Table structure for tmp_20180425_lzh
-- ----------------------------
DROP TABLE IF EXISTS `tmp_20180425_lzh`;
CREATE TABLE `tmp_20180425_lzh` (
  `code` varchar(30) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tm_department
-- ----------------------------
DROP TABLE IF EXISTS `tm_department`;
CREATE TABLE `tm_department` (
  `dept_id` bigint(20) NOT NULL,
  `dept_code` varchar(30) NOT NULL,
  `dept_name` varchar(100) DEFAULT NULL,
  `type_level` int(11) DEFAULT NULL,
  `parent_dept_code` varchar(30) DEFAULT NULL,
  `created_user` varchar(30) DEFAULT NULL,
  `created_tm` datetime DEFAULT NULL,
  `modified_user` varchar(30) DEFAULT NULL,
  `modified_tm` datetime DEFAULT NULL,
  `delete_flg` int(11) DEFAULT '0',
  `sync_tm` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`dept_id`),
  KEY `idx_tm_department_01` (`dept_code`),
  KEY `idx_tm_department_02` (`parent_dept_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组织结构表';

-- ----------------------------
-- Table structure for tm_employee
-- ----------------------------
DROP TABLE IF EXISTS `tm_employee`;
CREATE TABLE `tm_employee` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `emp_num` varchar(32) NOT NULL COMMENT '工号',
  `full_name` varchar(128) DEFAULT NULL COMMENT '真实姓名',
  `org_code` varchar(128) DEFAULT NULL COMMENT '组织结构编码(网点编码)',
  `mobile` varchar(32) DEFAULT NULL COMMENT '手机号',
  `sex` varchar(1) DEFAULT NULL COMMENT '性别（F，女，M，男）',
  `position_code` varchar(32) DEFAULT NULL COMMENT '岗位编码',
  `position_name` varchar(32) DEFAULT NULL COMMENT '岗位名称',
  `is_deleted` tinyint(1) NOT NULL COMMENT '0正常，1删除',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `modified_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',
  `work_mobile` varchar(32) DEFAULT NULL COMMENT '工作号码',
  `sync_tm` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '同步时间',
  `hq_code` varchar(30) DEFAULT NULL COMMENT '所属经营本部',
  `vehicle` bigint(20) DEFAULT NULL COMMENT '交通工具',
  `resource_tag` varchar(16) DEFAULT NULL COMMENT '用工类型(0非全日制，1全日制)',
  `delivery_type` tinyint(4) DEFAULT NULL COMMENT '员工类型(1-普通快件 2-高价值快件)',
  `employee_duty_type` tinyint(4) DEFAULT NULL COMMENT '收派类型(港澳台) 1-步兵收派员，2-司机收派员',
  `employee_motor_type` tinyint(2) DEFAULT NULL COMMENT '员工类型：1 机动员工，2 非机动员工，3 新员工',
  `position_property` varchar(30) DEFAULT NULL COMMENT '0010：一线 0020： 二线',
  `master_loginid` varchar(30) DEFAULT NULL COMMENT '主岗工号',
  `SUPERVISOR_LOGINID` varchar(16) DEFAULT NULL COMMENT '主管工号',
  `card_type` varchar(2) DEFAULT NULL COMMENT '证件类型(1:大陆身份证,2:护照,3:香港身份证,4:澳门身份证,5:台湾身份证)',
  `card_id` varchar(64) DEFAULT NULL COMMENT '身份证号码',
  `emp_type` tinyint(2) DEFAULT NULL COMMENT '是否供应商的运作岗。1否，2是',
  `system_ownership` varchar(20) DEFAULT NULL COMMENT '系统归属，SAP/PMP',
  `HIRE_DATE` date DEFAULT NULL COMMENT '入职日期',
  `PROVISION_DATE` date DEFAULT NULL COMMENT '转正日期',
  `STATUS` varchar(4) DEFAULT NULL COMMENT '在职状态',
  `SKILL` varchar(64) DEFAULT NULL COMMENT '技能',
  PRIMARY KEY (`id`),
  KEY `idx_tm_employee_emp_num` (`emp_num`),
  KEY `idx_tm_employee_org_code` (`org_code`)
) ENGINE=InnoDB AUTO_INCREMENT=614054 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Table structure for tm_employee_0425
-- ----------------------------
DROP TABLE IF EXISTS `tm_employee_0425`;
CREATE TABLE `tm_employee_0425` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '主键',
  `emp_num` varchar(32) CHARACTER SET utf8mb4 NOT NULL COMMENT '工号',
  `full_name` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '真实姓名',
  `org_code` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '组织结构编码(网点编码)',
  `mobile` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '手机号',
  `sex` varchar(1) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '性别（F，女，M，男）',
  `position_code` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '岗位编码',
  `position_name` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '岗位名称',
  `is_deleted` tinyint(1) NOT NULL COMMENT '0正常，1删除',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `modified_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',
  `work_mobile` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '工作号码',
  `sync_tm` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '同步时间',
  `hq_code` varchar(30) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '所属经营本部',
  `vehicle` bigint(20) DEFAULT NULL COMMENT '交通工具',
  `resource_tag` varchar(16) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '用工类型(0非全日制，1全日制)',
  `delivery_type` tinyint(4) DEFAULT NULL COMMENT '员工类型(1-普通快件 2-高价值快件)',
  `employee_duty_type` tinyint(4) DEFAULT NULL COMMENT '收派类型(港澳台) 1-步兵收派员，2-司机收派员',
  `employee_motor_type` tinyint(2) DEFAULT NULL COMMENT '员工类型：1 机动员工，2 非机动员工，3 新员工',
  `position_property` varchar(30) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '0010：一线 0020： 二线',
  `master_loginid` varchar(30) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '主岗工号',
  `SUPERVISOR_LOGINID` varchar(16) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '主管工号',
  `card_type` varchar(2) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '证件类型(1:大陆身份证,2:护照,3:香港身份证,4:澳门身份证,5:台湾身份证)',
  `card_id` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '身份证号码',
  `emp_type` tinyint(2) DEFAULT NULL COMMENT '是否供应商的运作岗。1否，2是',
  `system_ownership` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '系统归属，SAP/PMP',
  `HIRE_DATE` date DEFAULT NULL COMMENT '入职日期',
  `PROVISION_DATE` date DEFAULT NULL COMMENT '转正日期',
  `STATUS` varchar(4) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '在职状态',
  `SKILL` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '技能'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tm_grs_emp_skill
-- ----------------------------
DROP TABLE IF EXISTS `tm_grs_emp_skill`;
CREATE TABLE `tm_grs_emp_skill` (
  `emp_code` varchar(32) DEFAULT NULL COMMENT '员工ID',
  `skill` varchar(10) DEFAULT NULL COMMENT '技能ID',
  UNIQUE KEY `idx_tm_grs_emp_skill_01` (`emp_code`,`skill`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tm_grs_emp_supp_dept
-- ----------------------------
DROP TABLE IF EXISTS `tm_grs_emp_supp_dept`;
CREATE TABLE `tm_grs_emp_supp_dept` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增长',
  `epiempId` bigint(20) DEFAULT NULL,
  `EMP_CODE` varchar(30) NOT NULL COMMENT '工号',
  `DEPT_CODE` varchar(30) NOT NULL COMMENT '网点',
  `SUPP_CODE` varchar(30) NOT NULL COMMENT '机构ID',
  `FLAG` tinyint(1) DEFAULT NULL COMMENT '1:供应商 0:网点',
  `INVALID_TM` datetime DEFAULT NULL COMMENT '失效时间',
  `CREATED_TM` datetime DEFAULT NULL COMMENT '创建时间',
  `MODIFIED_TM` datetime DEFAULT NULL COMMENT '修改时间',
  `SYNC_TM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据同步入库时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_tm_op_emp_supp_dept_01` (`EMP_CODE`,`DEPT_CODE`,`SUPP_CODE`),
  KEY `idx_tm_op_emp_supp_dept_02` (`DEPT_CODE`),
  KEY `idx_tm_op_emp_supp_dept_03` (`SUPP_CODE`),
  KEY `idx_tm_op_emp_supp_dept_04` (`epiempId`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COMMENT='员工和网点和机构对应关系';

-- ----------------------------
-- Table structure for tm_grs_group
-- ----------------------------
DROP TABLE IF EXISTS `tm_grs_group`;
CREATE TABLE `tm_grs_group` (
  `GROUP_CODE` varchar(30) NOT NULL COMMENT '小组编码',
  `GROUP_NAME` varchar(30) NOT NULL COMMENT '小组名称',
  `sys_id` int(11) NOT NULL COMMENT '系统ID',
  `tag` varchar(200) DEFAULT NULL COMMENT '小组标签',
  `DEPT_CODE` varchar(30) NOT NULL COMMENT '所属编码',
  `CREATED_TM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATED_EMP_CODE` varchar(30) NOT NULL COMMENT '创建人',
  `MODIFIED_TM` datetime DEFAULT NULL COMMENT '修改时间',
  `MODIFIED__EMP_CODE` varchar(30) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`GROUP_CODE`),
  KEY `idx_tm_grs_group_01` (`sys_id`,`DEPT_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='小组信息';

-- ----------------------------
-- Table structure for tm_grs_group_emp
-- ----------------------------
DROP TABLE IF EXISTS `tm_grs_group_emp`;
CREATE TABLE `tm_grs_group_emp` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `GROUP_CODE` varchar(30) NOT NULL COMMENT '小组编码',
  `EMP_CODE` varchar(30) NOT NULL COMMENT '工号',
  `SUPP_CODE` varchar(30) DEFAULT NULL COMMENT '机构编码,备用',
  `LEADER` tinyint(4) DEFAULT NULL COMMENT '1组长，0组员',
  `CREATED_TM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATED_EMP_CODE` varchar(30) NOT NULL COMMENT '创建人',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_tm_rss_op_group_emp_01` (`GROUP_CODE`,`EMP_CODE`),
  KEY `idx_tm_grs_group_emp_02` (`EMP_CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8 COMMENT='员工与小组组对应关系';

-- ----------------------------
-- Table structure for tm_grs_lock
-- ----------------------------
DROP TABLE IF EXISTS `tm_grs_lock`;
CREATE TABLE `tm_grs_lock` (
  `lock_name` varchar(30) NOT NULL COMMENT '锁名称(唯一)',
  `lock_tm` varchar(30) DEFAULT NULL COMMENT '上次锁住时间',
  `create_tm` datetime DEFAULT NULL COMMENT '创建时间',
  `server_ip` varchar(30) DEFAULT NULL COMMENT '服务IP',
  PRIMARY KEY (`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单节点锁';

-- ----------------------------
-- Table structure for tm_grs_plan
-- ----------------------------
DROP TABLE IF EXISTS `tm_grs_plan`;
CREATE TABLE `tm_grs_plan` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自动增长',
  `sys_id` int(11) NOT NULL COMMENT '系统ID',
  `plan_code` varchar(8) NOT NULL COMMENT '班次编码',
  `PLAN_NAME` varchar(50) NOT NULL COMMENT '班次名称',
  `DEPT_CODE` varchar(30) NOT NULL COMMENT '所属编码',
  `BUSINESS_TYPE_CODE` varchar(30) DEFAULT NULL COMMENT '业务类型编码',
  `WORK_PROC_CODE` varchar(30) DEFAULT NULL COMMENT '工序编码',
  `WORK_TYPE` tinyint(1) DEFAULT '1' COMMENT '班次类型1正常班，0休息班',
  `CREATED_TM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATED_EMP_CODE` varchar(30) NOT NULL COMMENT '创建人',
  `MODIFIED_TM` datetime DEFAULT NULL COMMENT '修改时间',
  `MODIFIED_EMP_CODE` varchar(30) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_tm_grs_plan_01` (`sys_id`,`DEPT_CODE`,`plan_code`) USING BTREE,
  KEY `idx_tm_grs_plan_02` (`BUSINESS_TYPE_CODE`),
  KEY `idx_tm_grs_plan_03` (`WORK_PROC_CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8 COMMENT='班次信息';

-- ----------------------------
-- Table structure for tm_grs_plan_detail
-- ----------------------------
DROP TABLE IF EXISTS `tm_grs_plan_detail`;
CREATE TABLE `tm_grs_plan_detail` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `PLAN_ID` bigint(20) NOT NULL COMMENT '班次表ID',
  `IS_SKIP_DAY` tinyint(1) DEFAULT '0' COMMENT '是否跨天 1是0否',
  `BEGIN_TM` char(4) NOT NULL COMMENT '开始时间（例如：0800）',
  `END_TM` char(4) NOT NULL COMMENT '结束时间（例如：1200）',
  `CREATED_TM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATED_EMP_CODE` varchar(30) NOT NULL COMMENT '创建人',
  PRIMARY KEY (`ID`),
  KEY `idx_tm_grs_plan_detail_01` (`PLAN_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=319 DEFAULT CHARSET=utf8 COMMENT='班次明细记录表';

-- ----------------------------
-- Table structure for tm_grs_prc_skill
-- ----------------------------
DROP TABLE IF EXISTS `tm_grs_prc_skill`;
CREATE TABLE `tm_grs_prc_skill` (
  `sys_id` int(11) NOT NULL COMMENT '系统编码',
  `work_prc_code` varchar(30) DEFAULT NULL COMMENT '工序编码',
  `skill` varchar(10) DEFAULT NULL COMMENT '技能编码',
  UNIQUE KEY `idx_tm_grs_prc_skill_01` (`sys_id`,`work_prc_code`,`skill`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='工序技能关系表';

-- ----------------------------
-- Table structure for tm_grs_supplier
-- ----------------------------
DROP TABLE IF EXISTS `tm_grs_supplier`;
CREATE TABLE `tm_grs_supplier` (
  `sys_id` int(11) DEFAULT NULL COMMENT '系统ID',
  `SUPP_CODE` varchar(30) NOT NULL COMMENT '供应商ID',
  `SUPP_NAME` varchar(300) DEFAULT NULL COMMENT '供应商名称',
  `SYNC_TM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据同步入库时间',
  PRIMARY KEY (`SUPP_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商基础信息';

-- ----------------------------
-- Table structure for tm_grs_work_prc
-- ----------------------------
DROP TABLE IF EXISTS `tm_grs_work_prc`;
CREATE TABLE `tm_grs_work_prc` (
  `sys_id` int(11) NOT NULL DEFAULT '0' COMMENT '系统ID',
  `WORK_PROC_CODE` varchar(30) NOT NULL COMMENT '工序编码',
  `WORK_PROC_NAME` varchar(100) NOT NULL COMMENT '工序名称',
  `BUSINESS_TYPE_CODE` varchar(30) DEFAULT NULL COMMENT '业务类型编码',
  `GOLD_RATIO` decimal(6,2) DEFAULT NULL COMMENT '工序含金量',
  `CREATED_TM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATED_EMP_CODE` varchar(30) NOT NULL COMMENT '创建人',
  PRIMARY KEY (`sys_id`,`WORK_PROC_CODE`),
  KEY `idx_tm_grs_work_prc_01` (`sys_id`,`BUSINESS_TYPE_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工序';

-- ----------------------------
-- Table structure for tm_system
-- ----------------------------
DROP TABLE IF EXISTS `tm_system`;
CREATE TABLE `tm_system` (
  `sys_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '系统ID',
  `sys_name` varchar(100) NOT NULL COMMENT '系统名称',
  `emp_type` tinyint(2) DEFAULT NULL COMMENT '员工类型: 2,中转场供应商员工',
  `sys_describe` varchar(100) NOT NULL COMMENT '子系统描述',
  `create_user` varchar(50) DEFAULT NULL COMMENT '创建人',
  `creatd_tm` datetime DEFAULT NULL COMMENT '创建日期',
  `is_deleted` char(1) DEFAULT '0' COMMENT '删除标志',
  `modify_user` varchar(50) DEFAULT NULL COMMENT '修改人',
  `modify_tm` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`sys_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6015 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tm_system_config
-- ----------------------------
DROP TABLE IF EXISTS `tm_system_config`;
CREATE TABLE `tm_system_config` (
  `CONFIG_ID` bigint(18) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置编号',
  `CONFIG_NAME` varchar(128) DEFAULT NULL COMMENT '配置名称关键字',
  `CONFIG_VALUE` varchar(4000) DEFAULT NULL COMMENT '配置值',
  `CONFIG_REMARK` varchar(512) DEFAULT NULL COMMENT '配置描述信息',
  `VALID_FLG` int(1) DEFAULT '1' COMMENT '是否有效 0：无效，1 有效',
  `CREATE_TM` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATE_EMP_CODE` varchar(30) DEFAULT NULL COMMENT '创建人工号',
  `MODIFIED_TM` datetime DEFAULT NULL COMMENT '修改时间',
  `MODIFIED_EMP_CODE` varchar(30) DEFAULT NULL COMMENT '修改人工号',
  `ALLOW_MODIFY` int(1) DEFAULT '1' COMMENT '该配置是否允许修改,默认情况为 0：不允许，1允许',
  PRIMARY KEY (`CONFIG_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='系统任务表';

-- ----------------------------
-- Table structure for tm_sys_department
-- ----------------------------
DROP TABLE IF EXISTS `tm_sys_department`;
CREATE TABLE `tm_sys_department` (
  `sys_id` int(11) NOT NULL COMMENT '系统编码',
  `dept_code` varchar(30) NOT NULL COMMENT '组织编码',
  `create_user` varchar(50) DEFAULT NULL,
  `create_tm` datetime DEFAULT NULL,
  UNIQUE KEY `idx_tm_sys_department_01` (`sys_id`,`dept_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统拥有的组织结构关系表';

-- ----------------------------
-- Table structure for tm_sys_employee
-- ----------------------------
DROP TABLE IF EXISTS `tm_sys_employee`;
CREATE TABLE `tm_sys_employee` (
  `sys_id` int(11) NOT NULL COMMENT '系统编码',
  `position_code` varchar(32) NOT NULL COMMENT '岗位编码',
  `position_name` varchar(32) DEFAULT NULL COMMENT '岗位名称',
  `create_user` varchar(50) DEFAULT NULL,
  `create_tm` datetime DEFAULT NULL,
  UNIQUE KEY `idx_tm_sys_employee_01` (`sys_id`,`position_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统可分配的排班岗位关系表';

-- ----------------------------
-- Table structure for tm_sys_field_alias
-- ----------------------------
DROP TABLE IF EXISTS `tm_sys_field_alias`;
CREATE TABLE `tm_sys_field_alias` (
  `sys_id` int(11) NOT NULL COMMENT '系统编码',
  `field_code` year(4) NOT NULL COMMENT '字段编码',
  `alias_name` varchar(100) DEFAULT NULL,
  `create_user` varchar(50) DEFAULT NULL,
  `create_tm` datetime DEFAULT NULL,
  `modify_user` varchar(50) DEFAULT NULL,
  `modify_tm` datetime DEFAULT NULL,
  UNIQUE KEY `idx_tm_sys_field_01` (`sys_id`,`field_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tm_sys_module
-- ----------------------------
DROP TABLE IF EXISTS `tm_sys_module`;
CREATE TABLE `tm_sys_module` (
  `sys_id` int(11) NOT NULL COMMENT '系统编码',
  `module_id` bigint(18) NOT NULL COMMENT '菜单编码',
  `create_user` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  UNIQUE KEY `idx_tm_sys_module_01` (`sys_id`,`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tm_sys_module_field
-- ----------------------------
DROP TABLE IF EXISTS `tm_sys_module_field`;
CREATE TABLE `tm_sys_module_field` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sys_id` int(11) NOT NULL COMMENT '系统编码',
  `field_code` varchar(50) NOT NULL COMMENT '字段编码',
  `module_id` bigint(18) NOT NULL COMMENT '功能编码,对应菜单ID',
  `is_show` char(1) NOT NULL COMMENT '是否显示',
  `create_user` varchar(50) DEFAULT NULL,
  `create_tm` datetime DEFAULT NULL,
  `modify_user` varchar(50) DEFAULT NULL,
  `modify_tm` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tm_sys_module_field_01` (`id`,`sys_id`,`field_code`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tm_sys_module_field_tmpl
-- ----------------------------
DROP TABLE IF EXISTS `tm_sys_module_field_tmpl`;
CREATE TABLE `tm_sys_module_field_tmpl` (
  `module_id` bigint(18) DEFAULT NULL COMMENT '菜单ID',
  `field_code` varchar(50) DEFAULT NULL COMMENT '字段编码',
  `field_name` varchar(100) DEFAULT NULL COMMENT '字段名称',
  `required` tinyint(1) DEFAULT NULL COMMENT '是否必须字段,1:必须,0:可选',
  UNIQUE KEY `idx_tm_sys_module_field_tmpl` (`module_id`,`field_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ts_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `ts_dictionary`;
CREATE TABLE `ts_dictionary` (
  `DIC_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '字典ID',
  `DIC_KEY` varchar(100) NOT NULL COMMENT 'KEY，英文数字下划线组成',
  `DIC_NAME` varchar(300) DEFAULT NULL COMMENT '名称，默认用于展示的文字',
  `DESCRIPT` varchar(1200) DEFAULT NULL COMMENT '描述文字',
  `PARENT_ID` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `DIC_VALUE` varchar(1000) DEFAULT NULL COMMENT '值',
  `SN` int(10) DEFAULT NULL COMMENT '序号',
  `PKEY_PATH` varchar(2000) NOT NULL COMMENT '如节点Key路径',
  `STATUS` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态：无效0，有效1',
  `CREATE_BY` varchar(30) DEFAULT NULL COMMENT '创建者用户账号',
  `CREATE_TM` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `UPDATE_BY` varchar(30) DEFAULT NULL COMMENT '更新者用户账号',
  `UPDATE_TM` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`DIC_ID`),
  FULLTEXT KEY `IDX_DICTIONARY` (`DIC_KEY`,`PKEY_PATH`)
) ENGINE=InnoDB AUTO_INCREMENT=651 DEFAULT CHARSET=utf8 COMMENT='数据字典信息表';

-- ----------------------------
-- Table structure for ts_module
-- ----------------------------
DROP TABLE IF EXISTS `ts_module`;
CREATE TABLE `ts_module` (
  `MODULE_ID` bigint(18) unsigned NOT NULL COMMENT '功能模块ID',
  `PARENT_ID` bigint(18) unsigned DEFAULT NULL COMMENT '父功能模块ID，没有父模块时为空',
  `MODULE_NAME` varchar(120) DEFAULT NULL COMMENT '名称，默认用于展示的文字',
  `SYS_CODE` varchar(100) NOT NULL COMMENT '系统编码，英文数字下划线组成',
  `MODULE_CODE` varchar(100) NOT NULL COMMENT '模块代码，英文数字下划线组成',
  `MODULE_DESC` varchar(600) DEFAULT NULL COMMENT '描述文字',
  `MODULE_ICON` varchar(300) DEFAULT NULL COMMENT '图标，相对根路径的地址，或者外链',
  `MODULE_TYPE` tinyint(3) unsigned NOT NULL COMMENT '类型 1项目根类型 2子系统  3菜单目录 4页面按钮，权限等',
  `APP_TYPE` tinyint(3) unsigned NOT NULL COMMENT '功能类型 1.PC WEB 2.手机WEB',
  `ACTION_URL` varchar(300) DEFAULT NULL COMMENT '功能请求链接，相对根路径的地址',
  `SORT` tinyint(3) unsigned NOT NULL COMMENT '排序序号',
  `HELP_URL` varchar(300) DEFAULT NULL COMMENT '帮助链接，相对根路径的地址，或者外链',
  `HIDDEN` char(1) DEFAULT 'N' COMMENT '是否隐藏 Y表示隐藏 N表示显示',
  PRIMARY KEY (`MODULE_ID`),
  UNIQUE KEY `IDX_MODULE` (`SYS_CODE`(30),`MODULE_CODE`(30)) USING BTREE,
  KEY `ts_module_ibfk_1` (`PARENT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='功能模块表';

-- ----------------------------
-- Table structure for ts_op_log
-- ----------------------------
DROP TABLE IF EXISTS `ts_op_log`;
CREATE TABLE `ts_op_log` (
  `LOG_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USER_ID` bigint(11) DEFAULT NULL COMMENT '用户id',
  `USER_NAME` varchar(128) DEFAULT '' COMMENT '用户名',
  `USER_EXT_INFO` varchar(128) DEFAULT '' COMMENT '用户附加信息',
  `OP_MODULE` varchar(128) DEFAULT '' COMMENT '操作模块',
  `OP_TYPE` char(8) DEFAULT 'R' COMMENT '操作类型，CRT创建，DEL删除，UPD修改，GET查看，LOGIN 登录，LOGOUT 登出，DATAIN 导入，DATAOUT 导出，OT其他',
  `OP_PARAM` varchar(1024) DEFAULT '' COMMENT '操作参数',
  `OP_CONTENT` varchar(1024) DEFAULT '' COMMENT '操作内容',
  `OP_HOST_NAME` varchar(128) DEFAULT '' COMMENT '操作者主机名',
  `OP_IP` bigint(11) DEFAULT '0' COMMENT '操作者ip ，ip2long',
  `OP_TM` timestamp NULL DEFAULT NULL COMMENT '操作时间',
  `SERVICE_IP` bigint(11) DEFAULT '0' COMMENT '提供服务，机器ip ,ip2long',
  `SOURCE` char(4) DEFAULT 'W' COMMENT '操作来源，W-web，A-android，S-ios,X-weixin',
  `MEMO` varchar(1024) DEFAULT '' COMMENT '备注',
  `EXT1` varchar(128) DEFAULT '' COMMENT '扩展用',
  `EXT2` varchar(128) DEFAULT '' COMMENT '扩展用',
  `EXT3` varchar(128) DEFAULT '' COMMENT '扩展用',
  PRIMARY KEY (`LOG_ID`),
  KEY `idx_tm_operator_type` (`OP_TM`,`USER_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志表';

-- ----------------------------
-- Table structure for ts_role
-- ----------------------------
DROP TABLE IF EXISTS `ts_role`;
CREATE TABLE `ts_role` (
  `ROLE_ID` bigint(18) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `ROLE_CODE` varchar(100) NOT NULL COMMENT '代码，英文数字下划线组成',
  `ROLE_NAME` varchar(300) DEFAULT NULL COMMENT '名称，默认用于展示的文字',
  `ROLE_DESC` varchar(1200) DEFAULT NULL COMMENT '描述文字',
  `ROLE_TYPE` tinyint(3) unsigned NOT NULL COMMENT '角色类型：1.ADMIN角色，2.子管理员角色 ，3.普通角色；',
  `SYS_FLAG` tinyint(1) unsigned DEFAULT '0' COMMENT '是否内置角色：0否，1是 ',
  `STATUS` tinyint(1) unsigned NOT NULL COMMENT '状态：无效0，有效1',
  `sys_id` int(11) NOT NULL,
  `CREATOR_USER` varchar(30) DEFAULT NULL COMMENT '创建者用户账号',
  `CREATE_TM` datetime DEFAULT NULL COMMENT '创建时间',
  `MODIFIER_USER` varchar(30) DEFAULT NULL COMMENT '更新者用户账号',
  `MODIFY_TM` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ROLE_ID`),
  UNIQUE KEY `ROLE_CODE` (`ROLE_CODE`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Table structure for ts_role_module
-- ----------------------------
DROP TABLE IF EXISTS `ts_role_module`;
CREATE TABLE `ts_role_module` (
  `ROLE_ID` bigint(18) unsigned NOT NULL COMMENT '角色ID',
  `MODULE_ID` bigint(18) unsigned NOT NULL COMMENT '功能模块ID',
  `MODIFIER_USER` varchar(30) DEFAULT NULL COMMENT '更新者用户账号',
  `MODIFY_TM` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ROLE_ID`,`MODULE_ID`),
  KEY `MODULE_ID` (`MODULE_ID`) USING BTREE,
  CONSTRAINT `ts_role_module_ibfk_1` FOREIGN KEY (`ROLE_ID`) REFERENCES `ts_role` (`ROLE_ID`) ON DELETE CASCADE,
  CONSTRAINT `ts_role_module_ibfk_2` FOREIGN KEY (`MODULE_ID`) REFERENCES `ts_module` (`MODULE_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色功能关联表';

-- ----------------------------
-- Table structure for ts_user
-- ----------------------------
DROP TABLE IF EXISTS `ts_user`;
CREATE TABLE `ts_user` (
  `USER_ID` bigint(18) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `USERNAME` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '登录名/账号',
  `TYPE_CODE` tinyint(1) NOT NULL COMMENT '用户类型编码 1-域用户账号 0-非域用户账号',
  `PWD` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '密码，仅在自己校验是保存密码',
  `PWD_MODIFY_TM` date DEFAULT NULL COMMENT '密码修改时间',
  `sys_id` int(11) NOT NULL COMMENT '系统ID',
  `STATUS` tinyint(1) unsigned NOT NULL COMMENT '状态：无效0，有效1',
  `ACTIVE_TM` date DEFAULT NULL COMMENT '启用时间',
  `DEACTIVE_TM` date DEFAULT NULL COMMENT '停用时间',
  `MODIFIER_USER` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新者用户账号',
  `MODIFY_TM` datetime DEFAULT NULL COMMENT '更新时间',
  `CREATOR_USER` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建者用户账号',
  `CREATE_TM` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `USERNAME` (`USERNAME`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Table structure for ts_user_dept
-- ----------------------------
DROP TABLE IF EXISTS `ts_user_dept`;
CREATE TABLE `ts_user_dept` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `sys_id` int(11) DEFAULT NULL COMMENT '系统ID',
  `USER_NAME` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户名',
  `DEPT_CODE` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '网点代码',
  `CREATE_EMP` varchar(16) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `CREATE_TM` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`),
  KEY `IDX_USER_ROLE_UID` (`USER_NAME`),
  KEY `IDX_TS_USER_DEPT_01` (`DEPT_CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=498626 DEFAULT CHARSET=utf8mb4 COMMENT='用户网点对应表';

-- ----------------------------
-- Table structure for ts_user_role
-- ----------------------------
DROP TABLE IF EXISTS `ts_user_role`;
CREATE TABLE `ts_user_role` (
  `USER_ROLE_ID` bigint(18) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` bigint(18) unsigned NOT NULL COMMENT '用户ID',
  `ROLE_ID` bigint(18) unsigned NOT NULL COMMENT '角色ID',
  `IS_DEFAULT` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否默认角色：1是 0否',
  `SYS_CODE` varchar(100) NOT NULL DEFAULT '*' COMMENT '系统编码，当是默认角色时，可指定系统编码',
  `EXP_DATE` date DEFAULT NULL COMMENT '过期日期，有效期至',
  `MODIFIER_USER` varchar(30) DEFAULT NULL COMMENT '更新者用户账号',
  `MODIFY_TM` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`USER_ROLE_ID`),
  KEY `ts_user_role_ibfk_2` (`ROLE_ID`) USING BTREE,
  KEY `ts_user_role_ibfk_3` (`USER_ID`,`ROLE_ID`,`SYS_CODE`) USING BTREE,
  CONSTRAINT `ts_user_role_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `ts_user` (`USER_ID`) ON DELETE CASCADE,
  CONSTRAINT `ts_user_role_ibfk_2` FOREIGN KEY (`ROLE_ID`) REFERENCES `ts_role` (`ROLE_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8 COMMENT='用户角色关联表';

-- ----------------------------
-- Table structure for tt_grs_month_recovery
-- ----------------------------
DROP TABLE IF EXISTS `tt_grs_month_recovery`;
CREATE TABLE `tt_grs_month_recovery` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增长',
  `PLAN_DT` date DEFAULT NULL COMMENT '排班日期',
  `EMP_CODE` varchar(30) DEFAULT NULL COMMENT '工号',
  `GROUP_CODE` varchar(30) DEFAULT NULL COMMENT '组号',
  `DEPT_CODE` varchar(30) DEFAULT NULL COMMENT '服务中转场代码',
  `SUPP_CODE` varchar(30) DEFAULT NULL COMMENT '供应商编码',
  `PLAN_CODE` varchar(8) DEFAULT NULL COMMENT '班次名称',
  `PLAN_BEGIN_TM` char(4) DEFAULT NULL COMMENT '班次开始时间',
  `PLAN_END_TM` char(4) DEFAULT NULL COMMENT '班次结束时间',
  `WORK_BEGIN_TM` datetime DEFAULT NULL COMMENT '上班打卡时间',
  `WORK_END_TM` datetime DEFAULT NULL COMMENT '下班打卡时间',
  `WORK_PROC_CODE` varchar(30) DEFAULT NULL COMMENT '工序',
  `GOLD_RATIO` decimal(6,2) DEFAULT NULL COMMENT '工序含金量',
  `WORK_TYPE` tinyint(1) DEFAULT NULL COMMENT '班次类型1正常班，0休息班',
  `PLAN_TYPE` char(2) NOT NULL COMMENT '01人员排班，02资源排班',
  `ERROR_FLAG` tinyint(4) DEFAULT NULL COMMENT '0正常，1异常',
  `SYSTEM_OWNERSHIP` varchar(20) NOT NULL COMMENT '系统归属，SAP/PMP',
  `ADJUST_SUPP_CODE` varchar(30) DEFAULT NULL COMMENT '调整后的机构（手动）',
  `ADJUST_PLAN_CODE` varchar(8) DEFAULT NULL COMMENT '调整后的班次（手动）',
  `ADJUST_REASON` varchar(100) DEFAULT NULL COMMENT '调整原因',
  `CREATED_TM` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATED_EMP_CODE` varchar(30) DEFAULT NULL COMMENT '创建人工号',
  `MODIFIED_TM` datetime DEFAULT NULL COMMENT '修改时间',
  `MODIFIED_EMP_CODE` varchar(30) DEFAULT NULL COMMENT '修改人工号',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_tt_grs_month_recovery_01` (`PLAN_DT`,`EMP_CODE`),
  KEY `idx_tt_grs_month_recovery_02` (`DEPT_CODE`),
  KEY `idx_tt_grs_month_recovery_03` (`EMP_CODE`),
  KEY `idx_tt_grs_month_recovery_04` (`SUPP_CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8 COMMENT='打卡还原记录表(正式表)';

-- ----------------------------
-- Table structure for tt_grs_month_recovery_detail
-- ----------------------------
DROP TABLE IF EXISTS `tt_grs_month_recovery_detail`;
CREATE TABLE `tt_grs_month_recovery_detail` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增长',
  `PLAN_DT` date DEFAULT NULL COMMENT '排班日期',
  `WORK_DT` date DEFAULT NULL COMMENT '上班日期，跨天上班的时候需要加1天',
  `EMP_CODE` varchar(30) DEFAULT NULL COMMENT '工号',
  `DEPT_CODE` varchar(30) DEFAULT NULL COMMENT '服务中转场代码',
  `SUPP_CODE` varchar(30) DEFAULT NULL COMMENT '供应商编码',
  `PLAN_CODE` varchar(8) DEFAULT NULL COMMENT '班次名称',
  `WORK_TYPE` tinyint(1) DEFAULT NULL COMMENT '班次类型1正常班，0休息班',
  `PLAN_BEGIN_TM` char(4) DEFAULT NULL COMMENT '班次开始时间',
  `PLAN_END_TM` char(4) DEFAULT NULL COMMENT '班次结束时间',
  `IS_SKIP_DAY` tinyint(1) DEFAULT NULL COMMENT '是否跨天 1是0否',
  `SYSTEM_OWNERSHIP` varchar(20) NOT NULL COMMENT '系统归属，SAP/PMP',
  `CREATED_TM` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATED_EMP_CODE` varchar(30) DEFAULT NULL COMMENT '创建人工号',
  `MODIFIED_TM` datetime DEFAULT NULL COMMENT '修改时间',
  `MODIFIED_EMP_CODE` varchar(30) DEFAULT NULL COMMENT '修改人工号',
  PRIMARY KEY (`ID`),
  KEY `idx_tt_grs_month_recovery_detail_01` (`DEPT_CODE`),
  KEY `idx_tt_grs_month_recovery_detail_02` (`EMP_CODE`),
  KEY `idx_tt_grs_month_recovery_detail_03` (`SUPP_CODE`),
  KEY `idx_tt_grs_month_recovery_detail_04` (`PLAN_DT`,`EMP_CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=320 DEFAULT CHARSET=utf8 COMMENT='打卡还原明细记录表(正式表)';

-- ----------------------------
-- Table structure for tt_grs_month_res_need
-- ----------------------------
DROP TABLE IF EXISTS `tt_grs_month_res_need`;
CREATE TABLE `tt_grs_month_res_need` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增长',
  `sys_id` int(11) NOT NULL COMMENT '系统ID',
  `DEPT_CODE` varchar(30) NOT NULL COMMENT '所属编码',
  `PLAN_CODE` char(8) NOT NULL COMMENT '班次编码',
  `YEARMONTH` char(6) NOT NULL COMMENT '年月',
  `PLAN_DT` date NOT NULL COMMENT '排班日期',
  `SUPP_CODE` varchar(30) NOT NULL COMMENT '机构ID（自有则存入NULL）',
  `PLAN_TYPE` char(2) NOT NULL COMMENT '01人员排班，02资源排班',
  `RES_NEED` int(4) NOT NULL COMMENT '人力需求',
  `CREATED_TM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATED_EMP_CODE` varchar(30) NOT NULL COMMENT '创建人',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_tt_grs_month_res_need_01` (`sys_id`,`DEPT_CODE`,`PLAN_CODE`,`PLAN_DT`,`SUPP_CODE`,`PLAN_TYPE`),
  KEY `idx_tt_grs_month_res_need_02` (`sys_id`,`YEARMONTH`),
  KEY `idx_tt_grs_month_res_need_04` (`sys_id`,`DEPT_CODE`,`PLAN_CODE`),
  KEY `idx_tt_grs_month_res_need_03` (`sys_id`,`SUPP_CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=2472 DEFAULT CHARSET=utf8 COMMENT='月度人力需求';

-- ----------------------------
-- Table structure for tt_grs_month_schedule
-- ----------------------------
DROP TABLE IF EXISTS `tt_grs_month_schedule`;
CREATE TABLE `tt_grs_month_schedule` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增长',
  `sys_id` int(11) NOT NULL COMMENT '系统ID',
  `DEPT_CODE` varchar(30) NOT NULL COMMENT '所属编码',
  `PLAN_CODE` varchar(8) NOT NULL COMMENT '班次编码',
  `YEARMONTH` char(6) NOT NULL COMMENT '年月',
  `PLAN_DT` date NOT NULL COMMENT '排班日期',
  `SUPP_CODE` varchar(30) NOT NULL COMMENT '机构ID（当是外包员工的时候，才有供应商ID）',
  `EMP_CODE` varchar(30) NOT NULL COMMENT '工号',
  `CREATED_TM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATED_EMP_CODE` varchar(30) NOT NULL COMMENT '创建人',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_tt_grs_month_schedule_01` (`sys_id`,`DEPT_CODE`,`PLAN_CODE`,`PLAN_DT`,`EMP_CODE`),
  KEY `idx_tt_grs_month_schedule_02` (`sys_id`,`YEARMONTH`),
  KEY `idx_tt_grs_month_schedule_03` (`sys_id`,`EMP_CODE`),
  KEY `idx_tt_grs_month_schedule_04` (`sys_id`,`PLAN_DT`)
) ENGINE=InnoDB AUTO_INCREMENT=2228 DEFAULT CHARSET=utf8 COMMENT='人员排班月度计划';

-- ----------------------------
-- Table structure for tt_op_month_recovery
-- ----------------------------
DROP TABLE IF EXISTS `tt_op_month_recovery`;
CREATE TABLE `tt_op_month_recovery` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增长',
  `PLAN_DT` date DEFAULT NULL COMMENT '排班日期',
  `EMP_CODE` varchar(30) DEFAULT NULL COMMENT '工号',
  `GROUP_CODE` varchar(30) DEFAULT NULL COMMENT '组号',
  `DEPT_CODE` varchar(30) DEFAULT NULL COMMENT '服务中转场代码',
  `SUPP_CODE` varchar(30) DEFAULT NULL COMMENT '供应商编码',
  `PLAN_CODE` varchar(8) DEFAULT NULL COMMENT '班次编码',
  `IS_DELETED` tinyint(1) DEFAULT '0' COMMENT '是否无效，1是，0否',
  `PLAN_BEGIN_TM` char(4) DEFAULT NULL COMMENT '班次开始时间',
  `PLAN_END_TM` char(4) DEFAULT NULL COMMENT '班次结束时间',
  `WORK_BEGIN_TM` datetime DEFAULT NULL COMMENT '上班打卡时间',
  `WORK_END_TM` datetime DEFAULT NULL COMMENT '下班打卡时间',
  `WORK_PROC_CODE` varchar(30) DEFAULT NULL COMMENT '工序',
  `GOLD_RATIO` decimal(6,2) DEFAULT NULL COMMENT '工序含金量',
  `WORK_TYPE` tinyint(1) DEFAULT NULL COMMENT '班次类型1正常班，0休息班',
  `PLAN_TYPE` char(2) NOT NULL COMMENT '01人员排班，02资源排班',
  `ERROR_FLAG` tinyint(4) DEFAULT NULL COMMENT '0正常，1异常',
  `SYSTEM_OWNERSHIP` varchar(20) NOT NULL COMMENT '系统归属，SAP/PMP',
  `ADJUST_SUPP_CODE` varchar(30) DEFAULT NULL COMMENT '调整后的机构（手动）',
  `ADJUST_PLAN_CODE` varchar(8) DEFAULT NULL COMMENT '调整后的班次（手动）',
  `ADJUST_REASON` varchar(100) DEFAULT NULL COMMENT '调整原因',
  `SYSTEM_SOURCE` varchar(30) NOT NULL DEFAULT 'EOS-GRS-CORE' COMMENT '系统来源，默认EOS-GRS-CORE',
  `PROCESS_NO` varchar(100) NOT NULL COMMENT '生成批次号',
  `CREATED_TM` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATED_EMP_CODE` varchar(30) DEFAULT NULL COMMENT '创建人工号',
  `MODIFIED_TM` datetime DEFAULT NULL COMMENT '修改时间',
  `MODIFIED_EMP_CODE` varchar(30) DEFAULT NULL COMMENT '修改人工号',
  PRIMARY KEY (`ID`),
  KEY `idx_tt_op_month_recovery_01` (`DEPT_CODE`,`PLAN_CODE`),
  KEY `idx_tt_op_month_recovery_02` (`EMP_CODE`),
  KEY `idx_tt_op_month_recovery_03` (`SUPP_CODE`),
  KEY `idx_tt_op_month_recovery_05` (`PROCESS_NO`),
  KEY `idx_tt_op_month_recovery_04` (`PLAN_DT`)
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8 COMMENT='打卡还原记录表';

-- ----------------------------
-- Table structure for tt_op_month_recovery_detail
-- ----------------------------
DROP TABLE IF EXISTS `tt_op_month_recovery_detail`;
CREATE TABLE `tt_op_month_recovery_detail` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增长',
  `PLAN_DT` date DEFAULT NULL COMMENT '排班日期',
  `WORK_DT` date DEFAULT NULL COMMENT '上班日期，跨天上班的时候需要加1天',
  `EMP_CODE` varchar(30) DEFAULT NULL COMMENT '工号',
  `DEPT_CODE` varchar(30) DEFAULT NULL COMMENT '服务中转场代码',
  `SUPP_CODE` varchar(30) DEFAULT NULL COMMENT '供应商编码',
  `PLAN_CODE` varchar(8) DEFAULT NULL COMMENT '班次编码',
  `WORK_TYPE` tinyint(1) DEFAULT NULL COMMENT '班次类型1正常班，0休息班',
  `PLAN_BEGIN_TM` char(4) DEFAULT NULL COMMENT '班次开始时间',
  `PLAN_END_TM` char(4) DEFAULT NULL COMMENT '班次结束时间',
  `IS_SKIP_DAY` tinyint(1) DEFAULT NULL COMMENT '是否跨天 1是0否',
  `IS_DELETED` tinyint(1) DEFAULT '0' COMMENT '是否无效，1是，0否',
  `SYSTEM_OWNERSHIP` varchar(20) NOT NULL COMMENT '系统归属，SAP/PMP',
  `SYSTEM_SOURCE` varchar(30) NOT NULL DEFAULT 'EOS-GRS-CORE' COMMENT '系统来源，默认EOS-GRS-CORE',
  `PROCESS_NO` varchar(100) DEFAULT NULL COMMENT 'ETL抽取批次号',
  `CREATED_TM` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATED_EMP_CODE` varchar(30) DEFAULT NULL COMMENT '创建人工号',
  `MODIFIED_TM` datetime DEFAULT NULL COMMENT '修改时间',
  `MODIFIED_EMP_CODE` varchar(30) DEFAULT NULL COMMENT '修改人工号',
  PRIMARY KEY (`ID`),
  KEY `idx_tt_op_month_recovery_detail_01` (`DEPT_CODE`,`PLAN_CODE`),
  KEY `idx_tt_op_month_recovery_detail_02` (`EMP_CODE`),
  KEY `idx_tt_op_month_recovery_detail_03` (`SUPP_CODE`),
  KEY `idx_tt_op_month_recovery_detail_04` (`PLAN_DT`,`EMP_CODE`),
  KEY `idx_tt_op_month_recovery_detail_05` (`PROCESS_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=359 DEFAULT CHARSET=utf8 COMMENT='打卡还原明细记录表';

-- ----------------------------
-- Table structure for tt_system_job
-- ----------------------------
DROP TABLE IF EXISTS `tt_system_job`;
CREATE TABLE `tt_system_job` (
  `SYSTEM_JOB_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ACCOUNT_CODE` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '账号代码(收派员工号、客户卡号)',
  `DEPT_CODE` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '网点代码',
  `START_DT` date DEFAULT NULL COMMENT '开始时间',
  `END_DT` date DEFAULT NULL COMMENT '结束时间',
  `STATUS` int(1) DEFAULT NULL COMMENT '-1：待处理。0：处理中。1：处理失败 2：处理成功',
  `JOB_RESULT` varchar(4000) CHARACTER SET utf8 DEFAULT NULL COMMENT '任务处理结果描述',
  `START_RUN_TM` datetime DEFAULT NULL COMMENT '任务执行开始时间',
  `END_RUN_TM` datetime DEFAULT NULL COMMENT '任务执行结束时间',
  `DEAL_COUNT` int(1) DEFAULT '0' COMMENT '任务处理失败次数',
  `HANDLE_NAME` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '任务处理类',
  `STRAT_HANDLE_TM` datetime DEFAULT NULL COMMENT '任务计划开始处理时间',
  `SERVER_IP` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '任务执行IP地址',
  `DATE_TYPE` int(1) DEFAULT NULL COMMENT '查询日期类型 ：0：营业收入时间 1：账单日期',
  `HANDLE_TYPE` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '任务处理源类型',
  `CREATE_TM` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATE_EMP_CODE` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人工号',
  `LOCAL_FILE` varchar(500) CHARACTER SET utf8 DEFAULT NULL COMMENT '文件完整地址',
  `PROCESS_NO` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '批次号',
  `EXT1` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '扩展字段1',
  `EXT2` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '扩展字段2',
  `EXT3` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`SYSTEM_JOB_ID`),
  KEY `IDX_SYSTEM_JOB_01` (`HANDLE_TYPE`),
  KEY `IDX_SYSTEM_JOB_02` (`STATUS`),
  KEY `IDX_SYSTEM_JOB_03` (`PROCESS_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=329 DEFAULT CHARSET=utf8mb4 COMMENT='系统任务表';

-- ----------------------------
-- Procedure structure for insert_sys
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_sys`;
DELIMITER ;;
CREATE DEFINER=`grss`@`%` PROCEDURE `insert_sys`()
BEGIN
	DECLARE i INT DEFAULT 0;
	WHILE i < 6000
	DO
		INSERT INTO `tm_system` (`sys_name`, `sys_describe`, `create_user`, `creatd_tm`, `is_deleted`, `modify_user`, `modify_tm`) VALUES ( 'test12', 'haha_edit', '166046', '2018-02-27 18:12:42', '1', '166046', '2018-02-27 18:12:42');
		SET i = i+1;
  END WHILE;
	COMMIT;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prc_insert_tl_grs_user_his
-- ----------------------------
DROP PROCEDURE IF EXISTS `prc_insert_tl_grs_user_his`;
DELIMITER ;;
CREATE DEFINER=`grss`@`%` PROCEDURE `prc_insert_tl_grs_user_his`()
BEGIN
	#程序运行位置
	DECLARE v_line TINYINT DEFAULT 0;
	DECLARE v_yesterday DATE;
	#异常处理
	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
		#先回滚,结束主事务
		ROLLBACK ;
		#记录日志
		CALL prc_utils_stp_running_log('prc_insert_tl_grs_user_his','prc_insert_tl_grs_user_his',NOW(),'ERROR','','ERROR','',v_line);
		COMMIT ;
	END;

	SELECT DATE_SUB(CURRENT_DATE,INTERVAL 1 DAY) INTO v_yesterday;
	SET v_line = 1;
	#备份小组
	DELETE FROM tl_grs_user_group WHERE PLAN_DT < DATE_SUB(CURDATE(), INTERVAL 60 DAY); #删除60天前的数据
	
	SET v_line = 2;
	DELETE FROM tl_grs_user_group WHERE PLAN_DT = v_yesterday; #删除昨天的数据
	
	SET v_line = 3;
	#备份昨天的组号数据
	INSERT INTO 
	tl_grs_user_group(
		EMP_CODE,
		PLAN_DT,
		GROUP_CODE,
		CREATED_TM,
		CREATED_EMP_CODE,
		RECORD_CREATED_TM
	) SELECT 
		EMP_CODE,
		v_yesterday,
		GROUP_CODE,
		NOW(),
		CREATED_EMP_CODE,
		CREATED_TM 
	FROM 
		tm_grs_group_emp;

  #备份员工系统归属
	SET v_line = 4;
	DELETE FROM tl_grs_user_ownership WHERE PLAN_DT <DATE_SUB(CURDATE(), INTERVAL 60 DAY); #删除60天前的数据
	SET v_line = 5;
	DELETE FROM tl_grs_user_ownership WHERE PLAN_DT = v_yesterday; #删除昨天的数据
	#备份
	SET v_line = 6;
	INSERT INTO 
	tl_grs_user_ownership(
		EMP_CODE, 
		SYSTEM_OWNERSHIP, 
		PLAN_DT, 
		CREATED_TM
	) select 
		emp_num,
		system_ownership,
		v_yesterday,
		NOW() 
	from 
		tm_employee 
	WHERE 
		system_ownership IN('PMP','SAP') 
	GROUP BY 
		emp_num;
	
	#生成班次还原定时任务
	SET v_line = 7;
	DELETE FROM tl_op_recovery_task_data  WHERE  PLAN_DT< DATE_SUB(CURDATE(), INTERVAL 60 DAY); #删除60天以前的数据
	SET v_line = 8;
  DELETE FROM tl_op_recovery_task_data  WHERE  PLAN_DT= v_yesterday; #删除昨天的数据

	SET v_line = 9;
	#插入批次号详情表
	INSERT INTO 
	tl_op_recovery_task_data(
		PROCESS_NO,
		EMP_CODE,
		PLAN_DT,
		CREATED_EMP
	) SELECT 
		CONCAT(DATE_FORMAT(v_yesterday,'%Y%m%d'),'_',MOD(MAX(S.ID),100)) PROCESS_NO,
		S.EMP_CODE,
		v_yesterday,
		'SYSTEM'
	FROM 
		tt_grs_month_schedule S 
	WHERE 
		S.PLAN_DT = v_yesterday
	GROUP BY 
		S.EMP_CODE;

	#插入记录到系统任务表
	SET v_line = 10;
	INSERT INTO tt_system_job(
		DEPT_CODE,
		START_DT,
		`STATUS`,
		HANDLE_NAME,
		STRAT_HANDLE_TM,
		HANDLE_TYPE,
		DATE_TYPE,
		CREATE_TM,
		CREATE_EMP_CODE
	)SELECT
		T.PROCESS_NO DEPT_CODE,
		T.PLAN_DT START_DT,
		-1 `STATUS`,
		'monthRecoveryBiz' HANDLE_NAME,
		NOW() STRAT_HANDLE_TM,
		'monthRecoveryTask' HANDLE_TYPE,
		0 DATE_TYPE,
		NOW() CREATE_TM,
		'EMP_01' CREATE_EMP_CODE
	FROM tl_op_recovery_task_data T
	WHERE 
		T.PLAN_DT= v_yesterday
	GROUP BY 
		T.PROCESS_NO;
	COMMIT;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prc_utils_stp_running_log
-- ----------------------------
DROP PROCEDURE IF EXISTS `prc_utils_stp_running_log`;
DELIMITER ;;
CREATE DEFINER=`grss`@`%` PROCEDURE `prc_utils_stp_running_log`(
	IN `P_PACKAGE_NAME` VARCHAR(120),
	IN `P_PROC_NAME`    VARCHAR(120),
	IN `P_EXCEP_DT`     TIMESTAMP,
	IN `P_EXCU_STATUS`	VARCHAR(32),
	IN `P_EXCEP_CODE`   VARCHAR(60),
	IN `P_EXCEP_DESC`   VARCHAR(1000),
	IN `P_EXCEP_REMK`   VARCHAR(600),
	IN `P_LINE_NO`      INT)
BEGIN       
	INSERT INTO TL_EXCEPTION_LOG
		(
		 package_name,
		 procedure_name,
		 exception_tm,
		 excu_status,
		 exception_code,
		 exception_desc,
		 exception_remk,
		 line_no)
	VALUES
		(
		 SUBSTR(`P_PACKAGE_NAME`, 1, 120),
		 SUBSTR(`P_PROC_NAME`, 1, 120),
		 `P_EXCEP_DT`,
		 UCASE(SUBSTR(`P_EXCU_STATUS`, 1, 32)),
		 SUBSTR(`P_EXCEP_CODE`, 1, 60),
		 SUBSTR(`P_EXCEP_DESC`, 1, 1000),
		 SUBSTR(`P_EXCEP_REMK`, 1, 600),
		 `P_LINE_NO`);
   END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for insert_tl_grs_user_his
-- ----------------------------
DROP EVENT IF EXISTS `insert_tl_grs_user_his`;
DELIMITER ;;
CREATE DEFINER=`grss`@`%` EVENT `insert_tl_grs_user_his` ON SCHEDULE EVERY 1 DAY STARTS '2018-04-13 00:00:00' ON COMPLETION PRESERVE ENABLE COMMENT '备份中转场小组人员信息' DO CALL prc_insert_tl_grs_user_his()
;;
DELIMITER ;
