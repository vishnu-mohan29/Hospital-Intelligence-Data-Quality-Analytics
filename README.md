# 🏥 Hospital Intelligence & Data Quality Analytics

![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Analytics](https://img.shields.io/badge/Focus-Data%20Analytics-green)
![Quality](https://img.shields.io/badge/Focus-Data%20Quality-orange)

---

##  Project Summary

This project focuses on analyzing hospital data using **MySQL** to solve real-world business problems.
A key highlight of this project is identifying and handling **data quality issues and outliers**, which directly impact business decisions.

---

##  Problem Statement

How can hospital data be used to:

* Measure **accurate patient stay duration**
* Analyze **hospital operations and performance**
* Identify **data inconsistencies**
* Handle **extreme values affecting KPIs**
* Deliver **reliable business insights**

---

##  Dataset Overview

This project uses multiple relational datasets:

###  Tables Used

#### `admissions`

* patient_id
* admission_date
* discharge_date
* diagnosis
* attending_doctor_id

#### `patients`

* patient_id
* first_name, last_name
* gender
* birth_date
* city
* province_id

#### `doctors`

* doctor_id
* first_name, last_name
* specialty

#### `province_names`

* province_id
* province_name

---

##  Data Relationships

* admissions.patient_id → patients.patient_id
* admissions.attending_doctor_id → doctors.doctor_id
* patients.province_id → province_names.province_id

---

##  Tools & Technologies

* **MySQL**
* SQL Joins & Aggregations
* Data Cleaning Techniques
* Analytical Thinking

---

##  Key Business Questions Solved

* What is the average hospital stay duration?
* Which doctors handle the most patients?
* Patient distribution across provinces
* Identification of invalid hospital records
* Impact of outliers on business metrics

---

##  SQL Queries & Outputs

### 🔹 1. Initial Query (Incorrect Result)

![wrong\_result](https://github.com/your-username/repo-name/blob/main/images/wrong_result.png)

👉 The result was incorrect due to extreme values in the dataset.

---

### 🔹 2. Outlier Detection

![outlier](https://github.com/your-username/repo-name/blob/main/images/outlier.png)

👉 Found unrealistic values like **-17683 days**

---

### 🔹 3. Cleaned & Correct Result

![final](https://github.com/your-username/repo-name/blob/main/images/final.png)

👉 Accurate insights after removing invalid records.

---

##  Data Quality Challenge

During analysis, the dataset contained:

* Negative stay durations
* Extremely high values
* Inconsistent records

These issues significantly impacted KPI calculations.

---

##  Outlier Detection Logic

```sql
SELECT 
MIN(DATEDIFF(discharge_date, admission_date)) AS min_days,
MAX(DATEDIFF(discharge_date, admission_date)) AS max_days
FROM admissions;
```

---

##  Data Cleaning Approach

###  Remove Invalid Records

```sql
WHERE discharge_date >= admission_date
```

###  Filter Realistic Values

```sql
WHERE DATEDIFF(discharge_date, admission_date) BETWEEN 0 AND 365
```

---

##  Final Optimized Query

```sql
SELECT 
ROUND(AVG(DATEDIFF(discharge_date, admission_date))) AS avg_stay_days
FROM admissions
WHERE discharge_date >= admission_date
AND DATEDIFF(discharge_date, admission_date) BETWEEN 0 AND 365;
```

---

## 📈 Key Insights

* Raw data contained critical inconsistencies
* Outliers significantly distorted business metrics
* Data cleaning improved accuracy drastically
* Reliable insights require proper validation

---

## 🧠 What I Learned

* Working with **real-world messy data**
* Identifying **data quality issues**
* Writing **efficient SQL queries**
* Applying **analytical thinking to business problems**

---
