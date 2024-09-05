-- SELECT: Retrieve all columns from the Doctor table.

SELECT *
FROM health.Doctors

--ORDER BY: List patients in the Patient table in ascending order of their ages.

SELECT *
FROM health.Patients
ORDER BY age

-- OFFSET FETCH: Retrieve the first 10 patients from the Patient table,
-- starting from the 5th record

SELECT *
FROM health.Patients
ORDER BY UR_Number
OFFSET 5 ROWS FETCH NEXT 10 ROWS ONLY

--SELECT TOP: Retrieve the top 5 doctors from the Doctor table.

SELECT TOP 5 *
FROM health.Doctors d

--SELECT DISTINCT: Get a list of unique address from the Patient table.

SELECT DISTINCT P.addresses
FROM health.Patients P

--WHERE: Retrieve patients from the Patient table who are aged 25.

SELECT *
FROM health.Patients p
WHERE p.age LIKE 25

--NULL: Retrieve patients from the Patient table whose email is not provided.

SELECT *
FROM health.Patients p
WHERE p.email IS NULL

--AND: Retrieve doctors from the Doctor table who have experience greater than 5 years
--and specialize in 'Cardiology'.

SELECT *
FROM health.Doctors d
WHERE D.exp_of_years < 5 AND D.specialty LIKE 'Cardiology'

--IN: Retrieve doctors from the Doctor table whose speciality is either 'Dermatology'
--or 'Oncology'.

SELECT *
FROM health.Doctors d
WHERE d.specialty IN('Dermatology', 'Oncology')

--BETWEEN: Retrieve patients from the Patient table whose ages are between 18 and 30.

SELECT *
FROM health.Patients p
WHERE p.age BETWEEN 18 AND 30

--LIKE: Retrieve doctors from the Doctor table whose names start with 'Dr.'.

SELECT *
FROM health.Doctors d
WHERE d.Name LIKE 'Dr.%'

--Column & Table Aliases: Select the name and email of doctors,
--aliasing them as 'DoctorName' and 'DoctorEmail'.

SELECT d.Name AS 'DoctorName', d.email AS 'DoctorEmail'
FROM health.Doctors d

--Joins: Retrieve all prescriptions with corresponding patient names.

SELECT ps.*, pt.Name AS 'Patint Name'
FROM health.Prescriptions ps join health.Patients pt
ON ps.UR_Number = pt.UR_Number

--GROUP BY: Retrieve the count of patients grouped by their cities.

SELECT p.addresses , count(*) AS 'Cities'
FROM health.Patients p 
GROUP BY p.addresses 

--HAVING: Retrieve cities with more than 3 patients.

SELECT 
	p.addresses , count(*) AS 'Cities'
FROM 
	health.Patients p 
GROUP BY 
	p.addresses
Having 
	count(p.addresses) > 3

--UNION: Retrieve a combined list of doctors and patients. (Search)

SELECT 
	d.doctor_id,
	d.Name as 'Paints & Doctors Names'
FROM 
	health.Doctors d
UNION ALL
SELECT 
	p.UR_Number,
	p.Name
FROM 
	health.Patients p

--Common Table Expre)ssion (CTE): Retrieve patients along with their doctors using a CTE.
WITH cte_paints_with_doctors (Paints, Doctors, D_ID) AS (
	SELECT 
	p.Name,
	d.Name,
	d.doctor_id
	FROM 
		health.Patients p JOIN health.Doctors d
	ON 
		p.doctor_id = d.doctor_id
)

SELECT *
FROM cte_paints_with_doctors


--INSERT: Insert a new doctor into the Doct

INSERT INTO health.Doctors 
VALUES (1, 'Abdelrahman', 'Babys', 'abdo@gmail.com', '0101917', 5)

--INSERT Multiple Rows: Insert multiple patients into the Patient table.

INSERT INTO health.Patients
VALUES 
	(1, 'Essam', 20, 'Giza, Dokki', 'essanm@yahoo.com', '0111255', 1, null),
	(2, 'Omar', 30, 'Alex, Mamora', 'Omar@yahoo.com', '010148', 1, 4200),
	(3, 'Amr', 25, 'Sinay, Aresh', 'Amr@yahoo.com', '012897', 1, null)

--UPDATE: Update the phone number of a doctor.

UPDATE health.Doctors SET phone = '010255959' WHERE doctor_id = 1


--UPDATE JOIN: Update the city of patients who have a prescription from a specific doctor.

UPDATE health.Patients SET addresses = 'Abo Gber'
FROM health.Patients p JOIN health.Doctors d
ON p.doctor_id = d.doctor_id
WHERE d.Name = 'Abdelrahman'

--DELETE: Delete a patient from the Patient table.

DELETE health.Patients
Where UR_Number = 2

--Transaction: Insert a new doctor and a patient, ensuring both operations
--succeed or fail together.

BEGIN TRANSACTION;

INSERT INTO health.Doctors 
VALUES 
	(33, 'Ali', 'Babys', 'ali@gmail.com', '011445', 3)

INSERT INTO health.Patients
VALUES 
	(41, 'Ibrahim', 20, 'Giza, October', 'Ibrahim@yahoo.com', '01555889', 33, null)

COMMIT;
--View: Create a view that combines patient and doctor information for easy access.

CREATE VIEW patient_and_doctor_info WITH ENCRYPTION
AS
SELECT
   p.UR_Number,
   p.Name,
   p.age,
   p.addresses,
   d.doctor_id,
   d.Name,
   d.specialty
FROM health.Patients p INNER JOIN health.Doctors d 
ON p.doctor_id = d.doctor_id;

--Index: Create an index on the 'phone' column of the Patient table to
--improve search performance.

CREATE INDEX patinet_phone
ON health.Patients (phone);

--Backup: Perform a backup of the entire database to ensure data safety.

