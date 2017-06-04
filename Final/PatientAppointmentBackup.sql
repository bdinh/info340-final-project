/****************************************************************
Title: INFO 340 - Final Project: Database Script
Desc: This file shows the database script for the final project. The tasks include creating a backup of the database
with sample data. 
Dev: Kyle Porter, Bao Dinh
ChangeLog: 06/03/17 - Kyle Porter - Create Backup and Restore script. Stores data in [PatientAppointmentProjectDev].
****************************************************************/

USE master
GO

BACKUP DATABASE [PatientAppointmentProject] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Backup\PatientAppointmentProject_LogBackup_2017-06-03_19-18-45.bak' WITH NOFORMAT, NOINIT,  NAME = N'PatientAppointmentProject-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

BACKUP LOG [PatientAppointmentProject] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Backup\PatientAppointmentProject_LogBackup_2017-06-03_19-32-51.bak' WITH NOFORMAT, NOINIT,  NAME = N'PatientAppointmentProject_LogBackup_2017-06-03_19-32-51', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [PatientAppointmentProjectDev] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Backup\PatientAppointmentProject_LogBackup_2017-06-03_19-18-45.bak' WITH  FILE = 1,  MOVE N'PatientAppointmentProject' TO N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\PatientAppointmentProjectDev.mdf',  MOVE N'PatientAppointmentProject_log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\PatientAppointmentProjectDev_log.ldf',  KEEP_REPLICATION,  NOUNLOAD, RECOVERY,  REPLACE,  STATS = 5
GO

