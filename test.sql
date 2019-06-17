-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2019 at 04:59 PM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `srno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` text NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`srno`, `name`, `email`, `phone`, `msg`, `date`) VALUES
(1, 'Arti Bhasme', 'thisisdefaul@email.com', '9876543210', 'entering first message in contact page', '2019-06-09 10:56:51'),
(2, 'nm1', 'eml1@mail', '76666', 'msg1', '2019-06-09 11:13:49'),
(3, 'arti', 'thisisdefaul@email.com', '9876543210', 'In a first of its kind initiative, the learning partnership between IIM Indore and Jigsaw Academy brings to all working professionals an unparalleled flexible learning experience. The last date for application is June 30th, 2019.\r\n', '2019-06-09 11:15:34'),
(4, 'aa', 'bb@cc', 'vvv', 'aaa', '2019-06-09 12:58:43'),
(5, 'aaa', 'bbb@ccc', '1111', 'mmmm', '2019-06-09 12:59:38'),
(6, 'aaa', 'bbbb@ccc', '2222ddd', 'dddd', '2019-06-09 13:02:25'),
(7, 'aaaa', 'bbbb@ccc', '5555', 'hhhh', '2019-06-09 13:02:58'),
(8, 'aaa', 'bbbb@ccc', '1111', 'msgdd', '2019-06-09 13:05:59'),
(9, 'aaa', 'bbbb@ccc', '1111', 'msgdd', '2019-06-09 13:08:02'),
(10, 'aaa', 'bbbb@ccc', 'oneone', 'msgdd', '2019-06-09 13:09:24'),
(11, 'aaa', 'bbbb@ccc', 'oneone', 'msgdd', '2019-06-09 13:11:25'),
(12, 'aaa', 'bbbb@ccc', 'oneone', 'msgdd', '2019-06-09 13:13:32'),
(13, 'aaa', 'thisisdefaul@email.com', 'oneone', 'msgdd', '2019-06-09 13:18:09'),
(14, 'aaa', 'thisisdefaul@email.com', 'oneone', 'msgdd', '2019-06-09 13:28:06'),
(15, 'aaa', 'thisisdefaul@email.com', 'oneone', 'msgdd', '2019-06-09 13:36:48'),
(16, 'aaa', 'thisisdefaul@email.com', 'oneone', 'msgdd', '2019-06-09 13:39:01'),
(17, 'aaa', 'thisisdefaul@email.com', 'oneone', 'msgdd', '2019-06-09 13:45:53'),
(18, 'aaa', 'thisisdefaul@email.com', 'oneone', 'msgdd', '2019-06-09 13:46:34'),
(19, 'aaa', 'thisisdefaul@email.com', 'oneone', 'msgdd', '2019-06-09 13:46:54'),
(20, 'aaa', 'thisisdefaul@email.com', 'oneone', 'msgdd', '2019-06-09 13:51:18'),
(21, 'aaa', 'thisisdefaul@email.com', 'oneone', 'msgdd', '2019-06-09 13:51:30'),
(22, 'arti', 'aaaa@gmail.com', '8888', 'msg', '2019-06-15 18:07:37');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `srno` int(11) NOT NULL,
  `title` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` varchar(500) NOT NULL,
  `tagline` text NOT NULL,
  `img_file_name` varchar(50) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`srno`, `title`, `slug`, `content`, `tagline`, `img_file_name`, `date`) VALUES
(1, 'The \'Make My Life Easier\' Headlines', 'life-blog-one', 'This is the little sister to the \'Best\' headlines. If your customers are facing problems, they don\'t always want to know the best way to do something. Sometimes, they want to know the easiest way. \r\n\r\nPersonal Story\r\n\r\nAt one point, I worked as the internet sales manager at a car dealership. I found a lot of our customers weren\'t interested in the best way to buy a car, which is save money and pay cash.\r\n\r\nThey were very interested, however, in the easiest way. Our most successful content was he', 'Life changing blog...you can not just missed it', 'post-bg.jpg', '2019-06-09 00:00:00'),
(2, 'Blog Blueprint Revised one', 'flask-blog-one', 'You’ll use the same techniques you learned about when writing the authentication blueprint to write the blog blueprint. The blog should list all posts, allow logged in users to create posts, and allow the author of a post to edit or delete it.\r\n\r\nAs you implement each view, keep the development server running. As you save your changes, try going to the URL in your browser and testing them out.', 'flask coding blog...everyone should refer', 'post-bg.jpg', '2019-06-15 13:14:00'),
(3, 'Man must explore, and this is exploration at its greatest', 'sample-post-one', 'Never in all their history have men been able truly to conceive of the world as one: a single sphere, a globe, having the qualities of a globe, a round earth in which all the directions eventually meet, in which there is no center because every point, or none, is center — an equal earth which all men occupy as equals. The airman\'s earth, if free men make it, will be truly round: a globe in practice, not in theory.\r\n\r\nScience cuts two ways, of course; its products can be used for both good and ev', 'man should explore whatever comes in the path', 'post-bg.jpg', '2019-06-09 19:58:11'),
(4, 'Vintage, antique or old?', 'quora-antique-blog', '\"Vintage\" \"update karo yar\"doesn\'t mean much, and is applied to things as recent as the 1980s (or even 90s in some cases!) if they are particularly characteristic of the the style or fashion of their time. A smoked glass and chrome coffee table from 1981 would be a vintage piece.\r\n\r\nAntique used to be \'anything over 100 years old\' but I think that\'s a loose definition. A good, handmade item from as recently as 1940 is probably an antique in most people\'s eyes. Mass produced items tend not to be ', '\"Vintage\" doesn\'t mean much', 'post-bg.jpg', '2019-06-15 13:13:03'),
(5, 'BURSTING THAT BUBBLE', 'colo-n-ice', 'Pink diamonds have held their place in the sun for some time now. In earlier days, fancy color diamonds may have been traded confidentially within that furtive sphere of big time collectors who know how to reach others of their ilk.\r\n\r\nNow we mere earthlings can thrill to the news of large fancy color diamond sales via top auction houses who do a lot of pre-sale promos and post auction results.', 'bursting the best bubble', 'post-bg.jpg', '2019-06-10 20:49:54'),
(6, 'ATULNIYA The INCREDIBLE', 'super-antique-blog', 'good question, as you add the word “SUPER” it denotes the thing you are searching is very highly precious and costly.\r\n\r\nso have to work very very hard and need very super awareness for finding. you have to gather super knowledge of antiques.\r\n\r\nalso you have to need a super curiosity about antique.\r\n\r\ni have wrote a very super knowledge about super antique information in my blog.\r\n\r\nyou can read and study about my own collection about super antique item\r\n\r\n', 'ATULNIYA The INCREDIBLE', 'post-bg.jpg', '2019-06-10 20:55:04'),
(7, 'Template Designer Documentation', 'Synopsis', 'This document describes the syntax and semantics of the template engine and will be most useful as reference to those creating Jinja templates. As the template engine is very flexible, the configuration from the application can be slightly different from the code presented here in terms of delimiters and behavior of undefined values.\r\n\r\n', 'A template contains variables and/or expressions', 'post-bg.jpg', '2019-06-10 20:59:29');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`srno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`srno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `srno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `srno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
