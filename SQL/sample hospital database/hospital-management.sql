CREATE DATABASE hospital;
USE hospital;

# 1 --> Table of Doctors details

CREATE TABLE doctor_details (doctor_id INT NOT NULL PRIMARY KEY, doctor_name TEXT NOT NULL,
				gender CHAR(1) NOT NULL, email VARCHAR(50) DEFAULT NULL, password VARCHAR(10) 
                DEFAULT NULL,doctor_status ENUM('Available','Not available') DEFAULT 'Available');
                
INSERT INTO doctor_details (doctor_id, doctor_name, gender, email, password, doctor_status)
				VALUES (1, 'Farhan Ali', 'M', 'farhanali@gmail.com', 'hdcbis', 'Available'),
                (2, 'Ajmal Hayat', 'M', 'ajmalhayat@gmail.com', 'ksuhiuf', 'Available'),
                (3, 'Sidra Kaseen', 'F', 'sidrakaseem@gmail.com', 'jhewjh', 'Not available');

# 2 --> Table of appointments

CREATE TABLE appointments (app_id INT NOT NULL PRIMARY KEY, appointment_date DATE NOT NULL, 
				start_time TIME NOT NULL, end_time TIME NOT NULL, appointment_status ENUM('Done',
                'Not Done')NOT NULL);
                
INSERT INTO appointments (app_id, appointment_date, start_time, end_time, appointment_status)
				VALUES (001, '2022-08-01', '10:00:00', '12:00:00', 'Done'),
                (002, '2022-08-10', '13:00:00', '14:00:00', 'Not Done'),
                (003, '2022-08-09', '15:30:00', '16:00:00', 'Not Done');
                
# 3 --> Table of Patients details

CREATE TABLE patients (patient_id INT NOT NULL PRIMARY KEY, patient_name TEXT NOT NULL, gender CHAR(1) 
				NOT NULL, mobile_no VARCHAR(10) NOT NULL, dob DATE NOT NULL, address TEXT NOT NULL);

INSERT INTO patients (patient_id, patient_name, gender, mobile_no, dob, address)
				VALUES (1, 'Sara Aroom', 'F', '333315557', '1999-05-30', 'Swwat'),
                (2, 'Hira Farhan', 'F', '-1444478', '1997-10-14', 'Swabi'),
                (3, 'Iqbal Hilal', 'M', '155588873', '1990-01-12', 'Swabi');

# 4 --> Table of Schedules of Doctor                

CREATE TABLE schedules (schedule_id INT NOT NULL PRIMARY KEY, date_of_schedule DATE NOT NULL, 
				schedule_day VARCHAR(10) NOT NULL, start_time TIME NOT NULL,
                end_time TIME NOT NULL, break_time VARCHAR(30) NOT NULL);
                
INSERT INTO schedules (schedule_id, date_of_schedule, schedule_day, start_time, end_time, break_time)
				VALUES (01, '2022-08-10', 'Wednesday', '09:00:00', '15:00:00', '12:00:00 - 13:00:00'),
                (02, '2022-08-10', 'Wednesday', '15:00:00', '21:00:00', '18:00:00 - 17:00:00'),
                (03, '2022-08-11', 'Thursday', '09:00:00', '15:00:00', '12:00:00 - 13:00:00');

# 5 --> Table of medical history of patient and doctor

CREATE TABLE medical_history (history_id INT PRIMARY KEY NOT NULL, history_date DATE NOT NULL, medical_condition
				ENUM ('Good', 'Average', 'Poor') NOT NULL, surgeries INT DEFAULT NULL, medication TEXT);
                
INSERT INTO medical_history (history_id, history_date, medical_condition, surgeries, medication)
				VALUES (1, '2020-09-11', 'Average', 1, 'Take only liquids'),
				(2, '2020-10-09', 'Good', 0, 'Take proper rest'),
                (3, '2020-06-22', 'Poor', 2, 'Take healthy food and tablets');
                
# 6 --> Table of patient who attend appointment

CREATE TABLE patient_attend_appointment (app_id INT PRIMARY KEY NOT NULL, patient_id INT NOT NULL,
				concern VARCHAR(25) NOT NULL, symptoms TEXT NOT NULL, FOREIGN KEY(app_id) REFERENCES appointments(app_id)
                ON UPDATE CASCADE, FOREIGN KEY (patient_id) REFERENCES patients(patient_id)ON UPDATE CASCADE);
                
INSERT INTO patient_attend_appointment (app_id, patient_id, concern, symptoms)
				VALUES (001, 2, 'Dengue', 'Fever, Headache'),
                (002, 3, 'Malaria', 'Fever, Headache'),
                (003, 1, 'Allergies', 'Rashes , Sneezing');
				
# 7 --> Table for knowing patient history

CREATE TABLE patient_history (patient_id INT NOT NULL PRIMARY KEY, history_id INT NOT NULL, 
				FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON UPDATE CASCADE, FOREIGN KEY (history_id)
                REFERENCES medical_history(history_id) ON DELETE CASCADE);
                
INSERT INTO patient_history (patient_id, history_id)
				Values(1,2), (2,3), (3,1);
                
# 8 --> Table for Doctor Schedule

CREATE TABLE doctor_schedule (schedule_id INT NOT NULL PRIMARY KEY, doctor_id INT NOT NULL, FOREIGN KEY (schedule_id) REFERENCES
				schedules(schedule_id), FOREIGN KEY (doctor_id) REFERENCES doctor_details(doctor_id));
                
INSERT INTO doctor_schedule (schedule_id, doctor_id)
				VALUES (01, 2), (02, 3), (03, 1);
                
# 9 --> Table contain Diagnose information

CREATE TABLE diagnose (app_id INT NOT NULL PRIMARY KEY, doctor_id INT NOT NULL, diagnose VARCHAR(30) NOT NULL,
				perscription TEXT NOT NULL, FOREIGN KEY (app_id) REFERENCES appointments(app_id), FOREIGN KEY
                (doctor_id) REFERENCES doctor_details(doctor_id));
                
INSERT INTO diagnose (app_id, doctor_id, diagnose, perscription)
				VALUES (001, 2, 'Allergy', 'Choosing wood or hard vinyl floor coverings instead of a carpet'),
                (002, 3, 'Diabities', 'Eat less and eat less sugar things'),
                (003, 1, 'Allergy', 'Choosing wood or hard vinyl floor coverings instead of a carpet');
                
# 10 --> Table for viewing doctor history

CREATE TABLE doctor_history (doctor_id INT NOT NULL PRIMARY KEY, history_id INT NOT NULL, FOREIGN KEY (doctor_id)
				REFERENCES doctor_details(doctor_id), FOREIGN KEY (history_id) REFERENCES medical_history(history_id));
                
INSERT INTO doctor_history(doctor_id, history_id)
				VALUES(1,2), (2,3), (3,1);