USE MedPulseDB;

-- Query 1: Filter high-risk patient profiles sorted alphabetically
SELECT * FROM PATIENT_PROFILE 
WHERE RiskCategory = 2 
ORDER BY FullName ASC;

-- Query 2: Aggregate total pharmacy stock units exceeding 50 items
SELECT PatientID, SUM(AvailableUnits) AS TotalUnits
FROM PHARMACY_STOCK
GROUP BY PatientID
HAVING TotalUnits > 50;

-- Query 3: Multi-table JOIN linking clinical studies, medical specialists, and roles
SELECT 
    c.StudyTitle,
    CONCAT(m.FirstName, ' ', m.LastName) AS DoctorName,
    a.AssignedRole
FROM CLINICAL_STUDY c
JOIN STUDY_APPOINTMENT a ON c.StudyID = a.StudyID
JOIN MEDICAL_SPECIALIST m ON a.SpecialistID = m.SpecialistID;

-- Query 4: Subquery selecting medical specialists involved in active clinical studies
SELECT FirstName, LastName, PrimaryEmail 
FROM MEDICAL_SPECIALIST 
WHERE SpecialistID IN (
    SELECT SpecialistID FROM STUDY_APPOINTMENT 
    WHERE StudyID IN (SELECT StudyID FROM CLINICAL_STUDY WHERE CurrentStatus = 'Active')
);

-- Query 5: Update capacity limit for a specific diagnostic clinic
UPDATE DIAGNOSTIC_CLINIC 
SET CapacityLimit = 25 
WHERE FacilityName = 'Cardiology Wing';

-- Query 6: Delete test records older than a specific date
DELETE FROM DIAGNOSTIC_TEST 
WHERE TestDate < '2026-01-25';