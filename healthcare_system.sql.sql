-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 27, 2025 at 01:16 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `healthcare_system`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `PayBill` (IN `billId` INT)   BEGIN
    UPDATE Bills
    SET status = 'Paid'
    WHERE bill_id = billId;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int(11) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `patient_id`, `doctor_id`, `appointment_date`, `reason`, `status`) VALUES
(1, 1, 1, '2025-06-27', 'Routine Checkup', 'Scheduled'),
(2, 2, 2, '2025-01-05', 'Migraine Treatment', 'Completed'),
(3, 3, 3, '2025-02-01', 'Skin Rash', 'Scheduled'),
(4, 4, 4, '2025-02-10', 'Child Fever', 'Scheduled'),
(5, 5, 5, '2025-03-01', 'Knee Pain', 'Scheduled');

--
-- Triggers `appointments`
--
DELIMITER $$
CREATE TRIGGER `trg_create_bill` AFTER INSERT ON `appointments` FOR EACH ROW BEGIN
    INSERT INTO Bills (patient_id, bill_date, amount, status)
    VALUES (NEW.patient_id, CURDATE(), 500.00, 'Unpaid');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `bill_id` int(11) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `bill_date` date DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`bill_id`, `patient_id`, `bill_date`, `amount`, `status`) VALUES
(1, 1, '2025-06-27', 500.00, 'Paid'),
(2, 2, '2025-01-05', 750.00, 'Paid'),
(3, 3, '2025-02-01', 600.00, 'Paid'),
(4, 4, '2025-02-10', 550.00, 'Unpaid'),
(5, 5, '2025-03-01', 700.00, 'Unpaid');

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `doctor_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `hire_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`doctor_id`, `name`, `specialization`, `phone`, `email`, `hire_date`) VALUES
(1, 'Dr. Mehta', 'Cardiologist', '9811122233', 'mehta@example.com', '2025-06-27'),
(2, 'Dr. Rao', 'Neurologist', '9822233445', 'rao@example.com', '2024-11-15'),
(3, 'Dr. Gupta', 'Pediatrician', '9111111111', 'gupta@example.com', '2024-10-10'),
(4, 'Dr. Sen', 'Dermatologist', '9222222222', 'sen@example.com', '2024-12-05'),
(5, 'Dr. Kiran', 'Orthopedic', '9333333333', 'kiran@example.com', '2025-01-01');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `patient_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `registration_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`patient_id`, `name`, `dob`, `gender`, `phone`, `address`, `registration_date`) VALUES
(1, 'Anita Desai', '1990-05-21', 'Female', '9123456789', 'Delhi, India', '2025-06-27'),
(2, 'Ravi Verma', '1985-10-02', 'Male', '9876543210', 'Mumbai, India', '2024-12-01'),
(3, 'Neha Jain', '1995-09-30', 'Female', '9023456789', 'Bhopal, India', '2025-01-05'),
(4, 'Amit Khanna', '1983-04-25', 'Male', '9012345678', 'Hyderabad, India', '2025-02-15'),
(5, 'Priya Sharma', '1992-07-11', 'Female', '9001234567', 'Pune, India', '2024-11-20');

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions`
--

CREATE TABLE `prescriptions` (
  `prescription_id` int(11) NOT NULL,
  `appointment_id` int(11) DEFAULT NULL,
  `medication` text DEFAULT NULL,
  `dosage` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `issue_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prescriptions`
--

INSERT INTO `prescriptions` (`prescription_id`, `appointment_id`, `medication`, `dosage`, `notes`, `issue_date`) VALUES
(1, 1, 'Paracetamol', '500mg twice a day', 'Take after food', '2025-06-27'),
(2, 2, 'Ibuprofen', '200mg thrice a day', 'After food', '2025-01-05'),
(3, 3, 'Cetirizine', '10mg once daily', 'Before bed', '2025-02-01'),
(4, 4, 'Amoxicillin', '250mg thrice daily', 'After meals', '2025-02-10'),
(5, 5, 'Calcium', '1 tab daily', 'Morning with water', '2025-03-01');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_upcoming_appointments`
-- (See below for the actual view)
--
CREATE TABLE `view_upcoming_appointments` (
`appointment_id` int(11)
,`patient_name` varchar(100)
,`doctor_name` varchar(100)
,`appointment_date` date
,`status` varchar(50)
);

-- --------------------------------------------------------

--
-- Structure for view `view_upcoming_appointments`
--
DROP TABLE IF EXISTS `view_upcoming_appointments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_upcoming_appointments`  AS SELECT `a`.`appointment_id` AS `appointment_id`, `p`.`name` AS `patient_name`, `d`.`name` AS `doctor_name`, `a`.`appointment_date` AS `appointment_date`, `a`.`status` AS `status` FROM ((`appointments` `a` join `patients` `p` on(`a`.`patient_id` = `p`.`patient_id`)) join `doctors` `d` on(`a`.`doctor_id` = `d`.`doctor_id`)) WHERE `a`.`status` = 'Scheduled' ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`bill_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`doctor_id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`patient_id`);

--
-- Indexes for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD PRIMARY KEY (`prescription_id`),
  ADD KEY `appointment_id` (`appointment_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `prescriptions`
--
ALTER TABLE `prescriptions`
  MODIFY `prescription_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`);

--
-- Constraints for table `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `bills_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`);

--
-- Constraints for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD CONSTRAINT `prescriptions_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`appointment_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
