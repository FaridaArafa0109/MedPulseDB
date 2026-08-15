USE MedPulseDB;

-- 1. Insert Data into MEDICAL_SPECIALIST
INSERT INTO MEDICAL_SPECIALIST (FirstName, LastName, PrimaryEmail, ContactNumber) VALUES
('Alexander', 'Wright', 'alexander.w@medpulse.org', '01011110001'),
('Sophia', 'Martinez', 'sophia.m@medpulse.org', '01022220002'),
('Daniel', 'Taylor', 'daniel.t@medpulse.org', '01033330003'),
('Emma', 'Thomas', 'emma.t@medpulse.org', '01044440004'),
('Christopher', 'White', 'chris.w@medpulse.org', '01055550005'),
('Olivia', 'Harris', 'olivia.h@medpulse.org', '01066660006'),
('Matthew', 'Martin', 'matthew.m@medpulse.org', '01077770007'),
('Ava', 'Clark', 'ava.c@medpulse.org', '01088880008'),
('Andrew', 'Lewis', 'andrew.l@medpulse.org', '01099990009'),
('Isabella', 'Walker', 'isabella.w@medpulse.org', '01100000010');

-- 2. Insert Data into DIAGNOSTIC_CLINIC
INSERT INTO DIAGNOSTIC_CLINIC (FacilityName, CityLocation, RoomNumber, CapacityLimit) VALUES
('Cardiology Wing', 'Building A', 'Room 101', 15),
('Neurology Center', 'Building A', 'Room 102', 10),
('Oncology Care', 'Building B', 'Room 201', 20),
('Pulmonology Lab', 'Building B', 'Room 202', 12),
('Endocrinology Unit', 'Building C', 'Room 301', 18),
('Hematology Clinic', 'Building C', 'Room 302', 14),
('Immunology Dept', 'Building D', 'Room 401', 25),
('Dermatology Care', 'Building D', 'Room 402', 10),
('Nephrology Unit', 'Building E', 'Room 501', 16),
('General Surgery Lab', 'Building E', 'Room 502', 22);

-- 3. Insert Data into DRUG_FORMULATION
INSERT INTO DRUG_FORMULATION (BrandName, ActiveIngredient, SerialCode, ExpirationDate) VALUES
('Lipitor Plus', 'Atorvastatin', 'MED-2026-001', '2026-12-31'),
('Glucophage XR', 'Metformin', 'MED-2026-002', '2026-11-20'),
('Ventolin HFA', 'Albuterol', 'MED-2026-003', '2027-01-15'),
('Zoloft Care', 'Sertraline', 'MED-2026-004', '2026-10-10'),
('Humira Pro', 'Adalimumab', 'MED-2026-005', '2026-09-05'),
('Keytruda Sub', 'Pembrolizumab', 'MED-2026-006', '2027-03-30'),
('Revlimid Standard', 'Lenalidomide', 'MED-2026-007', '2026-08-18'),
('Eliquis Daily', 'Apixaban', 'MED-2026-008', '2027-02-28'),
('Opdivo Active', 'Nivolumab', 'MED-2026-009', '2026-12-05'),
('Imbruvica Max', 'Ibrutinib', 'MED-2026-010', '2027-04-12');

-- 4. Insert Data into PATIENT_PROFILE
INSERT INTO PATIENT_PROFILE (FullName, Gender, BloodGroup, RiskCategory) VALUES
('Arthur Pendelton', 'Male', 'A+', 2),
('Beatrice Vance', 'Female', 'O-', 1),
('Charles Montgomery', 'Male', 'B+', 2),
('Diana Prince', 'Female', 'AB+', 1),
('Edward Stark', 'Male', 'O+', 1),
('Fiona Gallagher', 'Female', 'A-', 2),
('George Russell', 'Male', 'B-', 1),
('Hannah Abbott', 'Female', 'O+', 2),
('Ian Malcolm', 'Male', 'AB-', 1),
('Julia Roberts', 'Female', 'A+', 2);

-- 5. Insert Data into CLINICAL_STUDY
INSERT INTO CLINICAL_STUDY (StudyTitle, StartDate, CurrentStatus, PatientID) VALUES
('Hypertension Control Trial', '2026-01-15', 'Active', 1),
('Type 2 Diabetes Management', '2026-02-01', 'Active', 2),
('Asthma Treatment Efficacy', '2026-02-10', 'Active', 3),
('Depression Therapy Observation', '2026-03-01', 'Completed', 4),
('Rheumatoid Arthritis Study', '2026-03-15', 'Active', 5),
('Immunotherapy Response Log', '2026-04-01', 'Active', 6),
('Multiple Myeloma Screening', '2026-04-12', 'Suspended', 7),
('Anticoagulant Safety Trial', '2026-05-01', 'Active', 8),
('Melanoma Target Treatment', '2026-05-18', 'Active', 9),
('Leukemia Inhibitor Testing', '2026-06-05', 'Completed', 10);

-- 6. Insert Data into STUDY_APPOINTMENT
INSERT INTO STUDY_APPOINTMENT (StudyID, SpecialistID, AssignedRole) VALUES
(1, 1, 'Primary Physician'), (1, 2, 'Consultant'),
(2, 3, 'Primary Physician'), (3, 4, 'Primary Physician'),
(4, 5, 'Consultant'), (5, 6, 'Primary Physician'),
(6, 7, 'Primary Physician'), (7, 8, 'Consultant'),
(8, 9, 'Primary Physician'), (9, 10, 'Primary Physician');

-- 7. Insert Data into TREATMENT_LOG
INSERT INTO TREATMENT_LOG (SessionCount, SessionDate, DosageLevel, StudyID, FormulationID, ClinicID) VALUES
(1, '2026-01-20', '10mg Daily', 1, 1, 1),
(2, '2026-01-28', '20mg Daily', 1, 1, 1),
(1, '2026-02-05', '500mg Daily', 2, 2, 2),
(1, '2026-02-15', '2 Inhalations', 3, 3, 3),
(3, '2026-03-08', '50mg Daily', 4, 4, 4),
(1, '2026-03-20', '40mg Biweekly', 5, 5, 5),
(2, '2026-04-10', '200mg Monthly', 6, 6, 6),
(1, '2026-04-20', '25mg Daily', 7, 7, 7),
(2, '2026-05-05', '5mg Twice Daily', 8, 8, 8),
(1, '2026-05-22', '240mg Monthly', 9, 9, 9);

-- 8. Insert Data into DIAGNOSTIC_TEST
INSERT INTO DIAGNOSTIC_TEST (TestDate, ScreeningType, ResultStatus, LogID) VALUES
('2026-01-21', 'Blood Pressure Check', 'Normal', 1),
('2026-01-29', 'ECG Scan', 'Normal', 2),
('2026-02-06', 'HbA1c Blood Test', 'Normal', 3),
('2026-02-16', 'Spirometry Test', 'Abnormal', 4),
('2026-03-09', 'Psychometric Evaluation', 'Normal', 5),
('2026-03-21', 'Joint Inflammation Biomarker', 'Normal', 6),
('2026-04-11', 'T-Cell Count Assay', 'Normal', 7),
('2026-04-21', 'Bone Marrow Biopsy', 'Abnormal', 8),
('2026-05-06', 'Coagulation Profile', 'Normal', 9),
('2026-05-23', 'PET Scan', 'Normal', 10);

-- 9. Insert Data into PHARMACY_STOCK
INSERT INTO PHARMACY_STOCK (AvailableUnits, ShelfNumber, RestockDate, PatientID) VALUES
(40, 'Shelf-A1', '2026-01-05', 1),
(100, 'Shelf-A2', '2026-01-10', 2),
(25, 'Shelf-B1', '2026-01-15', 3),
(60, 'Shelf-B2', '2026-01-20', 4),
(150, 'Cabinet-C1', '2026-02-01', 5),
(80, 'Cabinet-C2', '2026-02-10', 6),
(18, 'Shelf-D1', '2026-02-15', 7),
(90, 'Cabinet-D2', '2026-03-01', 8),
(45, 'Shelf-E1', '2026-03-10', 9),
(110, 'Cabinet-E2', '2026-03-20', 10);