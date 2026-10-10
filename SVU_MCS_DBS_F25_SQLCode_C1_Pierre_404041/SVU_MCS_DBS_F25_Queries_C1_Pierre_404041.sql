
/* SVU_MCS_DBS_F25_SQLCode_C1_Pierre_404041 */

--------------------------------------06--------------------------------------------
-- اضافة سطر جديد خاطئ

-- البحث عن السطر الجديد
SELECT * 
FROM Branch join Governorate 
ON Branch.GovernorateId = Governorate.GovernorateId
WHERE BranchName = 'Central Damascus';

-- تغيير قيمة المحافظة من حلب الى دمشق
UPDATE Branch
SET GovernorateId = (SELECT GovernorateId FROM Governorate WHERE Governorate='Damascus')
WHERE BranchName='Central Damascus';

------------------------------------------07----------------------------------------
-- عرض اسماء المدربين وعدد سنوات الخبرة للمدربين الذي لهم خبرة تتجاوز 10 سنوات
SELECT TrainerName, TrainerExperience
FROM Trainer 
WHERE TrainerExperience > 10
ORDER BY TrainerExperience DESC;

------------------------------------------08----------------------------------------
-- عرض اسم الفرع وعدد المسجلين في هذا الفرع خلال شهر آذار 2026 
SELECT B.BranchName, COUNT(E.EnrollmentId) AS EnrollmentCount
FROM Branch B
JOIN BranchWorkout BW ON B.BranchId = BW.BranchId
JOIN TrainerWorkout TW ON TW.BranchWorkoutId = BW.BranchWorkoutId
JOIN Enrollment E ON E.TrainerWorkoutId= TW.TrainerWorkoutId
WHERE E.EnrollmentStartDate BETWEEN '2026-03-01' AND '2026-03-31'
GROUP BY B.BranchName
ORDER BY EnrollmentCount Desc
;

----------------------------------------09------------------------------------------
-- عرض جدولين لمعرفة المدربين الذين ليس لهم حصص تدريبية
SELECT TrainerId, TrainerName, TrainerNationalId 
FROM Trainer;
SELECT TrainerName
FROM Trainer 
JOIN TrainerWorkout ON Trainer.TrainerId = TrainerWorkout.TrainerId;

-- يمكن حذف أحمد زين لأنه لا يملك أي حصة تدريبية ولحذفه نستخدم الكود المضمن في التعليق
/*
DELETE FROM Trainer
WHERE TrainerNationalId = '10100212344';
*/

-- لا يمكن حذف كلارك كينت لأن له حصة تدريبية ولحذفه نحتاج أولاً لحذف الحصة التدريبية المرتبطة به
-- عرض الحصة التدريبية التي يشرف عليها كلارك كينت
SELECT WorkoutName
FROM Workout W
JOIN BranchWorkout BW ON W.WorkoutId=BW.WorkoutId
JOIN TrainerWorkout TW ON TW.BranchWorkoutId= BW.BranchWorkoutId
WHERE TrainerId = 1;
/*
DELETE FROM Trainer
WHERE TrainerId = 1;
*/

---------------------------------------10------------------------------------------- 

-- عرض جدول المدربين القديم لرؤية التغييرات
SELECT * FROM Trainer;
-- اضافة عمود جديد الى جدول المدربين
ALTER TABLE Trainer 
ADD	Rating VARCHAR (20);

-----------------------------------------11-----------------------------------------
-- تعديل نوع بيانات العمود الجديد الذي تمت اضافته الى جدول المدربين
ALTER TABLE Trainer 
ALTER COLUMN RATING INT;

-- تعديل قيد العمود الجديد ليقبل القيم بين 1 و 5 فقط
ALTER TABLE Trainer
ADD CONSTRAINT ChkTrainerRating
CHECK (Rating BETWEEN 1 AND 5);

-- اضافة قيمة لا تخالف القيد الذي تم انشاءه على العمود الجديد
UPDATE Trainer
SET Rating = 5 
WHERE TrainerId = 1;

-- رؤية التغييرات على عمود المدربين
SELECT * FROM Trainer;

-- اضافة قيمة تخالف القيد الذي تم انشاءه 

UPDATE Trainer
SET Rating = 6
WHERE TrainerId = 2;


------------------------------------12----------------------------------------------
-- حذف العمود الجديد ولكن في البداية يجب حذف القيد المرتبط بالعمود
ALTER TABLE Trainer
DROP CONSTRAINT ChkTrainerRating;
ALTER TABLE Trainer
DROP COLUMN Rating;

------------------------------------13----------------------------------------------

CREATE NONCLUSTERED INDEX CIX_MEMBER_NATIONALIO
ON Customer(MemberNationalId);

CREATE NONCLUSTERED INDEX CIX_WORKOUT_WORKOUTNAME
ON Workout(WorkoutName);
------------------------------------14----------------------------------------------
-- اضافة قيد على عمود سعر الحصة التدريبية لتكون بين 0 و 500 الف
ALTER TABLE Workout
ADD CONSTRAINT ChkWorkoutPrice
CHECK (WorkoutPrice > 0 AND WorkoutPrice < 500000);

------------------------------------15----------------------------------------------
-- تعطيل قيد سعر الحصة
ALTER TABLE Workout
NOCHECK CONSTRAINT ChkWorkoutPrice;

-- اعادة تفعيل قيد سعر الحصة
ALTER TABLE Workout
CHECK CONSTRAINT ChkWorkoutPrice;

------------------------------------16---------------------------------------------- 
-- انشاء جدول افتراضي يعرض اسم الفرع، عدد اعضاءه، عدد مدربيه، عدد الحصص التدريبية التي يقدمها
Go
CREATE VIEW Branch_Member_Summary As
SELECT	B.BranchName,
		COUNT(DISTINCT BW.WorkoutId) AS WorkoutCount,
		COUNT(DISTINCT TW.TrainerId) As TrainerCount,
		COUNT(DISTINCT E.MemberId) AS MemberCount
FROM Branch B
left JOIN BranchWorkout BW ON B.BranchId = BW.BranchId
left JOIN TrainerWorkout TW ON TW.BranchWorkoutId = BW.BranchWorkoutId
left JOIN Enrollment E ON E.TrainerWorkoutId = TW.BranchWorkoutId
GROUP BY B.BranchName;
Go

-- عرض الجدول الافتراضي الذي تم انشاءه
SELECT * FROM Branch_Member_Summary;

------------------------------------17----------------------------------------------

CREATE VIEW VIP_Members AS
SELECT * 
FROM Customer 
WHERE MembershipId = (SELECT MembershipId FROM Membership WHERE Membership='VIP');

------------------------------------18----------------------------------------------
-- البحث عن المدرب الذي يحتوي اسمه على محمد وينتهي رقم هاتفه ب 123
SELECT * 
FROM Trainer 
WHERE TrainerName LIKE('%Mohammad%') AND TrainerPhone LIKE('%123'); 

------------------------------------19---------------------------------------------- 
-- عرض اسم الحصة، اسم الفرع، المحافظة وتواريخ التسجيل للحصص الموجود في أفرع دمشق خلال شهر آذار 2026
SELECT 
	W.WorkoutName, B.BranchName, G.Governorate, E.EnrollmentStartDate  
FROM Workout W 
JOIN BranchWorkout BW ON BW.WorkoutId = W.WorkoutId 
JOIN Branch B ON B.BranchId = BW.BranchId
JOIN Governorate G ON B.GovernorateId = G.GovernorateId
JOIN TrainerWorkout TW ON TW.BranchWorkoutId = BW.BranchWorkoutId
JOIN Enrollment E on E.TrainerWorkoutId = TW.TrainerWorkoutId
WHERE 
	G.Governorate like 'Damascus' 
	and E.EnrollmentStartDate between '2026-03-01' And '2026-03-30';

------------------------------------20----------------------------------------------

/*
 لإعطاء صحلاحيات لموظف في فرعه فقط ولحماية البيانات الأصلية
أفضل حل وجدته ضمن ما أعرفه من معلومات هو أن أقوم بإنشاء جدول افتراضي للموظف 
 ولكن بحال كانت تحتوي تعليمة انشاء الجدول الافتراضي على تعليمات الدمج 
لن يتمكن الموظف من التعديل على البيانات باستخدام الجداول الافتراضية
 ولتحقيق هذا سأقوم أولا بتحديث الجداول وربط الفرع مباشرة بجداول المدربين والأعضاء
*/

