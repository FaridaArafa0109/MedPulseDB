from flask import Flask, render_template, request, redirect, url_for, flash
from flask_mysqldb import MySQL

app = Flask(__name__)
app.secret_key = 'medpulse_secret_key'

# MySQL Configuration
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'MedPulseDB'

mysql = MySQL(app)


# ==============================================================================
# 1. PATIENT PROFILES (PATIENT_PROFILE)
# ==============================================================================
@app.route('/')
@app.route('/patients')
def patients():
    cur = mysql.connection.cursor()
    cur.execute("SELECT PatientID, FullName, Gender, BloodGroup, RiskCategory FROM PATIENT_PROFILE")
    patient_data = cur.fetchall()
    cur.close()
    return render_template('patients.html', patients=patient_data)

@app.route('/patient/insert', methods=['POST'])
def patient_insert():
    if request.method == "POST":
        full_name = request.form['FullName']
        gender = request.form['Gender']
        blood_group = request.form['BloodGroup']
        risk_category = request.form['RiskCategory']

        cur = mysql.connection.cursor()
        cur.execute(
            "INSERT INTO PATIENT_PROFILE (FullName, Gender, BloodGroup, RiskCategory) VALUES (%s, %s, %s, %s)",
            (full_name, gender, blood_group, risk_category)
        )
        mysql.connection.commit()
        cur.close()
        flash("Patient Profile Registered Successfully")
        return redirect(url_for('patients'))

@app.route('/patient/update', methods=['POST'])
def patient_update():
    if request.method == 'POST':
        patient_id = request.form['PatientID']
        full_name = request.form['FullName']
        gender = request.form['Gender']
        blood_group = request.form['BloodGroup']
        risk_category = request.form['RiskCategory']

        cur = mysql.connection.cursor()
        cur.execute(
            "UPDATE PATIENT_PROFILE SET FullName=%s, Gender=%s, BloodGroup=%s, RiskCategory=%s WHERE PatientID=%s",
            (full_name, gender, blood_group, risk_category, patient_id)
        )
        mysql.connection.commit()
        cur.close()
        flash("Patient Profile Updated Successfully")
        return redirect(url_for('patients'))

@app.route('/patient/delete/<int:id_data>', methods=['GET'])
def patient_delete(id_data):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM PATIENT_PROFILE WHERE PatientID=%s", (id_data,))
    mysql.connection.commit()
    cur.close()
    flash("Patient Record Deleted Successfully")
    return redirect(url_for('patients'))


# ==============================================================================
# 2. MEDICAL SPECIALISTS (MEDICAL_SPECIALIST)
# ==============================================================================
@app.route('/specialists')
def specialists():
    cur = mysql.connection.cursor()
    cur.execute("SELECT SpecialistID, FirstName, LastName, PrimaryEmail, ContactNumber FROM MEDICAL_SPECIALIST")
    specialist_data = cur.fetchall()
    cur.close()
    return render_template('specialists.html', specialists=specialist_data)

@app.route('/specialist/insert', methods=['POST'])
def specialist_insert():
    if request.method == "POST":
        first_name = request.form['FirstName']
        last_name = request.form['LastName']
        email = request.form['PrimaryEmail']
        contact = request.form['ContactNumber']

        cur = mysql.connection.cursor()
        cur.execute(
            "INSERT INTO MEDICAL_SPECIALIST (FirstName, LastName, PrimaryEmail, ContactNumber) VALUES (%s, %s, %s, %s)",
            (first_name, last_name, email, contact)
        )
        mysql.connection.commit()
        cur.close()
        flash("Medical Specialist Registered Successfully")
        return redirect(url_for('specialists'))

@app.route('/specialist/update', methods=['POST'])
def specialist_update():
    if request.method == 'POST':
        specialist_id = request.form['SpecialistID']
        first_name = request.form['FirstName']
        last_name = request.form['LastName']
        email = request.form['PrimaryEmail']
        contact = request.form['ContactNumber']

        cur = mysql.connection.cursor()
        cur.execute(
            "UPDATE MEDICAL_SPECIALIST SET FirstName=%s, LastName=%s, PrimaryEmail=%s, ContactNumber=%s WHERE SpecialistID=%s",
            (first_name, last_name, email, contact, specialist_id)
        )
        mysql.connection.commit()
        cur.close()
        flash("Specialist Record Updated Successfully")
        return redirect(url_for('specialists'))

@app.route('/specialist/delete/<int:id_data>', methods=['GET'])
def specialist_delete(id_data):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM MEDICAL_SPECIALIST WHERE SpecialistID=%s", (id_data,))
    mysql.connection.commit()
    cur.close()
    flash("Specialist Record Deleted Successfully")
    return redirect(url_for('specialists'))


# ==============================================================================
# 3. CLINICAL STUDIES (CLINICAL_STUDY)
# ==============================================================================
@app.route('/studies')
def studies():
    cur = mysql.connection.cursor()
    # Query all studies along with patient full name
    cur.execute("""
        SELECT cs.StudyID, cs.StudyTitle, cs.StartDate, cs.CurrentStatus, cs.PatientID, pp.FullName
        FROM CLINICAL_STUDY cs
        LEFT JOIN PATIENT_PROFILE pp ON cs.PatientID = pp.PatientID
    """)
    studies_data = cur.fetchall()

    # Query patients dropdown options
    cur.execute("SELECT PatientID, FullName FROM PATIENT_PROFILE")
    patient_options = cur.fetchall()
    cur.close()

    return render_template('studies.html', studies=studies_data, patients=patient_options)

@app.route('/study/insert', methods=['POST'])
def study_insert():
    if request.method == "POST":
        title = request.form['StudyTitle']
        start_date = request.form['StartDate']
        status = request.form['CurrentStatus']
        patient_id = request.form['PatientID']

        cur = mysql.connection.cursor()
        cur.execute(
            "INSERT INTO CLINICAL_STUDY (StudyTitle, StartDate, CurrentStatus, PatientID) VALUES (%s, %s, %s, %s)",
            (title, start_date, status, patient_id)
        )
        mysql.connection.commit()
        cur.close()
        flash("Clinical Study Added Successfully")
        return redirect(url_for('studies'))

@app.route('/study/update', methods=['POST'])
def study_update():
    if request.method == 'POST':
        study_id = request.form['StudyID']
        title = request.form['StudyTitle']
        start_date = request.form['StartDate']
        status = request.form['CurrentStatus']
        patient_id = request.form['PatientID']

        cur = mysql.connection.cursor()
        cur.execute(
            "UPDATE CLINICAL_STUDY SET StudyTitle=%s, StartDate=%s, CurrentStatus=%s, PatientID=%s WHERE StudyID=%s",
            (title, start_date, status, patient_id, study_id)
        )
        mysql.connection.commit()
        cur.close()
        flash("Clinical Study Updated Successfully")
        return redirect(url_for('studies'))

@app.route('/study/delete/<int:id_data>', methods=['GET'])
def study_delete(id_data):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM CLINICAL_STUDY WHERE StudyID=%s", (id_data,))
    mysql.connection.commit()
    cur.close()
    flash("Clinical Study Deleted Successfully")
    return redirect(url_for('studies'))


# ==============================================================================
# 4. STUDY APPOINTMENTS (STUDY_APPOINTMENT)
# ==============================================================================
@app.route('/appointments')
def appointments():
    cur = mysql.connection.cursor()
    # Selected StudyID and SpecialistID directly instead of non-existent AppointmentID
    cur.execute("""
        SELECT sa.StudyID, cs.StudyTitle, sa.SpecialistID, 
               CONCAT(ms.FirstName, ' ', ms.LastName) AS SpecialistName, sa.AssignedRole
        FROM STUDY_APPOINTMENT sa
        LEFT JOIN CLINICAL_STUDY cs ON sa.StudyID = cs.StudyID
        LEFT JOIN MEDICAL_SPECIALIST ms ON sa.SpecialistID = ms.SpecialistID
    """)
    appointment_data = cur.fetchall()

    # Dropdown Options
    cur.execute("SELECT StudyID, StudyTitle FROM CLINICAL_STUDY")
    study_options = cur.fetchall()

    cur.execute("SELECT SpecialistID, CONCAT(FirstName, ' ', LastName) FROM MEDICAL_SPECIALIST")
    specialist_options = cur.fetchall()
    cur.close()

    return render_template(
        'appointments.html',
        appointments=appointment_data,
        studies=study_options,
        specialists=specialist_options
    )


@app.route('/appointment/insert', methods=['POST'])
def appointment_insert():
    if request.method == "POST":
        study_id = request.form['StudyID']
        specialist_id = request.form['SpecialistID']
        assigned_role = request.form['AssignedRole']

        cur = mysql.connection.cursor()
        cur.execute(
            "INSERT INTO STUDY_APPOINTMENT (StudyID, SpecialistID, AssignedRole) VALUES (%s, %s, %s)",
            (study_id, specialist_id, assigned_role)
        )
        mysql.connection.commit()
        cur.close()
        flash("Appointment/Assignment Created Successfully")
        return redirect(url_for('appointments'))


@app.route('/appointment/update', methods=['POST'])
def appointment_update():
    if request.method == 'POST':
        # Composite primary key identifying target record
        old_study_id = request.form['OldStudyID']
        old_specialist_id = request.form['OldSpecialistID']

        new_study_id = request.form['StudyID']
        new_specialist_id = request.form['SpecialistID']
        assigned_role = request.form['AssignedRole']

        cur = mysql.connection.cursor()
        cur.execute(
            """
            UPDATE STUDY_APPOINTMENT 
            SET StudyID=%s, SpecialistID=%s, AssignedRole=%s 
            WHERE StudyID=%s AND SpecialistID=%s
            """,
            (new_study_id, new_specialist_id, assigned_role, old_study_id, old_specialist_id)
        )
        mysql.connection.commit()
        cur.close()
        flash("Appointment Record Updated Successfully")
        return redirect(url_for('appointments'))


@app.route('/appointment/delete/<int:study_id>/<int:specialist_id>', methods=['GET'])
def appointment_delete(study_id, specialist_id):
    cur = mysql.connection.cursor()
    cur.execute(
        "DELETE FROM STUDY_APPOINTMENT WHERE StudyID=%s AND SpecialistID=%s",
        (study_id, specialist_id)
    )
    mysql.connection.commit()
    cur.close()
    flash("Appointment Record Deleted Successfully")
    return redirect(url_for('appointments'))


if __name__ == "__main__":
    app.run(debug=True)