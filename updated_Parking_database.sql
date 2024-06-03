-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 18, 2024 at 10:43 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gawanineca`
--

-- --------------------------------------------------------

--
-- Table structure for table `ir_status_table`
--

CREATE TABLE `ir_status_table` (
  `id` int(11) NOT NULL,
  `status` varchar(5) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `L_ID` int(11) NOT NULL,
  `L_RFID` int(11) NOT NULL,
  `time_in` datetime NOT NULL DEFAULT current_timestamp(),
  `time_out` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`L_ID`, `L_RFID`, `time_in`, `time_out`) VALUES
(14, 1420630, '2023-09-07 21:12:24', '2023-09-07 21:23:19'),
(15, 1420630, '2023-09-07 22:57:12', '2023-09-07 22:59:43'),
(16, 0, '2023-09-07 22:58:21', ''),
(17, 1420630, '2023-09-07 22:59:51', '2023-09-07 23:00:25'),
(18, 1420630, '2023-09-07 23:00:58', '2023-09-07 23:01:21'),
(19, 1420630, '2023-09-07 23:02:12', '2023-09-07 23:02:16'),
(20, 1420630, '2023-09-07 23:02:29', '2023-09-07 23:03:28'),
(21, 1420630, '2023-09-08 12:00:14', '2023-09-08 12:01:35'),
(22, 1420630, '2023-09-08 12:01:38', '2023-09-08 12:01:43'),
(23, 1420630, '2023-09-08 12:01:50', '2023-09-08 12:01:55'),
(24, 1420630, '2023-09-10 23:23:17', '2023-09-10 23:48:04'),
(25, 1420630, '2023-09-10 23:48:51', '2023-09-10 23:48:58'),
(26, 1420630, '2023-09-10 23:49:13', '2023-09-10 23:49:47'),
(27, 1420630, '2023-09-10 23:50:24', '2023-09-12 21:51:37'),
(28, 1420630, '2023-09-12 21:51:53', '2023-09-12 22:02:19'),
(29, 1420630, '2023-09-12 22:05:09', ''),
(30, 357980, '2023-09-14 11:49:32', '2023-09-14 11:50:18'),
(31, 357980, '2023-09-14 12:08:50', '2023-09-14 12:16:29'),
(32, 357980, '2023-09-14 12:22:26', '2023-09-14 12:22:33'),
(33, 357980, '2023-09-14 12:24:17', ''),
(34, 554915366, '2024-05-12 01:40:36', '2024-05-12 01:41:11'),
(35, 554915366, '2024-05-12 01:46:37', '2024-05-12 01:47:45'),
(36, 554915366, '2024-05-12 01:58:28', '2024-05-12 01:58:30'),
(37, 554915366, '2024-05-12 01:58:34', '2024-05-12 01:59:57'),
(38, 554915366, '2024-05-12 02:00:17', '2024-05-12 02:00:42');

-- --------------------------------------------------------

--
-- Table structure for table `parking_status`
--

CREATE TABLE `parking_status` (
  `id` int(11) NOT NULL,
  `available_slots` int(11) DEFAULT NULL,
  `slot1` varchar(10) DEFAULT 'free',
  `slot2` varchar(10) DEFAULT 'free',
  `slot3` varchar(10) DEFAULT 'free',
  `slot4` varchar(10) DEFAULT 'free',
  `slot5` varchar(10) DEFAULT 'free',
  `slot6` varchar(10) DEFAULT 'free'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `parking_status`
--

INSERT INTO `parking_status` (`id`, `available_slots`, `slot1`, `slot2`, `slot3`, `slot4`, `slot5`, `slot6`) VALUES
(1, 4, 'free', 'free', 'free', 'free', 'free', 'free');

-- --------------------------------------------------------

--
-- Table structure for table `slots`
--

CREATE TABLE `slots` (
  `S_ID` int(11) NOT NULL,
  `free_slots` int(1) NOT NULL,
  `slot1` varchar(11) NOT NULL,
  `slot2` varchar(11) NOT NULL,
  `slot3` varchar(11) NOT NULL,
  `slot4` varchar(11) NOT NULL,
  `slot5` varchar(11) NOT NULL,
  `slot6` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `slots`
--

INSERT INTO `slots` (`S_ID`, `free_slots`, `slot1`, `slot2`, `slot3`, `slot4`, `slot5`, `slot6`) VALUES
(1, 2, 'FREE', 'TAKEN', 'TAKEN', 'TAKEN', 'TAKEN', 'FREE');

-- --------------------------------------------------------

--
-- Table structure for table `tbladmin`
--

CREATE TABLE `tbladmin` (
  `A_ID` int(11) NOT NULL,
  `admin_name` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `A_username` varchar(25) NOT NULL,
  `A_password` varchar(8) NOT NULL,
  `mobile_phone` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbladmin`
--

INSERT INTO `tbladmin` (`A_ID`, `admin_name`, `email`, `A_username`, `A_password`, `mobile_phone`) VALUES
(1, 'neca', 'admin@gmail.com', 'admin', 'Test123', 12345678998);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_ID` int(11) NOT NULL,
  `RFID` varchar(11) NOT NULL,
  `user_Fname` varchar(25) NOT NULL,
  `user_Minit` varchar(2) DEFAULT NULL,
  `user_Lname` varchar(25) NOT NULL,
  `user_department` varchar(20) NOT NULL,
  `user_designation` varchar(25) NOT NULL,
  `user_year` varchar(15) DEFAULT NULL,
  `user_block` varchar(1) DEFAULT NULL,
  `vehicle_type` varchar(20) NOT NULL,
  `plate_number` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_ID`, `RFID`, `user_Fname`, `user_Minit`, `user_Lname`, `user_department`, `user_designation`, `user_year`, `user_block`, `vehicle_type`, `plate_number`) VALUES
(2, '1', 'first', 'n.', 'number', 'CoEng', 'Student', '2', 'A', '2', '1'),
(4, '1420630', 'yeter', 'sc', 'kutie', 'CAS', 'Professor', '3', 'B', '2', '567'),
(5, '21135626', 'kim', 'G', 'Ramos', 'CoEng', 'Student', '4', 'B', '1', '123454'),
(6, '554915366', 'kim', 'G', 'Ramos', 'CAS', 'Professor', '2', 'B', '1', '123454');

-- --------------------------------------------------------

--
-- Table structure for table `user_account`
--

CREATE TABLE `user_account` (
  `U_ID` int(11) NOT NULL,
  `ua_Fname` varchar(25) NOT NULL,
  `ua_Lname` varchar(25) NOT NULL,
  `ua_email` varchar(25) NOT NULL,
  `U_username` varchar(25) NOT NULL,
  `U_password` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_account`
--

INSERT INTO `user_account` (`U_ID`, `ua_Fname`, `ua_Lname`, `ua_email`, `U_username`, `U_password`) VALUES
(1, 'Neca', 'Dulay', 'akoito@gmail.com', 'necadulay', '11111'),
(2, 'first', 'number', 'number@gmail.com', 'firstnumber', '1'),
(3, 'erere', 'Dulay', 'akoito@gmail.com', 'ereredulay', '357980'),
(4, 'yeter', 'kutie', 'dulayneca@gmail.com', 'yeterkutie', '1420630'),
(5, 'kim', 'Ramos', 'kimagdalene@outlook.com', 'kimramos', '21135626'),
(6, 'kim', 'Ramos', 'kimagdalene@outlook.com', 'kimramos', '55491536');

-- --------------------------------------------------------

--
-- Table structure for table `validity`
--

CREATE TABLE `validity` (
  `V_ID` int(11) NOT NULL,
  `V_RFID` varchar(11) NOT NULL,
  `dt_registered` datetime NOT NULL DEFAULT current_timestamp(),
  `expiration` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `validity`
--

INSERT INTO `validity` (`V_ID`, `V_RFID`, `dt_registered`, `expiration`) VALUES
(1, '11111', '2023-07-24 21:30:49', '2024-07-24 21:30:49'),
(2, '1', '2023-07-24 21:32:23', '2024-07-24 21:32:23'),
(3, '357980', '2023-07-27 04:06:59', '2024-07-27 04:06:59'),
(4, '1420630', '2023-07-27 04:58:09', '2024-07-27 04:58:09'),
(5, '21135626', '2024-05-10 19:25:49', '2025-05-10 19:25:49'),
(6, '554915366', '2024-05-11 19:26:59', '2025-05-11 19:26:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ir_status_table`
--
ALTER TABLE `ir_status_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`L_ID`),
  ADD KEY `l_rfid` (`L_RFID`),
  ADD KEY `L_VID` (`L_RFID`);

--
-- Indexes for table `parking_status`
--
ALTER TABLE `parking_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `slots`
--
ALTER TABLE `slots`
  ADD PRIMARY KEY (`S_ID`);

--
-- Indexes for table `tbladmin`
--
ALTER TABLE `tbladmin`
  ADD PRIMARY KEY (`A_ID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_ID`);

--
-- Indexes for table `user_account`
--
ALTER TABLE `user_account`
  ADD PRIMARY KEY (`U_ID`);

--
-- Indexes for table `validity`
--
ALTER TABLE `validity`
  ADD PRIMARY KEY (`V_ID`),
  ADD KEY `V_RFID` (`V_RFID`),
  ADD KEY `V_RFID_2` (`V_RFID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ir_status_table`
--
ALTER TABLE `ir_status_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `L_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `slots`
--
ALTER TABLE `slots`
  MODIFY `S_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbladmin`
--
ALTER TABLE `tbladmin`
  MODIFY `A_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_account`
--
ALTER TABLE `user_account`
  MODIFY `U_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `validity`
--
ALTER TABLE `validity`
  MODIFY `V_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
