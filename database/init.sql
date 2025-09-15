-- 电影评分系统数据库初始化脚本

-- 创建数据库
CREATE DATABASE IF NOT EXISTS film_rating_system 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE film_rating_system;

-- 用户表
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码(加密后)',
  `phone` varchar(20) NOT NULL COMMENT '手机号',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `gender` tinyint DEFAULT NULL COMMENT '性别: 0-女, 1-男',
  `age` int DEFAULT NULL COMMENT '年龄',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像URL',
  `status` tinyint DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`),
  UNIQUE KEY `uk_phone` (`phone`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- 电影表
CREATE TABLE `movies` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(200) NOT NULL COMMENT '电影标题',
  `title_en` varchar(200) DEFAULT NULL COMMENT '英文标题',
  `director` varchar(100) DEFAULT NULL COMMENT '导演',
  `actors` text COMMENT '主演',
  `genre` varchar(100) DEFAULT NULL COMMENT '类型',
  `release_date` date DEFAULT NULL COMMENT '上映日期',
  `duration` int DEFAULT NULL COMMENT '时长(分钟)',
  `country` varchar(50) DEFAULT NULL COMMENT '制片国家',
  `language` varchar(50) DEFAULT NULL COMMENT '语言',
  `poster_url` varchar(255) DEFAULT NULL COMMENT '海报URL',
  `synopsis` text COMMENT '剧情简介',
  `rating_avg` decimal(3,1) DEFAULT 0.0 COMMENT '平均评分',
  `rating_count` int DEFAULT 0 COMMENT '评分人数',
  `status` tinyint DEFAULT 1 COMMENT '状态: 0-下架, 1-上架',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_title` (`title`),
  KEY `idx_genre` (`genre`),
  KEY `idx_rating` (`rating_avg`),
  KEY `idx_status` (`status`),
  KEY `idx_release_date` (`release_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='电影表';

-- 评分表
CREATE TABLE `ratings` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `movie_id` bigint NOT NULL COMMENT '电影ID',
  `rating` decimal(2,1) NOT NULL COMMENT '评分(1.0-10.0)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_movie` (`user_id`, `movie_id`),
  KEY `idx_movie_id` (`movie_id`),
  KEY `idx_rating` (`rating`),
  CONSTRAINT `fk_ratings_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ratings_movie` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评分表';

-- 评论表
CREATE TABLE `comments` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `movie_id` bigint NOT NULL COMMENT '电影ID',
  `content` text NOT NULL COMMENT '评论内容',
  `likes_count` int DEFAULT 0 COMMENT '点赞数',
  `status` tinyint DEFAULT 1 COMMENT '状态: 0-隐藏, 1-显示',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_movie_id` (`movie_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_comments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_comments_movie` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论表';

-- 点赞表
CREATE TABLE `likes` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `comment_id` bigint NOT NULL COMMENT '评论ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_comment` (`user_id`, `comment_id`),
  KEY `idx_comment_id` (`comment_id`),
  CONSTRAINT `fk_likes_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_likes_comment` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='点赞表';