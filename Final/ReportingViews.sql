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

Select *
From Appointments
Join
Clinics
On Appointments.ClinicID = Clinics.ClinicID


Select *
From Clinics
Join 
Do