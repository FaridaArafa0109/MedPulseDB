USE MedPulseDB;

-- Stored Procedure: Fetch all clinical studies associated with a specific patient
DELIMITER //
CREATE PROCEDURE sp_GetStudiesByPatient(IN p_PatientID INT)
BEGIN
    SELECT 
        StudyID,
        StudyTitle,
        StartDate,
        CurrentStatus
    FROM CLINICAL_STUDY
    WHERE PatientID = p_PatientID;
END //
DELIMITER ;

-- Trigger: Prevent setting negative available units in pharmacy stock
DELIMITER //
CREATE TRIGGER trg_validate_stock_quantity
BEFORE INSERT ON PHARMACY_STOCK
FOR EACH ROW
BEGIN
    IF NEW.AvailableUnits < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pharmacy stock available units cannot be negative!';
    END IF;
END //
DELIMITER ;