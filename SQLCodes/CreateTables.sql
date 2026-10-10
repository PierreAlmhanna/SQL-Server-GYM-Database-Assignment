
/* SVU_MCS_DBS_F25_SQLCode_C1_Pierre_404041 */

/* --------------------------------------01-------------------------------------------- */

CREATE DATABASE GYM_DB;

/* --------------------------------------02-------------------------------------------- */
CREATE TABLE Governorate (
	GovernorateId INT IDENTITY (1,1) PRIMARY KEY, 
	Governorate VARCHAR (20) NOT NULL UNIQUE
);	

CREATE TABLE Branch (
	BranchId INT IDENTITY (1,1) PRIMARY KEY,
	BranchName VARCHAR (50) NOT NULL UNIQUE, 
	BranchLocation VARCHAR (50) NULL,
	BranchPhone CHAR (10) NULL UNIQUE CHECK (len(BranchPhone) = 10), 
	BranchCapacity INT NOT NULL CHECK (BranchCapacity > 0), 
	BranchBrochure VARCHAR (250) NULL,
	GovernorateId INT NOT NULL FOREIGN KEY REFERENCES Governorate(GovernorateId)
);

CREATE TABLE Warehouse (
	WarehouseId INT IDENTITY (1,1) PRIMARY KEY,
	WarehouseName VARCHAR (50) NOT NULL UNIQUE, 
	WarehouseLocation VARCHAR (50) NULL, 
	WarehousePhone CHAR (10) NULL UNIQUE CHECK (len(WarehousePhone) = 10), 
	WarehouseBrochure VARCHAR (250) NULL,
	GovernorateId INT NOT NULL FOREIGN KEY REFERENCES Governorate(GovernorateId),
	BranchId INT NOT NULL FOREIGN KEY REFERENCES Branch(BranchId)
);

CREATE TABLE Specialization (
	SpecializationId INT IDENTITY (1,1) PRIMARY KEY,
	Specialization VARCHAR(50) NOT NULL UNIQUE 
);

CREATE TABLE TrainerStatus (
	TrainerStatusId INT IDENTITY (1,1) PRIMARY KEY,
	TrainerStatus VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Trainer (
	TrainerId INT IDENTITY (1,1) PRIMARY KEY,
	TrainerName VARCHAR(50) NOT NULL,
	TrainerNationalId CHAR(11) NOT NULL UNIQUE CHECK (len(TrainerNationalId) = 11),
	TrainerBirthDate DATE NULL CHECK (TrainerBirthDate between '01-01-1966' and '01-01-2008'),
	TrainerPhone CHAR (10) NULL UNIQUE CHECK (len(TrainerPhone) = 10),
	TrainerEmail VARCHAR (100) NULL CHECK (TrainerEmail like '%_@_%._%'),
	TrainerExperience INT NOT NULL CHECK (TrainerExperience >= 0) DEFAULT 0,
	TrainerPhoto VARCHAR (250) NULL,
	TrainerStatusId INT NOT NULL FOREIGN KEY REFERENCES TrainerStatus(TrainerStatusId) DEFAULT 1,
	SpecializationId INT NOT NULL FOREIGN KEY REFERENCES Specialization(SpecializationId)
);

CREATE TABLE MemberStatus (
	MemberStatusId INT IDENTITY (1,1) PRIMARY KEY,
	MemberStatus VARCHAR(50) NOT NULL UNIQUE 
);

CREATE TABLE Membership (
	MembershipId INT IDENTITY (1,1) PRIMARY KEY,
	Membership VARCHAR(50) NOT NULL UNIQUE 
);

CREATE TABLE Customer (
	MemberId INT IDENTITY (1,1) PRIMARY KEY,
	MemberName VARCHAR(50) NOT NULL,
	MemberNationalId CHAR(11) NOT NULL UNIQUE CHECK (len(MemberNationalId) = 11),
	MemberBirthDate DATE NULL CHECK (MemberBirthDate <= '2008-01-01'),
	MemberPhone CHAR (10) NULL UNIQUE CHECK (len(MemberPhone) = 10),
	MemberEmail VARCHAR (100) NULL CHECK (MemberEmail like '%_@_%._%'),
	MemberPhoto VARCHAR (250) NULL,
	MemberStatusId INT NOT NULL FOREIGN KEY REFERENCES MemberStatus(MemberStatusId) DEFAULT 1,
	MembershipId INT NOT NULL FOREIGN KEY REFERENCES Membership(MembershipId) DEFAULT 1
);

CREATE TABLE Equipment (
	EquipmentId INT IDENTITY (1,1) PRIMARY KEY,
	EquipmentName VARCHAR(50) NULL, 
	WarehouseId INT NOT NULL FOREIGN KEY REFERENCES Warehouse(WarehouseId)
);

CREATE TABLE WorkoutLevel (
	WorkoutLevelId INT IDENTITY (1,1) PRIMARY KEY,
	WorkoutLevel VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Workout (
	WorkoutId INT IDENTITY (1,1) PRIMARY KEY,
	WorkoutName VARCHAR(50) NOT NULL UNIQUE,
	WorkoutDescription TEXT NULL,
	WorkoutPrice Decimal (10, 2) NOT NULL CHECK (WorkoutPrice > 0),
	WorkoutPhoto VARCHAR (250) NULL,
	WorkoutDurationMinute INT NOT NULL CHECK (WorkoutDurationMinute > 0), 
	SpecializationId INT NOT NULL FOREIGN KEY REFERENCES Specialization(SpecializationId),
	WorkoutLevelId INT NOT NULL FOREIGN KEY REFERENCES WorkoutLevel(WorkoutLevelId) DEFAULT 1
);

CREATE TABLE BranchWorkout (
	BranchWorkoutId INT IDENTITY (1,1) PRIMARY KEY,
	BranchId INT NOT NULL FOREIGN KEY REFERENCES Branch(BranchId),
	WorkoutId INT NOT NULL FOREIGN KEY REFERENCES Workout(WorkoutId),
	UNIQUE (BranchId, WorkoutId)
);

CREATE TABLE TrainerWorkout (
	TrainerWorkoutId INT IDENTITY (1,1) PRIMARY KEY,
	BranchWorkoutId INT NOT NULL FOREIGN KEY REFERENCES BranchWorkout(BranchWorkoutId),
	TrainerId INT NOT NULL FOREIGN KEY REFERENCES Trainer(TrainerId),
	UNIQUE (BranchWorkoutId, TrainerId)
);

CREATE TABLE Enrollment (
	EnrollmentId INT IDENTITY (1,1) PRIMARY KEY,
	MemberId INT NOT NULL FOREIGN KEY REFERENCES Customer(MemberId),
	TrainerWorkoutId INT NOT NULL FOREIGN KEY REFERENCES TrainerWorkout(TrainerWorkoutId),
	EnrollmentStartDate Date NOT NULL,
	UNIQUE (MemberId, TrainerWorkoutId)
);

CREATE TABLE WorkoutEquipment (
	WorkoutEquipmentId INT IDENTITY (1,1) PRIMARY KEY,
	EquipmentId INT NOT NULL FOREIGN KEY REFERENCES Equipment(EquipmentId),
	WorkoutId INT NOT NULL FOREIGN KEY REFERENCES Workout(WorkoutId),
	UNIQUE (EquipmentId, WorkoutId)
);

