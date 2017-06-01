/****************************************************************
Title: INFO 340 - Module 8: Security Part 1
Desc: This file shows the answers to the Module 8 questions. The tasks include creating a new database 
(tables, views, stored procedures) and setting database security on the database so that only views and 
stored procedures can be used by the public role
Dev: Kyle Porter
ChangeLog:
5/20/17,Kyle Porter,Created script for tables and stored procedures.
****************************************************************/

Use master
GO

Create Database PatientAppointmentProject
GO

Use PatientAppointmentProject
GO

Create Table Patients 
    (PatientID int Identity Primary Key,
    PatientFirstName nvarchar(50) Not Null,
    PatientLastName nvarchar(50) Not Null,
    PatientPhoneNumber nvarchar(20) Not Null,
    PatientEmail nvarchar(50) Not Null,
    PatientAddress nvarchar(50) Not Null,
    PatientCity nvarchar(50) Not Null,
    PatientState char(2), Not Null,
    PatientZip nvarchar(10) Not Null)
GO

Create Table Doctors 
    (DoctorID int Identity Primary Key,
    DoctorFirstName nvarchar(50) Not Null,
    DoctorLastName nvarchar(50) Not Null,
    DoctorPhoneNumber nvarchar(20) Not Null,
    DoctorEmail nvarchar(50) Not Null)
GO

Create Table Appointments 
    (AppointmentID int Identity Primary Key,
    PatientID int Foreign Key References Patients(PatientID),
    DoctorID int Foreign Key References Doctors(DoctorID),
    ClinicID int Foreign Key References Clinic(ClinicID),
    AppointmentDatetime nvarchar(50) Not Null,
    Check AppointmentDatetime > CURRENT_TIMESTAMP)
GO

Create Table Clinics
    (ClinicID int identity Primary Key,
    ClinicName nvarchar(50) Not Null,
    ClinicPhone nvarchar(20) Not Null,
    ClinicEmail nvarchar(50) Not Null,
    ClinicAddress nvarchar(50) Not Null,
    ClinicCity nvarchar(50) Not Null,
    ClinicState char(2) Not Null,
    ClinicZip nvarchar(10) Not Null

GO

Create Table PatientAppointments
    (PatientAppointmentID int Identity Primary Key,
    PatientID int Foreign Key References Patients(PatientID),
    AppointmentID int Foreign Key References Appointments(AppointmentID))
GO

Create Table DoctorClinics
    (DoctorClinicID int Identity Primary Key,
    DoctorID int Foreign Key References Doctors(DoctorID),
    ClinicID int Foreign Key References Clinic(ClinicID))
GO

Create View vPatients AS
	Select * FROM Patients
GO

Create View vDoctors AS
	Select * FROM Doctors
GO

Create View vAppointments AS
    Select * FROM Appointments
GO

Create View vClinics AS
    Select * FROM Clinics
GO

Create View vPatientAppointments AS
    Select * FROM PatientAppointments
GO

Create View vDoctorClinics AS
    Select * FROM DoctorClinics
GO


Create Procedure pInsPatient
    (@PatientFirstName nvarchar(50),
    @PatientLastName nvarchar(50),
    @PatientPhoneNumber nvarchar(20),
    @PatientEmail nvarchar(50),
    @PatientAddress nvarchar(50),
    @PatientCity nvarchar(50),
    @PatientState char(2),
    @PatientZip nvarchar(10)) AS
BEGIN TRANSACTION
BEGIN TRY
	Insert Into Patients
        (PatientFirstName,
        PatientLastName,
        PatientPhoneNumber,
        PatientEmail,
        PatientAddress,
        PatientCity,
        PatientState,
        PatientZip)
	Values 
        (@PatientFirstName,
        @PatientLastName,
        @PatientPhoneNumber,
        @PatientEmail,
        @PatientAddress,
        @PatientCity,
        @PatientState,
        @PatientZip) 
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
    ROLLBACK TRANSACTION
END CATCH 
GO

Create Procedure pUpdPatient 
    (@PatientID int,
    @PatientFirstName nvarchar(50),
    @PatientLastName nvarchar(50),
    @PatientPhoneNumber nvarchar(20),
    @PatientEmail nvarchar(50),
    @PatientAddress nvarchar(50),
    @PatientCity nvarchar(50),
    @PatientState char(2),
    @PatientZip nvarchar(50)) AS
BEGIN TRANSACTION
BEGIN TRY
	Update Patients Set
        PatientFirstName = @PatientFirstName,
        PatientLastName = @PatientLastName,
        PatientPhoneNumber = @PatientPhoneNumber,
        PatientEmail = @PatientEmail,
        PatientAddress = @PatientAddress,
        PatientCity = @PatientCity,
        PatientState = @PatientState,
        PatientZip = @PatientZip
    Where PatientID = @PatientID
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
    ROLLBACK TRANSACTION
END CATCH
GO

Create Procedure pDelPatient (@PatientID int) AS
BEGIN TRANSACTION
BEGIN TRY
		Delete From Patients
        Where PatientID = @PatientID
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
    ROLLBACK TRANSACTION
END CATCH 
GO

Create Procedure pInsDoctor 
    (@DoctorFirstName nvarchar(50),
    @DoctorLastName nvarchar(50),
    @DoctorPhoneNumber nvarchar(20),
    @DoctorEmail nvarchar(50))
 AS
BEGIN TRANSACTION
BEGIN TRY
	Insert Into Doctors 
        (DoctorFirstName,
        DoctorLastName,
        DoctorPhoneNumber,
        DoctorEmail)
    Values
        (@DoctorFirstName,
        @DoctorLastName,
        @DoctorPhoneNumber,
        @DoctorEmail)
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
    ROLLBACK TRANSACTION
END CATCH 
GO

Create Procedure pUpdDoctor 
    (@DoctorID int,
    @DoctorFirstName nvarchar(50),
    @DoctorLastName nvarchar(50),
    @DoctorPhoneNumber nvarhcar(20),
    @DoctorEmail nvarchar(50)) AS
BEGIN TRANSACTION
BEGIN TRY
	Update Doctors Set
    (DoctorFirstName = @DoctorFirstName,
    DoctorLastName = @DoctorLastName,
    DoctorPhoneNumber = @DoctorPhoneNumber,
    DoctorEmail = @DoctorEmail)
	Where DoctorID = @DoctorID
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
    ROLLBACK TRANSACTION
END CATCH 
GO

Create Procedure pDelDoctor (@DoctorID int) AS
BEGIN TRANSACTION
BEGIN TRY
		Delete From Doctors
		Where DoctorID = @DoctorID
		COMMIT TRANSACTION
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
    ROLLBACK TRANSACTION
END CATCH 
GO

Create Procedure pInsAppointment
    (@PatientID int,
    @DoctorID int,
    @AppointmentDatetime datetime) AS
BEGIN TRANSACTION
BEGIN TRY
    Insert Into Appointments
        (PatientID,
        DoctorID,
        AppointmentDatetime)
    Values
        (@PatientID,
        @DoctorID,
        @AppointmentDatetime)
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
    ROLLBACK TRANSACTION
END CATCH 
GO

Create Procedure pUpdAppointments 
    (@AppointmentID
    @PatientID
    @DoctorID
    @AppointmentDatetime) AS
BEGIN TRANSACTION
BEGIN TRY
    Update Appointments Set
        (PatientID = @PatientID,
        DoctorID = @DoctorID,
        AppointmentDatetime = @AppointmentDatetime)
    Where AppointmentID = @AppointmentID
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
    ROLLBACK TRANSACTION
END CATCH 
GO

Create Procedure pDelAppointment (@AppointmentID int) AS
BEGIN TRANSACTION
BEGIN TRY
        Delete From Appointments
        Where AppointmentID = @AppointmentID
        COMMIT TRANSACTION
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
    ROLLBACK TRANSACTION
END CATCH 
GO

Create Procedure pInsClinic
    (@ClinicName nvarchar(50),
    @ClinicPhone nvarchar(20),
    @ClinicEmail nvarchar(50),
    @ClinicAddress nvarchar(50),
    @ClinicCity nvarchar(50),
    @ClinicState char(2),
    @ClinicZip nvarchar(10)) AS
BEGIN TRANSACTION
BEGIN TRY
    Insert Into Clinics 
        (ClinicName,
        ClinicPhone,
        ClinicEmail,
        ClinicAddress,
        ClinicCity,
        ClinicState,
        ClinicZip)
    Values
        (@ClinicName,
        @ClinicPhone,
        @ClinicEmail,
        @ClinicAddress,
        @ClinicCity,
        @ClinicState,
        @ClinicZip)
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
    ROLLBACK TRANSACTION
END CATCH 
GO

Create Procedure pUpdClinics
    (@ClinicID int,
    @ClinicName nvarchar(50),
    @ClinicPhone nvarchar(20),
    @ClinicEmail nvarchar(50),
    @ClinicAddress nvarchar(50),
    @ClinicCity nvarchar(50),
    @ClinicState char(2),
    @ClinicZip nvarchar(10)) AS
BEGIN TRANSACTION
BEGIN TRY
    Update Clinics Set
    (ClinicName = @ClinicName,
    ClinicPhone = @ClinicPhone,
    ClinicEmail = @ClinicEmail,
    ClinicAddress = @ClinicAddress,
    ClinicCity = @ClinicCity,
    ClinicState = @ClinicState,
    ClinicZip = @ClinicZip)
    Where ClinicID = @ClinicID
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
    ROLLBACK TRANSACTION
END CATCH 
GO

Create Procedure pDelClinic (@ClinicID int) AS
BEGIN TRANSACTION
BEGIN TRY
        Delete From Clinics
        Where ClinicID = @ClinicID
        COMMIT TRANSACTION
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
    ROLLBACK TRANSACTION
END CATCH 
GO
------------------------------------------------DO PERMISSIONS V V V V
Deny Select On Products to Public
GO

Deny Select On Inventories to Public
GO

Deny Insert On Products to Public
GO

Deny Insert On Inventories to Public
GO

Deny Update On Products to Public
GO

Deny Update On Inventories to Public
GO

Deny Delete On Products to Public
GO

Deny Delete On Inventories to Public
GO


Grant Select On vProducts to Public
GO

Grant Select On vInventories to Public
GO

Grant Exec On uspInsProduct to Public
GO

Grant Exec On uspInsInventory to Public
GO

Grant Exec On uspUpdProduct to Public
GO

Grant Exec On uspUpdInventory to Public
GO

Grant Exec On uspDelProduct to Public
GO

Grant Exec On uspDelInventory to Public
GO