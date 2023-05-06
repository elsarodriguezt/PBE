CREATE DATABASE db;

USE db;

--STUDENTS
CREATE TABLE students (name VARCHAR(20)NOT NULL, uid VARCHAR(8)NOT NULL);
INSERT INTO students VALUES 
('Joel Maqueda', '33B7BF18'), 
('Carlota Pino', '16CCB99B'), 
('Elsa Rodriguez', '7658CD14'), 
('Saida Sillo', '9DC60D0B'), 
('Oriol Torres', 'ED467D29');

--TASKS
CREATE TABLE tasks (date VARCHAR(10) NOT NULL, subject VARCHAR(10) NOT NULL, name VARCHAR(20) NOT NULL, uid VARCHAR(8) NOT NULL);
INSERT INTO tasks VALUES
('2022-02-12', 'PBE', 'Puzzle 1', 'ED467D29'),
('2022-02-12', 'PBE', 'Puzzle 1', '9DC60D0B'),
('2022-02-12', 'PBE', 'Puzzle 1', '7658CD14'),
('2022-02-12', 'PBE', 'Puzzle 1', '16CCB99B'),
('2022-02-12', 'PBE', 'Puzzle 1', '33B7BF18'),
('2022-03-27', 'ICOM', 'Parcial', 'ED467D29'),
('2022-03-27', 'ICOM', 'Parcial', '9DC60D0B'),
('2022-03-30', 'ICOM', 'Parcial', '7658CD14'),
('2022-03-30', 'ICOM', 'Parcial', '16CCB99B'),
('2022-03-30', 'ICOM', 'Parcial', '33B7BF18'),
('2022-04-20', 'DSBM', 'Laboratori', 'ED467D29'),
('2022-04-28', 'DSBM', 'Laboratori', '9DC60D0B'),
('2022-05-17', 'DSBM', 'Laboratori', '7658CD14'),
('2022-05-15', 'DSBM', 'Laboratori', '16CCB99B'),
('2022-05-10', 'DSBM', 'Laboratori', '33B7BF18'),
('2022-06-23', 'PSVAC', 'Final', 'ED467D29'),
('2022-06-23', 'PSVAC', 'Final', '9DC60D0B'),
('2022-06-23', 'PSVAC', 'Final', '7658CD14'),
('2022-06-23', 'PSVAC', 'Final', '16CCB99B'),
('2022-06-23', 'PSVAC', 'Final', '33B7BF18');

--TIMETABLES
CREATE TABLE timetables (day VARCHAR(3) NOT NULL, hour VARCHAR(8) NOT NULL, subject VARCHAR(10) NOT NULL, room VARCHAR(8) NOT NULL, uid VARCHAR(8) NOT NULL);
INSERT INTO timetables VALUES
('1', '09:00:00', 'ICOM', 'A4001', 'ED467D29'),
('1', '09:00:00', 'ICOM', 'A4001', '9DC60D0B'),
('3', '12:00:00', 'ICOM', 'A3102', '7658CD14'),
('3', '12:00:00', 'ICOM', 'A3102', '16CCB99B'),
('5', '11:00:00', 'ICOM', 'A3102', '33B7BF18'),
('5', '11:00:00', 'ICOM', 'A3102', 'ED467D29'),
('1', '10:00:00', 'DSBM', 'D3001', '9DC60D0B'),
('1', '10:00:00', 'DSBM', 'D3001', '7658CD14'),
('2', '08:00:00', 'DSBM', 'A3101', '16CCB99B'),
('2', '08:00:00', 'DSBM', 'A3101', '33B7BF18'),
('4', '11:00:00', 'DSBM', 'D5001', 'ED467D29'),
('4', '11:00:00', 'DSBM', 'D5001', '9DC60D0B'),
('3', '15:00:00', 'PBE', 'A3105', '7658CD14'),
('3', '15:00:00', 'PBE', 'A3105', '16CCB99B'),
('3', '15:00:00', 'PBE', 'A3105', '33B7BF18'),
('3', '15:00:00', 'PBE', 'A3105', 'ED467D29'),
('3', '15:00:00', 'PBE', 'A3105', '9DC60D0B'),
('5', '09:00:00', 'PBE', 'A1101', '7658CD14'),
('5', '09:00:00', 'PBE', 'A1101', '16CCB99B'),
('5', '09:00:00', 'PBE', 'A1101', '33B7BF18'),
('5', '09:00:00', 'PBE', 'A1101', 'ED467D29'),
('5', '09:00:00', 'PBE', 'A1101', '9DC60D0B'),
('1', '12:00:00', 'PSVAC', 'A2201', '7658CD14'),
('1', '12:00:00', 'PSVAC', 'A2201', '16CCB99B'),
('2', '10:00:00', 'PSVAC', 'A5203', '33B7BF18'),
('2', '10:00:00', 'PSVAC', 'A5203', 'ED467D29'),
('4', '13:00:00', 'PSVAC', 'A1002', '9DC60D0B'),
('4', '13:00:00', 'PSVAC', 'A1002', '7658CD14');

--MARKS
CREATE TABLE marks (subject VARCHAR(10) NOT NULL, name VARCHAR(20) NOT NULL, mark FLOAT(4) NOT NULL, uid VARCHAR(8) NOT NULL);
INSERT INTO marks VALUES
('PBE', 'Puzzle 1', 10, 'ED467D29'),
('PBE', 'Puzzle 1', 9.5,'9DC60D0B'),
('PBE', 'Puzzle 1', 9, '7658CD14'),
('PBE', 'Puzzle 1', 8.3, '16CCB99B'),
('PBE', 'Puzzle 1', 8, '33B7BF18'),
('ICOM', 'Parcial', 2, 'ED467D29'),
('ICOM', 'Parcial', 2.5, '9DC60D0B'),
('ICOM', 'Parcial', 3, '7658CD14'),
('ICOM', 'Parcial', 3.3, '16CCB99B'),
('ICOM', 'Parcial', 5, '33B7BF18'),
('DSBM', 'Laboratori', 9.5, 'ED467D29'),
('DSBM', 'Laboratori', 9, '9DC60D0B'),
('DSBM', 'Laboratori', 8, '7658CD14'),
('DSBM', 'Laboratori', 7.6, '16CCB99B'),
('DSBM', 'Laboratori', 7, '33B7BF18'),
('PSVAC', 'Final', 5, 'ED467D29'),
('PSVAC', 'Final', 3.1, '9DC60D0B'),
('PSVAC', 'Final', 3, '7658CD14'),
('PSVAC', 'Final', 2.2, '16CCB99B'),
('PSVAC', 'Final', 2, '33B7BF18');

SELECT*FROM marks ORDER BY subject;
SELECT*FROM tasks ORDER BY date DESC;
SELECT day, hour FROM timetables
	 ORDER BY CASE WHEN day = DATE_FORMAT(NOW(),'%w') AND hour >= DATE_FORMAT(NOW(),'%r') THEN hour END ASC
	,CASE WHEN day > DATE_FORMAT(NOW(),'%w') THEN day AND hour END ASC
  ,CASE WHEN day < DATE_FORMAT(NOW(),'%w') THEN day AND hour  END ASC;
