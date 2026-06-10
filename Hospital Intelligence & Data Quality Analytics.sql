
SELECT * FROM admissions;
SELECT * FROM doctors;
SELECT * FROM patients; 
SELECT * FROM province_names;

-- 1. What is the total hospital load (patients & admissions)?
SELECT 
COUNT(DISTINCT patient_id) AS total_patients,
COUNT(*) AS total_admissions
FROM admissions;

-- 2. How are admissions trending over time?
SELECT 
DATE_FORMAT(admission_date, "%Y-%m") AS month,
COUNT(*) AS total_admissions
FROM admissions
GROUP BY month
ORDER BY month;

-- 3. Which doctors are handling the highest number of patients?
SELECT
a.attending_doctor_id,
d.first_name,
d.specialty,
COUNT(*) AS total_patients
FROM admissions a
JOIN doctors d
ON a.attending_doctor_id = d.doctor_id
GROUP BY a.attending_doctor_id, d.first_name, d.specialty
ORDER BY total_patients DESC;


-- 4. What % of patients are repeat visitors?
 
SELECT 
SUM(CASE WHEN visit_count = 1 THEN 1 ELSE 0 END) AS new_patients,
SUM(CASE WHEN visit_count > 1 THEN 1 ELSE 0 END) AS repeat_patients,
ROUND(SUM(CASE WHEN visit_count > 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS repeat_percentage
FROM (SELECT patient_id, 
COUNT(*) AS visit_count
FROM admissions
GROUP BY patient_id) AS patient_visits;

-- 5. Which regions have highest patient inflow?
SELECT 
pn.province_name,
COUNT(*) AS total_patients
FROM patients p
JOIN province_names pn 
ON p.province_id = pn.province_id
GROUP BY pn.province_name
ORDER BY total_patients DESC;

-- 6. Which age group contributes most to admissions?

SELECT
SUM(TIMESTAMPDIFF(YEAR, birth_date, CURRENT_DATE()) < 18) AS children,
SUM(TIMESTAMPDIFF(YEAR, birth_date, CURRENT_DATE()) BETWEEN 18 AND 60) AS adults,
SUM(TIMESTAMPDIFF(YEAR, birth_date, CURRENT_DATE()) > 60) AS seniors
FROM patients;

-- 7. What is the average hospital stay duration?

SELECT 
ROUND(AVG(DATEDIFF(discharge_date, admission_date)),2) AS avg_stay_days
FROM admissions;

--  Find Extreme Values
SELECT 
MIN(DATEDIFF(discharge_date, admission_date)) AS min_days,
MAX(DATEDIFF(discharge_date, admission_date)) AS max_days
FROM admissions;

-- List Outlier Records
SELECT *
FROM admissions
WHERE DATEDIFF(discharge_date, admission_date) < 0;

-- After Cleaning
-- After removing outliers, the average stay reduced from -212 days to 4 days, 
SELECT 
ROUND(AVG(DATEDIFF(discharge_date, admission_date))) AS avg_stay
FROM admissions
WHERE discharge_date >= admission_date;

   

-- 8. Which patients have unusually long stays?
SELECT 
patient_id,
DATEDIFF(discharge_date, admission_date) AS stay_days
FROM admissions
WHERE DATEDIFF(discharge_date, admission_date) > 7
ORDER BY stay_days DESC;