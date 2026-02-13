-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 13, 2026 at 06:39 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `callee1`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_numbers`
--

CREATE TABLE `admin_numbers` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `number_id` int(11) NOT NULL,
  `purchase_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `expiry_date` timestamp NULL DEFAULT NULL,
  `status` enum('active','inactive','pending_payment') NOT NULL DEFAULT 'pending_payment'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_numbers`
--

INSERT INTO `admin_numbers` (`id`, `admin_id`, `number_id`, `purchase_date`, `expiry_date`, `status`) VALUES
(2, 7, 3, '2026-01-23 14:37:55', NULL, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `call_logs`
--

CREATE TABLE `call_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `call_id` varchar(255) DEFAULT NULL,
  `telnyx_call_control_id` varchar(255) DEFAULT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `phone_number` varchar(20) NOT NULL,
  `from_number` varchar(20) DEFAULT NULL,
  `direction` enum('inbound','outbound') DEFAULT 'outbound',
  `start_time` datetime DEFAULT current_timestamp(),
  `end_time` datetime DEFAULT NULL,
  `duration` int(11) DEFAULT 0,
  `status` varchar(50) DEFAULT 'initiated',
  `provider_call_id` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `cost` decimal(10,4) DEFAULT 0.0000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `call_logs`
--

INSERT INTO `call_logs` (`id`, `user_id`, `call_id`, `telnyx_call_control_id`, `lead_id`, `phone_number`, `from_number`, `direction`, `start_time`, `end_time`, `duration`, `status`, `provider_call_id`, `created_at`, `cost`) VALUES
(1, 8, '2', NULL, 1, '172873883894', '13873883783', 'outbound', '2026-02-13 21:31:43', NULL, 0, 'initiated', NULL, '2026-02-13 16:31:43', 0.0000);

-- --------------------------------------------------------

--
-- Table structure for table `campaigns`
--

CREATE TABLE `campaigns` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `dial_method` enum('manual','auto') DEFAULT 'manual',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `campaigns`
--

INSERT INTO `campaigns` (`id`, `name`, `admin_id`, `dial_method`, `start_date`, `end_date`, `status`, `created_at`) VALUES
(1, 'check', 7, 'manual', '2222-02-22', '2023-12-31', 'active', '2026-01-19 20:20:45');

-- --------------------------------------------------------

--
-- Table structure for table `leads`
--

CREATE TABLE `leads` (
  `id` int(11) NOT NULL,
  `campaign_id` int(11) DEFAULT NULL,
  `phone_number` varchar(20) NOT NULL,
  `status` varchar(50) DEFAULT 'pending',
  `notes` varchar(15) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leads`
--

INSERT INTO `leads` (`id`, `campaign_id`, `phone_number`, `status`, `notes`, `created_at`) VALUES
(1, 1, '1111111', 'not_interested', '\n', '2026-01-20 19:12:05'),
(2, 1, '22222222', 'pending', '', '2026-01-23 20:32:20'),
(3, 1, '3333333', 'no_answer', '\n\n\n\n\n\n\n', '2026-01-23 20:32:34');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `direction` enum('inbound','outbound') DEFAULT NULL,
  `from_number` varchar(20) DEFAULT NULL,
  `to_number` varchar(20) DEFAULT NULL,
  `body` text DEFAULT NULL,
  `cost` decimal(10,4) DEFAULT 0.0000,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `user_id`, `direction`, `from_number`, `to_number`, `body`, `cost`, `status`, `created_at`) VALUES
(1, 8, 'outbound', '+18889180632', '+19376260440', 'hello Nasir mushariq here this is test message please reply on whatsapp', 0.0050, 'sent', '2026-02-05 17:26:15');

-- --------------------------------------------------------

--
-- Table structure for table `message_logs`
--

CREATE TABLE `message_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `to_number` varchar(20) NOT NULL,
  `from_number` varchar(20) NOT NULL,
  `direction` enum('inbound','outbound') NOT NULL,
  `body` text DEFAULT NULL,
  `cost` decimal(10,4) DEFAULT 0.0000,
  `status` varchar(50) DEFAULT 'sent',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `phone_numbers`
--

CREATE TABLE `phone_numbers` (
  `id` int(11) NOT NULL,
  `number` varchar(20) NOT NULL,
  `type` enum('local','toll-free') NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('available','assigned','reserved') NOT NULL DEFAULT 'available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `phone_numbers`
--

INSERT INTO `phone_numbers` (`id`, `number`, `type`, `price`, `status`, `created_at`, `updated_at`) VALUES
(3, '+18889180632', 'toll-free', 4.00, 'assigned', '2026-01-23 14:37:44', '2026-01-23 14:37:55');

-- --------------------------------------------------------

--
-- Table structure for table `sip_carriers`
--

CREATE TABLE `sip_carriers` (
  `id` int(11) NOT NULL,
  `carrier_name` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `port` int(11) NOT NULL DEFAULT 5060,
  `username` varchar(255) DEFAULT NULL,
  `secret` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sip_carriers`
--

INSERT INTO `sip_carriers` (`id`, `carrier_name`, `host`, `port`, `username`, `secret`, `created_at`) VALUES
(1, 'signalwire', 'smtp.gmail.com', 5060, 'admin', '1234333', '2026-01-16 20:04:51');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `setting_key`, `setting_value`, `updated_at`) VALUES
(1, 'call_rate_per_minute', '0.015', '2026-01-22 19:26:01'),
(2, 'sms_rate_per_segment', '0.005', '2026-01-22 19:26:01');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(15) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(30) NOT NULL,
  `role` varchar(20) NOT NULL,
  `credits` decimal(10,2) NOT NULL DEFAULT 0.00,
  `admin_id` int(11) DEFAULT NULL,
  `status` enum('active','inactive','unpaid','suspended') NOT NULL DEFAULT 'active',
  `availability_status` enum('online','on_break','offline') DEFAULT 'online',
  `allow_auto_dial` tinyint(1) DEFAULT 0,
  `allow_call` tinyint(1) DEFAULT 1,
  `allow_message` tinyint(1) DEFAULT 1,
  `sip_extension` varchar(50) DEFAULT NULL,
  `sip_password` varchar(100) DEFAULT NULL,
  `custom_call_rate` decimal(10,4) DEFAULT NULL,
  `custom_sms_rate` decimal(10,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `credits`, `admin_id`, `status`, `availability_status`, `allow_auto_dial`, `allow_call`, `allow_message`, `sip_extension`, `sip_password`, `custom_call_rate`, `custom_sms_rate`) VALUES
(3, 'sadmin', '12345', 'superadmin', 0.00, NULL, 'active', 'online', 0, 1, 1, '', '', NULL, NULL),
(7, 'admin', '12345', 'admin', 100.00, NULL, 'active', 'online', 0, 1, 0, NULL, NULL, NULL, NULL),
(8, 'agent', '12345', 'agent', 0.00, 7, 'active', 'online', 0, 1, 1, '100', '100', NULL, NULL),
(9, 'agent1', '12345', 'agent', 0.00, NULL, 'active', 'online', 0, 1, 1, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_numbers`
--
ALTER TABLE `admin_numbers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`),
  ADD KEY `number_id` (`number_id`);

--
-- Indexes for table `call_logs`
--
ALTER TABLE `call_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `campaigns`
--
ALTER TABLE `campaigns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `campaign_id` (`campaign_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `message_logs`
--
ALTER TABLE `message_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `phone_numbers`
--
ALTER TABLE `phone_numbers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `number` (`number`);

--
-- Indexes for table `sip_carriers`
--
ALTER TABLE `sip_carriers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_admin_id` (`admin_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_numbers`
--
ALTER TABLE `admin_numbers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `call_logs`
--
ALTER TABLE `call_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `campaigns`
--
ALTER TABLE `campaigns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `leads`
--
ALTER TABLE `leads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `message_logs`
--
ALTER TABLE `message_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phone_numbers`
--
ALTER TABLE `phone_numbers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sip_carriers`
--
ALTER TABLE `sip_carriers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_numbers`
--
ALTER TABLE `admin_numbers`
  ADD CONSTRAINT `admin_numbers_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `admin_numbers_ibfk_2` FOREIGN KEY (`number_id`) REFERENCES `phone_numbers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `call_logs`
--
ALTER TABLE `call_logs`
  ADD CONSTRAINT `call_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `campaigns`
--
ALTER TABLE `campaigns`
  ADD CONSTRAINT `campaigns_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `leads`
--
ALTER TABLE `leads`
  ADD CONSTRAINT `leads_ibfk_1` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_agent_admin` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
