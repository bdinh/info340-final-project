/****************************************************************
Title: INFO 340 - Final Project: Database Script
Desc: This file shows the database script for the final project. The tasks include creating reporting
views that will be use to generate reports though Excel, Report Builder, and PowerBi.
Dev: Kyle Porter, Bao Dinh
ChangeLog:
****************************************************************/

Use master
GO

Use PatientAppointmentProject
GO

Create View vAppointmentsReport
As
Select Appointments.AppointmentDatetime, Clinics.ClinicName, Clinics.ClinicCity, Clinics.ClinicState, Patients.PatientFirstName + ' ' + Patients.PatientLastName as [Patient Name]
From Appointments
Join Clinics
On Appointments.ClinicID = Clinics.ClinicID
JOin Patients
On Appointments.PatientID = Patients.PatientID
Go

Create View vPatientPerState
As
Select  Count(PatientID) as [Number of Patients], PatientState
From Patients
Group By PatientState
Go

Create View vPatientPerCity
As
Select  Count(PatientID) as [Number of Patients], PatientCity
From Patients
Group By PatientCity
Go


Create View vClinicPerState
As
Select  Count(ClinicID) as [Number of Clinics], ClinicState
From Clinics
Group By ClinicState
Go

Create View vClinicPerCity
As
Select  Count(ClinicID) as [Number of Clinics], ClinicCity
From Clinics
Group By ClinicCity
Go

Create View vDoctorPerState
As
Select  Count(CliniID) as [Number of Clinics], ClinicState
From Doctors
Group By Doctor
Go

Create View vDoctorPerCity
As
Select  Count(ClinicID) as [Number of Clinics], ClinicCity
From Clinics
Group By ClinicCity
Go


Create View vDoctorsPerState
As
Select Count(Doctors.DoctorID) as [Number of Doctors], Clinics.ClinicState
From DoctorClinics
Join Doctors
On DoctorClinics.DoctorID = Doctors.DoctorID
Join Clinics
On DoctorClinics.ClinicID = Clinics.ClinicID
Group By Clinics.ClinicState
Go

Create View vDoctorsPerCity
As
Select Count(Doctors.DoctorID) as [Number of Doctors], Clinics.ClinicCity, Clinics.ClinicState, Clinics.ClinicName
From DoctorClinics
Join Doctors
On DoctorClinics.DoctorID = Doctors.DoctorID
Join Clinics
On DoctorClinics.ClinicID = Clinics.ClinicID
Group By Clinics.ClinicCity, Clinics.ClinicState, Clinics.ClinicName
Go

Create View vAppointmentsByMonth
As
SELECT MONTH(AppointmentDatetime) as [Month Number], 
       UPPER(left(DATENAME(MONTH,AppointmentDatetime),3)) as [Month], 
       Count(* ) as [Number of Appointments]
FROM     Appointments
GROUP BY MONTH(AppointmentDatetime), 
         DATENAME(MONTH,AppointmentDatetime) 

Create View vAppointmentsByDay
As
SELECT Day(AppointmentDatetime) as [Day Number],  
       Count(* ) as [Number of Appointments]
FROM     Appointments
GROUP BY DAY(AppointmentDatetime)