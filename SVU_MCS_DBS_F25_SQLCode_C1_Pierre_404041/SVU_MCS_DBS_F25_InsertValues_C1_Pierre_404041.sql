
/* SVU_MCS_DBS_F25_SQLCode_C1_Pierre_404041 */

/* --------------------------------------05-------------------------------------------- */

INSERT INTO Governorate 
VALUES	('Damascus'), ('Aleppo'), ('Homs'), ('Daraa');

INSERT INTO Branch (BranchName, BranchLocation, BranchPhone, BranchCapacity, GovernorateId)  
VALUES	
('Gold Gym Downtown', 'Al-Mazzeh', '0955213451', 30, 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Damascus')), 

('Anytime Fitness', 'Barada Sport Club', '0934612187', 40, 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Aleppo')), 

('Planet Fitness', 'Al-Mazraa', '0935461871', 50, 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Homs')), 

('OrangeTheory Fitness', 'Al Walid Ibn Abd El Malek', '0934678594', 60, 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Damascus')),

('Life Time Fitness', 'near the Central Pharmacy', '0936874584', 50, 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Homs')),

('CrossFit', '1200 Market Street', '0956554215', 33, 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Aleppo')),

('The Forge', '4550 Rosewood Drive', '0964545545', 54, 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Daraa')),

('City Center', '1632 14th Street NW', '0954455664', 90, 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Damascus')),

('Powerhouse Gym', '25 Broad Street, 10th Floor', '0933546166', 40, 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Aleppo'))
;

INSERT INTO Warehouse (WarehouseName, WarehouseLocation, WarehousePhone, GovernorateId, BranchId)
VALUES	
('Gold Gym Downtown Warehouse', 'Al-Mazzeh 1564', '0955214555',
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Damascus'),
	(SELECT Branch.BranchId FROM Branch WHERE BranchName='Gold Gym Downtown')), 

('Anytime Fitness Warehouse', 'Barada', '0934611555', 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Damascus'),
	(SELECT Branch.BranchId FROM Branch WHERE BranchName='Anytime Fitness')), 

('Planet Fitness Warehouse', 'Al-Mazraa', '0935461555', 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Damascus'),
	(SELECT Branch.BranchId FROM Branch WHERE BranchName='Planet Fitness')), 

('OrangeTheory Fitness Warehouse', 'Al Walid Ibn Abd El Malek', '0934678555', 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Damascus'),
	(SELECT Branch.BranchId FROM Branch WHERE BranchName='OrangeTheory Fitness')), 

('Life Time Fitness Warehouse', 'near the Central Pharmacy', '0936874555', 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Aleppo'),
	(SELECT Branch.BranchId FROM Branch WHERE BranchName='Life Time Fitness')), 

('CrossFit Warehouse', '1200 Market Street', '0956554555', 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Aleppo'),
	(SELECT Branch.BranchId FROM Branch WHERE BranchName='CrossFit')), 

('The Forge Warehouse', '4550 Rosewood Drive', '0964545555', 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Aleppo'),
	(SELECT Branch.BranchId FROM Branch WHERE BranchName='The Forge')), 

('City Center 101', '1632 14th Street NW', '0954455555', 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Damascus'),
	(SELECT Branch.BranchId FROM Branch WHERE BranchName='City Center')), 

('Powerhouse Gym 101', '25 Broad Street, 10th Floor', '0933546555', 
	(SELECT Governorate.GovernorateId FROM Governorate WHERE Governorate='Damascus'),
	(SELECT Branch.BranchId FROM Branch WHERE BranchName='Powerhouse Gym'))
;

INSERT INTO Specialization (Specialization)
VALUES ('Yoga'), ('Barre'), ('Spin'), ('Bodybuilding'), ('CrossFit');

INSERT INTO TrainerStatus (TrainerStatus)
VALUES ('Active'), ('On Leave'), ('Contract Expired'), ('On Loan');

INSERT INTO Trainer	(TrainerName, TrainerNationalId, TrainerBirthDate, TrainerPhone, TrainerEmail, TrainerExperience, 
					TrainerStatusId, SpecializationId)
VALUES 
('Clark Kent', '12140025154', '1997-10-02', '0955646415', 'ClarkKent@gamil.com',2, DEFAULT,
	(SELECT SpecializationId from Specialization WHERE Specialization='Bodybuilding')),
		
('Bruce Wayne', '12140020000', '1992-08-15', '0955646444', 'BW@gamil.com', 12, DEFAULT,
	(SELECT SpecializationId from Specialization WHERE Specialization='Barre')),
		
('Diana Prince', '10102525621', '1985-10-13', '0955646333', 'DP@gamil.com',15, DEFAULT,
	(SELECT SpecializationId from Specialization WHERE Specialization='Yoga')),
		
('Mohammad Ali', '10100642155', '1990-01-28', '0955646123', 'MoAli@gamil.com', 13, 
	(SELECT TrainerStatusId from TrainerStatus WHERE TrainerStatus='On Leave'),
	(SELECT SpecializationId from Specialization WHERE Specialization='Yoga')),
		
('Ahmad Zein', '10100212344', '1975-01-18', '0955646111', 'AZ@gamil.com',12, 
	(SELECT TrainerStatusId from TrainerStatus WHERE TrainerStatus='On Leave'),
	(SELECT SpecializationId from Specialization WHERE Specialization='CrossFit'))
;

INSERT INTO MemberStatus (MemberStatus)
VALUES ('Active'), ('Expired'), ('Frozen');

INSERT INTO Membership (Membership)
VALUES ('Regular'), ('VIP'), ('Annual');

INSERT INTO Customer (MemberName, MemberNationalId, MemberBirthDate, MemberPhone, MemberEmail,
					MemberStatusId, MembershipId)
VALUES 
('Zaid', '12140025555', '2005-10-02', '0955757415', 'Zaid@svuonline.sy', DEFAULT,
	(SELECT MembershipId from Membership WHERE Membership='VIP')),
		
('Omar', '12140020111', '2002-08-15', '0933646444', 'Omar@gmail.com',DEFAULT,
	(SELECT MembershipId from Membership WHERE Membership='VIP')),
		
('Bassam', '10102522221', '2006-10-13', '0956547333', 'Bassam@gmail.com',DEFAULT,
	(SELECT MembershipId from Membership WHERE Membership='VIP')),
		
('Carlos', '10100642225', '1990-01-28', '0955154222', 'Carlos@gmail.com',
	(SELECT MemberStatusId from MemberStatus WHERE MemberStatus='Expired'),
	(SELECT MembershipId from Membership WHERE Membership='Annual')),
		
('Lina', '10100213222', '1975-01-18', '0955456111', 'Lina@gmail.com',
	(SELECT MemberStatusId from MemberStatus WHERE MemberStatus='Frozen'),DEFAULT)
;

INSERT INTO Equipment (EquipmentName, WarehouseId)
VALUES 
('Commercial Treadmill 201', 
	(SELECT WarehouseId FROM Warehouse WHERE WarehouseName='Gold Gym Downtown Warehouse')),

('Indoor Studio Cycle 500', 
	(SELECT WarehouseId FROM Warehouse WHERE WarehouseName='Gold Gym Downtown Warehouse')),

('Leg Press Machine 100', 
	(SELECT WarehouseId FROM Warehouse WHERE WarehouseName='Gold Gym Downtown Warehouse')),

('Hex Dumbbell Set 00', 
	(SELECT WarehouseId FROM Warehouse WHERE WarehouseName='Anytime Fitness Warehouse')),

('Flat Bench 00', 
	(SELECT WarehouseId FROM Warehouse WHERE WarehouseName='Planet Fitness Warehouse'))
;

INSERT INTO WorkoutLevel(WorkoutLevel)
VALUES ('Beginner'), ('Intermediate'), ('Advanced');

INSERT INTO Workout(WorkoutName, WorkoutPrice, WorkoutDurationMinute, SpecializationId, WorkoutLevelId)
Values
('Barbell Bench Press', 199.99, 60, 
	(SELECT SpecializationId from Trainer where TrainerNationalId='12140025154'),
	3),
('Dumbbell Incline Press', 250, 45,
	(SELECT SpecializationId from Trainer where TrainerNationalId='12140020000'),
	DEFAULT),
('Pec Deck Fly', 20.4, 30,
	(SELECT SpecializationId from Trainer where TrainerNationalId='10102525621'),
	DEFAULT),
('Lat Pulldown', 25, 100,
	(SELECT SpecializationId from Trainer where TrainerNationalId='10102525621'),
	2)
;

INSERT INTO BranchWorkout (BranchId, WorkoutId) 
VALUES	
((SELECT BranchId FROM Branch WHERE BranchName='Gold Gym Downtown'),
(SELECT WorkoutId FROM Workout WHERE WorkoutName='Barbell Bench Press')),
		
((SELECT BranchId FROM Branch WHERE BranchName='Gold Gym Downtown'),
(SELECT WorkoutId FROM Workout WHERE WorkoutName='Dumbbell Incline Press')),

((SELECT BranchId FROM Branch WHERE BranchName='Gold Gym Downtown'),
(SELECT WorkoutId FROM Workout WHERE WorkoutName='Pec Deck Fly')),

((SELECT BranchId FROM Branch WHERE BranchName='Anytime Fitness'),
(SELECT WorkoutId FROM Workout WHERE WorkoutName='Barbell Bench Press')),

((SELECT BranchId FROM Branch WHERE BranchName='Anytime Fitness'),
(SELECT WorkoutId FROM Workout WHERE WorkoutName='Dumbbell Incline Press'))
;

INSERT INTO TrainerWorkout (BranchWorkoutId, TrainerId)
VALUES
((SELECT BranchWorkoutId FROM BranchWorkout WHERE BranchId = 
(SELECT BranchId FROM Branch WHERE BranchName='Gold Gym Downtown') 
	AND WorkoutId = (SELECT WorkoutId FROM Workout WHERE WorkoutName='Barbell Bench Press')), 
(SELECT TrainerId FROM Trainer WHERE TrainerNationalId='12140025154')), --CLARK KENT

((SELECT BranchWorkoutId FROM BranchWorkout WHERE BranchId = 
(SELECT BranchId FROM Branch WHERE BranchName='Anytime Fitness') 
	AND WorkoutId = (SELECT WorkoutId FROM Workout WHERE WorkoutName='Barbell Bench Press')), 
(SELECT TrainerId FROM Trainer WHERE TrainerNationalId='12140020000')), --BRUCE WAYNE

((SELECT BranchWorkoutId FROM BranchWorkout WHERE BranchId = 
(SELECT BranchId FROM Branch WHERE BranchName='Gold Gym Downtown') 
	AND WorkoutId = (SELECT WorkoutId FROM Workout WHERE WorkoutName='Dumbbell Incline Press')), 
(SELECT TrainerId FROM Trainer WHERE TrainerNationalId='10102525621')), --Diana Prince

((SELECT BranchWorkoutId FROM BranchWorkout WHERE BranchId = 
(SELECT BranchId FROM Branch WHERE BranchName='Anytime Fitness') 
	AND WorkoutId = (SELECT WorkoutId FROM Workout WHERE WorkoutName='Dumbbell Incline Press')), 
(SELECT TrainerId FROM Trainer WHERE TrainerNationalId='12140020000')), --BRUCE WAYNE

((SELECT BranchWorkoutId FROM BranchWorkout WHERE BranchId = 
(SELECT BranchId FROM Branch WHERE BranchName='Gold Gym Downtown') 
	AND WorkoutId = (SELECT WorkoutId FROM Workout WHERE WorkoutName='Pec Deck Fly')), 
(SELECT TrainerId FROM Trainer WHERE TrainerNationalId='10100642155')) --MOHAMMAD ALI
;

