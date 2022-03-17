-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 17 mars 2022 à 20:10
-- Version du serveur :  10.4.14-MariaDB
-- Version de PHP : 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `bodypack`
--

-- --------------------------------------------------------

--
-- Structure de la table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `total_amount` int(11) NOT NULL,
  `is_order` tinyint(1) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cart`
--

INSERT INTO `cart` (`id`, `total_amount`, `is_order`, `user_id`) VALUES
(1, 20, 1, NULL),
(4, 5, 1, NULL),
(5, 88, 1, NULL),
(6, 34, 0, NULL),
(7, 54, 1, NULL),
(8, 680, 1, NULL),
(10, 34, 1, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` int(11) NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adress` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adress_complement` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id`, `first_name`, `last_name`, `phone`, `email`, `adress`, `adress_complement`, `city`, `country`, `zip_code`, `user_id`) VALUES
(1, 'William', 'Bruel', 664411678, 'bruel.william@gmail.com', '5 RUE DE SAINT ÉTIENNE', NULL, 'SAINT HEAND', 'FR', 42570, NULL),
(2, 'William', 'Bruel', 664411678, 'bruel.william@gmail.com', '5 RUE DE SAINT ÉTIENNE', NULL, 'SAINT HEAND', 'FR', 42570, NULL),
(4, 'William', 'Bruel', 664411678, 'bruel.william@gmail.com', '5 RUE DE SAINT ÉTIENNE', NULL, 'SAINT HEAND', 'FR', 42570, NULL),
(5, 'William', 'Bruel', 664411678, 'bruel.william@gmail.com', '5 RUE DE SAINT ÉTIENNE', NULL, 'SAINT HEAND', 'FR', 42570, NULL),
(6, 'William', 'Bruel', 664411678, 'bruel.william@gmail.com', '5 RUE DE SAINT ÉTIENNE', NULL, 'SAINT HEAND', 'FR', 42570, NULL),
(7, 'William', 'Bruel', 664411678, 'bruel.william@gmail.com', '5 RUE DE SAINT ÉTIENNE', NULL, 'SAINT HEAND', 'FR', 42570, NULL),
(8, 'William', 'Bruel', 664411678, 'bruel.william@gmail.com', '5 RUE DE SAINT ÉTIENNE', NULL, 'SAINT HEAND', 'FR', 42570, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `migration_versions`
--

CREATE TABLE `migration_versions` (
  `version` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `executed_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migration_versions`
--

INSERT INTO `migration_versions` (`version`, `executed_at`) VALUES
('20190912074908', '2020-09-16 07:53:21'),
('20190912081931', '2020-09-16 07:53:21'),
('20190912082402', '2020-09-16 07:53:22'),
('20190912090237', '2020-09-16 07:53:22'),
('20190912090848', '2020-09-16 07:53:23'),
('20190912091640', '2020-09-16 07:53:23'),
('20190912091943', '2020-09-16 07:53:23'),
('20190912093424', '2020-09-16 07:53:23'),
('20190912130028', '2020-09-16 07:53:24'),
('20190915161323', '2020-09-16 07:53:24'),
('20190916154828', '2020-09-16 07:53:24'),
('20190916171215', '2020-09-16 07:53:25'),
('20190916201322', '2020-09-16 07:53:25'),
('20190919141152', '2020-09-16 07:53:25'),
('20200916075931', '2020-09-16 07:59:57'),
('20200916104155', '2020-09-16 10:42:08'),
('20200916123733', '2020-09-16 12:37:41'),
('20200916124157', '2020-09-16 12:42:05'),
('20200916124438', '2020-09-16 12:44:47'),
('20200916133541', '2020-09-16 13:35:46'),
('20200916142353', '2020-09-16 14:24:00'),
('20200916144932', '2020-09-16 14:49:38'),
('20200916224539', '2020-09-16 22:45:48'),
('20200916225138', '2020-09-16 22:51:44'),
('20200917075303', '2020-09-17 07:53:14');

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_date` datetime NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_amount` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `orders`
--

INSERT INTO `orders` (`id`, `client_id`, `cart_id`, `payment_method`, `order_date`, `status`, `total_amount`, `user_id`) VALUES
(1, 1, 1, 'unknow', '2020-09-16 15:14:45', 'paid', 20, NULL),
(4, 4, 4, 'unknow', '2020-09-16 16:03:35', 'paid', 5, NULL),
(5, 5, 5, 'unknow', '2020-09-17 19:41:31', 'unpaid', 88, NULL),
(6, 6, 7, 'unknow', '2021-01-28 08:02:56', 'paid', 54, NULL),
(7, 7, 8, 'unknow', '2021-01-28 08:31:01', 'paid', 680, NULL),
(8, 8, 10, 'unknow', '2021-02-03 13:50:12', 'paid', 34, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `order_product`
--

CREATE TABLE `order_product` (
  `id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `order_product`
--

INSERT INTO `order_product` (`id`, `cart_id`, `price`, `quantity`, `product_id`) VALUES
(5, 5, 54, 1, 12),
(6, 5, 34, 1, 10),
(7, 6, 34, 1, 11);

-- --------------------------------------------------------

--
-- Structure de la table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ean` int(11) NOT NULL,
  `sku` int(11) NOT NULL,
  `quantity_stock` int(11) NOT NULL,
  `regular_price` int(11) NOT NULL,
  `reduce_price` int(11) DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_categories_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product`
--

INSERT INTO `product` (`id`, `title`, `description`, `ean`, `sku`, `quantity_stock`, `regular_price`, `reduce_price`, `image`, `product_categories_id`) VALUES
(4, 'Sac Goûter maternelle Abeille', 'Doté d\'un compartiment principal doublé et lavable, avec étiquette porte nom, le sac à goûter Abeille accueillera sans peine le change, les doudous et goûter de votre enfant. Pratique, avec ses bretelles ajustables et sa poignée ergonomique, le sac n\'en est pas moins ludique avec les pieds et les mains de l\'abeille qui bougent au moindre mouvement de votre enfant. Discrètement intégrée au design de ce sac compact, une poche frontale zippée est cachée dans la tête du personnage pour ranger clés, tétines ou tout autre petit objet. Parce que nous savons que la sécurité de vos enfants est primordiale, nous avons intégré dans le design des bandes réfléchissantes sur l\'avant du sac ainsi que sur les bretelles du sac. Fabriqué en polyester eco responsable (sans phtalate, sans cadmium, sans colorant azoique) pour le bien être de notre planète, ce sac très léger d\'un poids plume de 260 grammes se transportera très facilement. Le sac est garanti 3 ans grâce à la garantie \"Product Life\".', 32912300, 3101, 22, 20, NULL, 'assets/img/ProductImages/sacgoutercarreabeillejaune1compartimentbretellereflechissantesetiquettesportnombodypackfaces-5f63182b3f151.jpeg', 1),
(5, 'Sac Goûter maternelle Crocodile', 'Doté d\'un compartiment principal doublé et lavable, avec étiquette porte nom, le sac à goûter Crocodile accueillera sans peine le change, les doudous et goûter de votre enfant. Pratique, avec ses bretelles ajustables et sa poignée ergonomique, le sac n\'en est pas moins ludique avec les pieds et les mains de l\'abeille qui bougent au moindre mouvement de votre enfant. Discrètement intégrée au design de ce sac compact, une poche frontale zippée est cachée dans la tête du personnage pour ranger clés, tétines ou tout autre petit objet. Parce que nous savons que la sécurité de vos enfants est primordiale, nous avons intégré dans le design des bandes réfléchissantes sur l\'avant du sac ainsi que sur les bretelles du sac. Fabriqué en polyester eco responsable (sans phtalate, sans cadmium, sans colorant azoique) pour le bien être de notre planète, ce sac très léger d\'un poids plume de 260 grammes se transportera très facilement. Le sac est garanti 3 ans grâce à la garantie \"Product Life\".', 123329, 3102, 30, 20, NULL, 'assets/img/ProductImages/sacgoutercarrecrocodilevert1compartimentbretellereflechissantesetiquettesportnombodypackfaces-5f631878f212f.jpeg', 1),
(6, 'Cartable 38 cm Folk', 'Ce cartable 38cm BODYPACK a été conçu pour pouvoir transporter toutes les affaires de classe, grâce à ses 2 grands compartiments et sa séparation zippée.Idéal pour un élève en CE1/CE2 il contient facilement les cahiers 21 x 29,7cm et 24x32cm. Pratique avec sa poche volume à l\'avant, et son porte règle, le cartable Folk est également confortable avec un dos moussé ventilé et des bretelles ajustables. Doté d\'un fond renforcé et de parties réfléchissantes, ce cartable Bodypack sera le compagnon idéal de votre enfant pour aller à l\'école.Nous avons veillé à ce que notre sac soit eco responsable, en supprimant de sa composition tout phtalate, tout cadmium, et tout colorant azoique, pour prendre soin de notre planète. Ce sac est garanti 5 ans \"Product Life\" pour que vous ayez l\'esprit tranquille et que vous puissiez l\'utiliser dans la vraie vie.', 329123, 15381, 100, 28, NULL, 'assets/img/ProductImages/cartablescolaire38cmfolkrose2compartimentsdosetbretellesmousseespartiereflechissantesetiquetteportnombodypackface_1_a4fed635b1874dac88b3655b872bf2fa-5f63192723b69.jpeg', 2),
(7, 'Cartable 38 cm Racing Marathon', 'Ce cartable 38cm BODYPACK a été conçu pour pouvoir transporter toutes les affaires de classe, grâce à ses 2 grands compartiments et sa séparation zippée.Idéal pour un élève en CE1/CE2 il contient facilement les cahiers 21 x 29,7cm et 24x32cm. Pratique avec sa poche volume à l\'avant, et son porte règle, le cartable Racing Marathon est également confortable avec un dos moussé ventilé et des bretelles ajustables. Doté d\'un fond renforcé et de parties réfléchissantes, ce cartable Bodypack sera le compagnon idéal de votre enfant pour aller à l\'école.Nous avons veillé à ce que notre sac soit eco responsable, en supprimant de sa composition tout phtalate, tout cadmium, et tout colorant azoique, pour prendre soin de notre planète. Ce sac est garanti 5 ans \"Product Life\" pour que vous ayez l\'esprit tranquille et que vous puissiez l\'utiliser dans la vraie vie.', 329123, 15382, 25, 28, NULL, 'assets/img/ProductImages/cartablescolaire38cmracingmarathonbleuetgris2compartimentsdosetbretellesmousseespartiereflechissantesetiquetteportnombodypackface-5f6319171683e.jpeg', 2),
(8, 'Sac à dos Candytree Vert Bodyadapt', 'D\'une grande capacité ce sac à dos BODYPACK 3 compartiments accueillera tous les cahiers, classeurs, trousses, affaires de musique ou de sport, de votre enfant. Afin de ménager le dos de votre enfant, le sac BODIPAKKU est équipé d\'un dos moussé et ventilé réglable sur 3 positions , ainsi que de bretelles moussées ajustables. Agrémenté de poches latérales pratiques et d\'une poche secrète dans le dos, ce sac possède également un fond renforcé pour protéger son contenu. Léger et stylé, ce sac conçu à la main en tissu déperlant deviendra vite votre compagnon quotidien. Comme nous savons que vous allez le porter longtemps sur le dos, nous avons veillé à ce que notre sac soit le plus eco responsable possible, en supprimant de sa composition tout phtalate, tout cadmium, et tout colorant azoique, pour prendre soin de notre planète. Ce sac est garanti 5 ans \"Product Life\" pour que vous ayez l\'esprit tranquille et que vous puissiez l\'utiliser dans la vraie vie.', 329123, 314, 30, 39, NULL, 'assets/img/ProductImages/sacadosscolairecandytreevertbodypack3compartimentrondpocheslatteraleszipperpochesecreteorganiseretpocheordinateurbrettellereglablesambiance_2-5f6319bcb56fc.jpeg', 4),
(9, 'Sac à dos Bodipakku Mono Bodyadapt', 'D\'une grande capacité ce sac à dos BODYPACK 3 compartiments accueillera tous les cahiers, classeurs, trousses, affaires de musique ou de sport, de votre enfant. Afin de ménager le dos de votre enfant, le sac BODIPAKKU est équipé d\'un dos moussé et ventilé réglable sur 3 positions , ainsi que de bretelles moussées ajustables. Agrémenté de poches latérales pratiques et d\'une poche secrète dans le dos, ce sac possède également un fond renforcé. Léger et stylé, ce sac conçu à la main en tissu déperlant deviendra vite votre compagnon quotidien. Comme nous savons que vous allez le porter longtemps sur le dos, nous avons veillé à ce que notre sac soit le plus eco responsable possible, en supprimant de sa composition tout phtalate, tout cadmium, et tout colorant azoique, pour prendre soin de notre planète. Ce sac est garanti 5 ans \"Product Life\" pour que vous ayez l\'esprit tranquille et que vous puissiez l\'utiliser dans la vraie vie.', 329123, 315, 35, 39, NULL, 'assets/img/ProductImages/sacadosscolairebodipakkugrisbodypack3compartimentrondpocheslatteraleszipperpochesecreteorganiseretpocheordinateurbrettellereglablesface-5f6319f2e8ae0.jpeg', 4),
(10, 'Sac De Sport 45L Nature', 'Le sac de sport format 45Litres Bodypack convient parfaitement à ceux qui souhaitent un sac mixte pouvant être utilisé pour plusieurs sports, en s\'adaptant à vos besoins. Doté d\'un compartiment chaussures de grande capacité et ventilé, vous pourrez facilement isoler vos chaussures du reste de vos affaires. Ce sac offre de nombreux rangements avec ses 3 poches extérieures dont 1 poche zippée. Entièrement doublé le compartiment principal n\'est pas en reste avec une poche intérieure zippée. Facile de prise en main avec sa poignée ergonomique, le sac peut être également transporté sur l\'épaule grâce à sa bandoulière moussée et réglable. Avec son fond renforcé et ses pieds de 2cm, le sac est isolé du sol, ce qui permet de l\'utiliser dans des environnements humides comme la piscine. Avec sa garantie de 10 ans, ce sac tendance fera le bonheur des petits et des grands.', 329123, 3245, 32, 34, NULL, 'assets/img/ProductImages/sacdesportnaturerougeetvert45lcompartimentetanchebodypack_2-5f631a66b455a.jpeg', 6),
(11, 'Sac sport 45L Montagne Bleu', 'Le sac de sport format 45Litres Bodypack convient parfaitement à ceux qui souhaitent un sac mixte pouvant être utilisé pour plusieurs sports, en s\'adaptant à vos besoins. Doté d\'un compartiment chaussures de grande capacité et ventilé, vous pourrez facilement isoler vos chaussures du reste de vos affaires. Ce sac offre de nombreux rangements avec ses 3 poches extérieures dont 1 poche zippée. Entièrement doublé le compartiment principal n\'est pas en reste avec une poche intérieure zippée. Facile de prise en main avec sa poignée ergonomique, le sac peut être également transporté sur l\'épaule grâce à sa bandoulière moussée et réglable. Avec son fond renforcé et ses pieds de 2cm, le sac est isolé du sol, ce qui permet de l\'utiliser dans des environnements humides comme la piscine. Avec sa garantie de 10 ans, ce sac tendance fera le bonheur des petits et des grands.', 329123, 1545, 32, 34, NULL, 'assets/img/ProductImages/sacdesportmontagnebleu45letvertcompartimentetanchebodypack_2-5f631b1a001a5.jpeg', 6),
(12, 'Sac à dos Business recyclé Unix', 'Le sac à dos UNIX est un sac à dos qui s’inscrit dans une démarche éco-responsable. En effet, l’ensemble du tissu utilisé pour ce sac provient de bouteilles en plastiques recyclées RPET. Conçu pour celles et ceux qui travaillent, le sac Unix Bodypack est un sac multifonctions qui peut être utilisé au quotidien ou pour une balade grâce à son dos moussé ventilé et renforcé en EVA qui vous assure un confort optimal. Doté d’un port USB accessible sur le côté du sac, vous restez connectés tout au long de vos trajets. Le compartiment ordinateur est protégé par zip étanche et moussé pour accueillir une tablette ou un ordinateur allant jusqu\'à 15.6\". Les crochets antivols vous permettront de sentir toute tentative d\'ouverture de votre sac pendant que vous êtes dans la rue ou les transports en commun. Une poche secrète dans le dos du sac anti-RFID vous permet également d’emporter votre portefeuille en toute sécurité. Compact, pratique, résistant, le sac à dos ordinateur et port USB Unix sera le compagnon idéal de votre mobilité quotidienne, et il est garanti 10 ans.', 329123, 5330, 88, 54, NULL, 'assets/img/ProductImages/sacadosordinateurbusiness2compartimentportusborganiserantirfidbodypack-5f631bbb35558.jpeg', 8),
(13, 'Sac à dos Business Daily', 'Le daily est le descendant d\'une longue lignée de sacs business produits par Bodypack. Best seller de notre gamme business le format du sac daily est pensé pour celles et ceux qui se rendent quotidiennement au travail. Doté d\'un dos en EVA confortablement rembourré et de bretelles ajustables, vous ne sentez pas le poids de votre sac lors que vous marchez. Avec son tissu déperlant eco responsable et son fond renforcé, votre sac Bodypack Daily sera à l\'aise aussi bien en intérieur qu\'en extérieur. Faciles d\'accès, l\'ensemble de ses nombreux compartiments vous permettront de ranger l\'ensemble de vos affaires personnelles comme professionnelles (clés, portefeuille, cahiers, classeurs...). Son compartiment moussé situé à l\'intérieur du sac peut accueillir une tablette ou un ordinateur de grande taille jusqu\'à 15,6\". Enfin, les crochets antivol situés sur le côté du sac sécuriseront les poches de votre sac pendant que vous voyagez dans les transports en commun. garanti 10 ans, le sac Daily est conçu à l\'épreuve du temps.', 329123, 5420, 54, 52, NULL, 'assets/img/ProductImages/sacadosordinateurdailybusiness2compartimentportusborganiserantirfidbodypack-5f631bf8bcd50.jpeg', 8);

-- --------------------------------------------------------

--
-- Structure de la table `product_categories`
--

CREATE TABLE `product_categories` (
  `id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_categories`
--

INSERT INTO `product_categories` (`id`, `title`, `description`, `image`) VALUES
(1, 'Maternelle', 'Quelle aventure que la rentrée en maternelle ! Pour accompagner les tout-petits dans cette étape, Bodypack a crée toute une gamme de sacs maternelles, ou sacs goûter, spécialement pensés pour les enfants agés de 2 à 5 ans. Dotés de grands compartiments principaux, et pour certains modèles de poches supplémentaires, ces sacs peuvent acceuillir le doudou, le carnet de liaison, le goûter, et toutes le petites affaires nécéssaires à nos enfants pour aller à la maternelle ou chez la nounou. Ludiques, ils représentent ou incluent d\'adorables animaux pour en faire le compagnon idéal des petits. Par ailleurs, parce que nous savons que la sécurité de vos enfants est primordiale, nous avons intégré dans le design des bandes réfléchissantes sur l\'avant du sac ainsi que sur les bretelles du sac, afin d\'être bien visible dans la rue. Afin d\'assurer le confort des enfants, les sacs maternelle Bodypack sont très légers et équipés de bretelles moussées et réglables permettant d\'ajuster le sac à aux épaules et au dos des jeunes enfants, ainsi qu\'une poignée de petite taille, adaptée à leurs petites mains. Pour aller plus loin et entretenir la planète qui nous abrite, nous nous engageons à planter un arbre pour chaque sac ou cartable acheté sur notre site. Bodypack à chacun son sac !', ''),
(2, 'Primaire', 'Etre bien équipé pour bien démarrer à l\'école est essentiel. Depuis près de 20 ans nous développons en France des sacs primaires tendances, légers et résistants, tout en emportant l\'ensemble des affaires de classe cahiers et classeurs A4 nécessaires. La collection de sacs primaires Bodypack comporte un large choix de cartables 38 cm, cartables 41cm, et de cartables ou sacs à dos à roulettes lumineuses. Nous portons par ailleurs une grande attention à l\'ergonomie de nos produits et notamment au dos ventilés rembourrés et aux bretelles moussées réglables, qui protège le dos encore fragile des enfants de CE1 et CE2 qui sont en pleine croissance. Doté de fonds renforcés, de roues en nylon, les sacs primaires Bodypack sont testés et conçus pour durer, à l\'épreuvre de la rue et des cours de recrée. Parce que l\'on sait que nos sacs et cartables sont destinés à être portés par vos enfants, nous prenons soin de les réaliser à la main en tissu déperlant eco responsable, sans phtalate, cadmium, ni colorant azoique. Pour aller plus loin et entretenir la planète qui nous abrite, nous nous engageons à planter un arbre pour chaque sac ou cartable acheté sur notre site. Bodypack à chacun son sac !', NULL),
(4, 'Collège & lycée', 'Au collège et au lycée les sacs à dos sont bien chargés. Chez Bodypack nous savons qu\'il est essentiel d\'optimiser l\'ergonomie de nos produits pour éviter de générer des scolioses aux enfants qui grandissent fortement pendant le collège ou le lycée. Parfaitement équilibrés et ajustés à chaque morphologie, les sacs à dos Bodypack pour le collège ou le lycée possèdent 1 compartiment, 2 compartiments, ou 3 compartiments au gré de vos besoins. Certains sont dotés d\'un compartiment ordinateur ou tablette, d\'autres de port USB, afin de rester connecté toute la journée. Notre équipe de stylistes des beaux arts conçoit des motifs originaux et tendances chaque année. Pour ceux qui le souhaitent, nous proposons également une large gamme de sac unis, qu\'il s\'agisse des sacs extensibles sur toute leur hauteur, ou du Make My Pack, le sac personnalisable de Bodypack, vous trouverez facilement votre bonheur, avec 5 ans de garantie. Par ce que nous prenons soin de les réaliser à la main en tissu déperlant eco responsable, sans phtalate, cadmium, ni colorant azoique. Pour aller plus loin et entretenir la planète qui nous abrite, nous nous engageons à planter un arbre pour chaque sac acheté sur notre site. Bodypack à chacun son sac !', NULL),
(6, 'Sport', 'Vous êtes sportif inconditionnel ou sportif du dimanche, vous n\'avez sans doute pas les mêmes besoins, mais dans les 2 cas vous recherchez des produits de qualité, design et fonctionnels. Ne cherchez plus ! Bodypack conçoit depuis près de 20ans des sacs de sport 20L, 45L, 55L, 65L, 85L à roulettes avec des fonds renforcés, des poignées ergonomiques et de nombreux rangements pour répondre à chacune et chacun d\'entre vous. Pour la gym, le pilate, le fitness, la petite séance à la salle, la piscine choissisez plutôt un format compact de type 20Litres dans lequel vous pourrez mettre l\'essentiel. Les formats 45 litres et 55 litres sont évidemment les plus polyvalents pour le foot, le volley, le badminton, le squash, le patinage, la natation .... avec une bandouilière, un compartiment aéré qui permet de stocker vos chaussures ou vos vêtements mouillés, afin de ne pas les mélanger avec le reste de vos affaires. Pour les plus exigeants ou celles et ceux qui toujours peur de manquer de place, les pratiquants d\'équitation, de hockey glace, d\'escrime, ... bref de sport où il y a beaucoup d\'équipements, choisissez les grands formats en 65 litres ou 85 litres avec roulettes. La canne telescopique et les roulettes ultra résistantes en nylon vous permettront d\'emporter tout ce que vous souhaitez tout en ménageant votre dos. Parce que se met à votre place et que l\'on sait que faire du sport cela donne soif, on a aussi pensé à une poche isotherm dans notre modèle 85Litres, innovation Française BODYPACK ! Pratique, fonctionnelle, robuste, la gamme de sacs de sports Bodypack est adaptée à toute la famille, dès le plus jeune age. Conçue avec beaucoup d\'attention par notre équipe de stylistes, elle n\'en est pas moins tendance avec des designs et des motifs originaux, et réalisée à la main uniquement à partir de tissu eco responsable sans phtalate, colorant azoique ou cadmium. Pour aller plus loin et entretenir la planète qui nous abrite, nous nous engageons à planter un arbre pour chaque sac acheté sur notre site. Bodypack à chacun son sac !', NULL),
(8, 'Business & Urbain', 'Les sacs techniques business et urbains Bodypack sont conçus pour vous permettre d\'évoluer confortablement et en toute sécurité dans la jungle urbaine. Fait en tissu résistant et non toxique, et même recyclés ou deperlant pour certains modèles, ces sacs à dos sont des concentrés de technologie. Dotés de compartiments ordinateurs moussés pour acceuillir un ordinateur portable ou une tablette, ils disposent égelement de ports USB externe pour vous permettre de garder vos appareils chargés en toute circonstance. Equipés d\'un ou plusieurs compartiments spacieux, ainsi que de mutiples poches zippées à l\'intérieur et à l\'exterieur et d\'organizers, vous pourrez y ranger tout votre matériel professionnel ou personnel. Des crochets antivol près des fermetures externes vous permettent également de sécuriser les poches de votre sac, par exemple pendant que vous voyagez dans les transports en commun. Pour vous assurer un confort maximum, les sacs à dos business et urbains Bodypack disposent de dos \"Airflow\" moussés et ventilés, et de bretelles rembourrées et ajustables. Compacts, pratiques et légers, ces sacs à dos deviendront rapidemment vos compagnons du quotidien. Et avec une garantie de 10 ans, ils sauront parfaitement résister à l\'épreuve du temps. Pour aller plus loin et entretenir la planète qui nous abrite, nous nous engageons à planter un arbre pour chaque sac acheté sur notre site. Bodypack à chacun son sac !', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin` tinyint(1) NOT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `admin`, `user_name`) VALUES
(1, 'bruel.william@gmail.com', '$2y$13$j76Qxxb30plef4FCMm.9p.32RYEd6zFcLxA4PEVfVT3iT3frlKXxO', 1, 'william');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_BA388B7A76ED395` (`user_id`);

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_C7440455A76ED395` (`user_id`);

--
-- Index pour la table `migration_versions`
--
ALTER TABLE `migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_E52FFDEE1AD5CDBF` (`cart_id`),
  ADD KEY `IDX_E52FFDEE19EB6921` (`client_id`),
  ADD KEY `IDX_E52FFDEEA76ED395` (`user_id`);

--
-- Index pour la table `order_product`
--
ALTER TABLE `order_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_2530ADE61AD5CDBF` (`cart_id`),
  ADD KEY `IDX_2530ADE64584665A` (`product_id`);

--
-- Index pour la table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D34A04AD78FF0845` (`product_categories_id`);

--
-- Index pour la table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `order_product`
--
ALTER TABLE `order_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `FK_BA388B7A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `FK_C7440455A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK_E52FFDEE19EB6921` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `FK_E52FFDEE1AD5CDBF` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`),
  ADD CONSTRAINT `FK_E52FFDEEA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `order_product`
--
ALTER TABLE `order_product`
  ADD CONSTRAINT `FK_2530ADE61AD5CDBF` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`),
  ADD CONSTRAINT `FK_2530ADE64584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Contraintes pour la table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04AD78FF0845` FOREIGN KEY (`product_categories_id`) REFERENCES `product_categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
