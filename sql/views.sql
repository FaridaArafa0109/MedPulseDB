USE MedPulseDB;

-- View 1: View active clinical studies with corresponding patient details
CREATE OR REPLACE VIEW vw_active_clinical_studies AS
SELECT 
    s.StudyID,
    s.StudyTitle,
    s.StartDate,
    p.FullName AS PatientName,
    p.RiskCategory
FROM CLINICAL_STUDY s
JOIN PATIENT_PROFILE p ON s.PatientID = p.PatientID
WHERE s.CurrentStatus = 'Active';

-- View 2: View abnormal diagnostic test results for urgent clinical review
CREATE OR REPLACE VIEW vw_abnormal_test_results AS
SELECT 
    t.TestID,
    t.TestDate,
    t.ScreeningType,
    l.SessionCount,
    s.StudyTitle
FROM DIAGNOSTIC_TEST t
JOIN TREATMENT_LOG l ON t.LogID = l.LogID
JOIN CLINICAL_STUDY s ON l.StudyID = s.StudyID
WHERE t.ResultStatus = 'Abnormal';