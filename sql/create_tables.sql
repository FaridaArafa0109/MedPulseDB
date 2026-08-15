CREATE DATABASE IF NOT EXISTS MedPulseDB;
USE MedPulseDB;

-- 1. Medical Specialists / Doctors Table
CREATE TABLE MEDICAL_SPECIALIST (
    SpecialistID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(40) NOT NULL,
    LastName VARCHAR(40) NOT NULL,
    PrimaryEmail VARCHAR(100) UNIQUE,
    ContactNumber VARCHAR(20)
);

-- 2. Diagnostic Clinics / Departments Table
CREATE TABLE DIAGNOSTIC_CLINIC (
    ClinicID INT AUTO_INCREMENT PRIMARY KEY,
    FacilityName VARCHAR(50) NOT NULL,
    CityLocation VARCHAR(50),
    RoomNumber VARCHAR(20),
    CapacityLimit INT
);

-- 3. Drug Formulations Table
CREATE TABLE DRUG_FORMULATION (
    FormulationID INT AUTO_INCREMENT PRIMARY KEY,
    BrandName VARCHAR(50) NOT NULL,
    ActiveIngredient VARCHAR(50),
    SerialCode VARCHAR(30),
    ExpirationDate DATE
);

-- 4. Patient Profiles Table
CREATE TABLE PATIENT_PROFILE (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(80) NOT NULL,
    Gender VARCHAR(10),
    BloodGroup VARCHAR(5),
    RiskCategory INT CHECK (RiskCategory IN (1, 2))
);

-- 5. Clinical Studies Table
CREATE TABLE CLINICAL_STUDY (
    StudyID INT AUTO_INCREMENT PRIMARY KEY,
    StudyTitle VARCHAR(100) NOT NULL,
    StartDate DATE,
    CurrentStatus VARCHAR(20),
    PatientID INT,
    FOREIGN KEY (PatientID) REFERENCES PATIENT_PROFILE(PatientID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 6. Study Appointments / Assignments Table
CREATE TABLE STUDY_APPOINTMENT (
    StudyID INT,
    SpecialistID INT,
    AssignedRole VARCHAR(30),
    PRIMARY KEY (StudyID, SpecialistID),
    FOREIGN KEY (StudyID) REFERENCES CLINICAL_STUDY(StudyID) ON DELETE CASCADE,
    FOREIGN KEY (SpecialistID) REFERENCES MEDICAL_SPECIALIST(SpecialistID) ON DELETE CASCADE
);

-- 7. Treatment Logs Table
CREATE TABLE TREATMENT_LOG (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    SessionCount INT NOT NULL,
    SessionDate DATE,
    DosageLevel VARCHAR(20),
    StudyID INT,
    FormulationID INT,
    ClinicID INT,
    FOREIGN KEY (StudyID) REFERENCES CLINICAL_STUDY(StudyID) ON DELETE CASCADE,
    FOREIGN KEY (FormulationID) REFERENCES DRUG_FORMULATION(FormulationID) ON DELETE SET NULL,
    FOREIGN KEY (ClinicID) REFERENCES DIAGNOSTIC_CLINIC(ClinicID) ON DELETE SET NULL
);

-- 8. Diagnostic Test Results Table
CREATE TABLE DIAGNOSTIC_TEST (
    TestID INT AUTO_INCREMENT PRIMARY KEY,
    TestDate DATE,
    ScreeningType VARCHAR(40),
    ResultStatus VARCHAR(15),
    LogID INT,
    FOREIGN KEY (LogID) REFERENCES TREATMENT_LOG(LogID) ON DELETE CASCADE
);

-- 9. Pharmacy Stock Table
CREATE TABLE PHARMACY_STOCK (
    StockID INT AUTO_INCREMENT PRIMARY KEY,
    AvailableUnits INT NOT NULL,
    ShelfNumber VARCHAR(30),
    RestockDate DATE,
    PatientID INT,
    FOREIGN KEY (PatientID) REFERENCES PATIENT_PROFILE(PatientID) ON DELETE CASCADE
);