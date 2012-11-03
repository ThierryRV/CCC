-- phpMyAdmin SQL Dump
-- version 3.4.8
-- http://www.phpmyadmin.net
--
-- Client: mysql1
-- Généré le : Mer 24 Octobre 2012 à 19:17
-- Version du serveur: 5.1.39
-- Version de PHP: 5.3.6-11
use ccc_development;

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `ccc_prod`
--

-- --------------------------------------------------------

--
-- Structure de la table `microposts`
--

CREATE TABLE IF NOT EXISTS `microposts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_microposts_on_user_id_and_created_at` (`user_id`,`created_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Structure de la table `relationships`
--

CREATE TABLE IF NOT EXISTS `relationships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `follower_id` int(11) DEFAULT NULL,
  `followed_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_relationships_on_follower_id_and_followed_id` (`follower_id`,`followed_id`),
  KEY `index_relationships_on_follower_id` (`follower_id`),
  KEY `index_relationships_on_followed_id` (`followed_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `relationships`
--

INSERT INTO `relationships` (`id`, `follower_id`, `followed_id`, `created_at`, `updated_at`) VALUES
(2, 3, 1, '2012-09-10 19:33:59', '2012-09-10 19:33:59'),
(3, 1, 2, '2012-09-18 05:50:26', '2012-09-18 05:50:26'),
(4, 1, 3, '2012-09-18 05:50:34', '2012-09-18 05:50:34'),
(5, 1, 4, '2012-09-18 05:50:45', '2012-09-18 05:50:45');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `password_digest` varchar(255) DEFAULT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  KEY `index_users_on_remember_token` (`remember_token`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `created_at`, `updated_at`, `password_digest`, `remember_token`, `admin`) VALUES
(1, 'Herve', 'thierry_herve@yahoo.fr', '2012-07-16 21:06:38', '2012-07-16 21:06:38', '$2a$10$PShKy2k4lyBHUuYuWtlMgOD00gWvxVjdoi0kQgmnetPmZ919O1bpm', '-95XiYIllQ4c1KRn3MvCTw', 0),
(2, 'MAUGER', 'daniel.mauger@free.fr', '2012-07-17 14:38:19', '2012-07-17 14:38:19', '$2a$10$ZobNERpueHw2ATd0ylX8FOcXrVHuPJWUy7SliE4Lg9wDFRua7cd/q', 'y557hGV5SRrf0QB1p64Zww', 0),
(3, 'COCHEZ', 'cochez.patrick@orange.fr', '2012-07-17 16:15:48', '2012-07-17 16:15:48', '$2a$10$5I6lwJr2LmTOIUtKFToSYeuBcT1UgQNYUR8iatvfI4Dto1.cVPFWK', 'IijV9P3rWi5eAfKAoeVHtg', 0),
(4, 'MAREST', 'armel.marest@wanadoo.fr', '2012-07-17 19:13:36', '2012-07-17 19:23:52', '$2a$10$Y2hYtVba1ZrP1ucaa1pQveNQPe0dH3AclPK2F5jK4BD2m3cic.vZe', '-0GvtRi4bf5sckEnRzNt8g', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


