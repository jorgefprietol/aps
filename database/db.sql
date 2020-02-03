CREATE DATABASE db_personas;

USE db_personas;
-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-02-2020 a las 10:36:07
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_personas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `specialist` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`id`, `name`, `email`, `phone`, `user_id`, `created_at`, `specialist`) VALUES
(2, 'Cursos y Desarrollo de programación web', 'http://www.terasoftec.com/tienda/', 'sdfsv dgbdfbdfb', 2, '2020-02-03 04:31:12', ''),
(3, 'prueba proyecto', 'http://www.terasoftec.com/tienda/index.php?rt=product/product&product_id=12', 'bgdbfgbfbfgbbfgbgb', 2, '2020-02-03 04:31:34', 'rrrr'),
(9, 'Jorge Prieto55555555', 'http://localhost:4000/personas/add', 'bbbbbbbbbbb', 1, '2020-02-03 07:00:54', 'hhhh'),
(11, 'Jorge Prieto', 'jprieto@terasoftec.com', 'kkkkkkkkkkkk', 5, '2020-02-03 07:08:00', ''),
(13, 'Jorge Prieto', 'jorgefprietol@gmail.com', 'sssssssssssss', 5, '2020-02-03 08:14:56', 'jjjjjjj');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('FYHu6j6C5Di7uATYuhfMlj7k2amKOC3P', 1580798136, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('JjRpWx3fPcwTrhjMA5cFLg2Me4iv5uNu', 1580796346, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('Sm0FjU60CvWYiuh1GpIUdo_5fg-QAx78', 1580791853, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{\"user\":1}}'),
('qQE4OF7DlCEor4D4VPsygIJ3h6E013z3', 1580799109, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{\"user\":1}}'),
('rW78gEJ4JsPc4l6dw_vy0_n2qRFnlzMB', 1580797957, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{}}'),
('rWndQ6gqnUCfCO1RXPcC8kGNffWUpdMS', 1580790632, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('zyFOLIvHglc-rpAA_OgnfSwVZ-Dhh7hx', 1580806962, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{}}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(16) NOT NULL,
  `password` varchar(60) NOT NULL,
  `fullname` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `fullname`) VALUES
(1, 'jorge', '$2a$10$L3bpt1fd531HvoQYiaPQQe3iBxk40fmkiwfmeJtuXDMUqAlQHPWCK', 'Jorge Prieto'),
(2, 'fidel', '$2a$10$L3bpt1fd531HvoQYiaPQQe3iBxk40fmkiwfmeJtuXDMUqAlQHPWCK', 'Fidel Linares'),
(3, 'jorge', '$2a$10$0l2PI3DV2gCsc1Br6ZaEduaLLElnUa842z0WsE0AMeuFFXCumR2q2', 'Jorge Prieto'),
(4, 'jorge', '$2a$10$LMz2R8SZfei.k0igiFzUVe9tFcffYRK4hvJ7WPpvcqRGD5Ah7jDEe', 'Jorge Prieto'),
(5, 'jorge', '$2a$10$p3ozp.vke6L8Ig0VWb5f9eDcBARdQWrnyBM6uRX.2Q9XEAnJY4ESC', 'Jorge Prieto');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user` (`user_id`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `personas`
--
ALTER TABLE `personas`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
