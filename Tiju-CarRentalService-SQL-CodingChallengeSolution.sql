/* Coding Challenge - Car Rental System */

IF EXISTS (SELECT * FROM sys.databases WHERE NAME = 'CarRentalSystem')
BEGIN
	DROP DATABASE CarRentalSystem;
END
GO

CREATE DATABASE CarRentalSystem

USE CarRentalSystem

DROP TABLE IF EXISTS Payment, Lease, Customer, Vehicle

CREATE TABLE Vehicle (
    vehicleID INT PRIMARY KEY IDENTITY(1,1),
    make VARCHAR(255),
    model VARCHAR(255),
    year INT,
    dailyRate DECIMAL(10, 2),
    status INT CHECK (status IN (1, 0)),
    passengerCapacity INT,
    engineCapacity INT
)

CREATE TABLE Customer (
    customerID INT PRIMARY KEY IDENTITY(1,1),
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    phoneNumber VARCHAR(20) UNIQUE
)

CREATE TABLE Lease (
    leaseID INT PRIMARY KEY IDENTITY(1,1),
    vehicleID INT FOREIGN KEY REFERENCES Vehicle(vehicleID) ON DELETE CASCADE,
    customerID INT FOREIGN KEY REFERENCES Customer(customerID) ON DELETE CASCADE,
    startDate DATE,
    endDate DATE,
    type VARCHAR(20)
)

CREATE TABLE Payment (
    paymentID INT PRIMARY KEY IDENTITY(1,1),
    leaseID INT,
    paymentDate DATE,
    amount DECIMAL(10, 2)
)

ALTER TABLE Customer ADD CONSTRAINT CHK_Email CHECK(email LIKE '%_@_%._%')
ALTER TABLE Lease ADD CONSTRAINT CHK_Type CHECK(type = 'Daily' or type = 'Monthly')
ALTER TABLE Payment ADD CONSTRAINT FK_LeaseID FOREIGN KEY (leaseID) REFERENCES Lease(leaseID) ON DELETE CASCADE

INSERT INTO Vehicle(make, model, year, dailyRate, status, passengerCapacity, engineCapacity) 
OUTPUT inserted.*
VALUES
	('Toyota','Camry',2022,50.00,'1',4,1450),
    ('Honda','Civic',2023,45.00,'1',7,1500),
    ('Ford','Focus',2022,48.00,'0',4,1400),
    ('Nissan','Altima',2023,52.00,'1',7,1200),
    ('Cheverlet','Malibu',2022,47.00,'1',4,1800),
    ('Hyundai','Sonata',2023,49.00,'0',7,1400),
    ('BMW','3 Series',2023,60.00,'1',7,2499),
    ('Mercedes','C-Class',2022,58.00,'1',8,2599),
    ('Audi','A4',2022,55.00,'0',4,2500),
    ('Lexus','ES',2023,54.00,'1',4,2500)
    
INSERT INTO Customer(firstname,lastname,email,phonenumber) 
OUTPUT inserted.*
VALUES
	('John','Doe','johndoe@example.com','555-555-5555'),
	('Jane','Smith','janesmith@example.com','555-123-4567'),
    ('Robert','Johnson','robert@example.com','555-789-1234'),
    ('Sarah','Brown','sarah@example.com','555-456-7890'),
    ('David','Lee','david@example.com','555-787-6543'),
    ('Laura','Hall','laura@example.com','555-234-5678'),
    ('Micheal','Davis','michael@example.com','555-876-5432'),
    ('Emma','Wilson','emma@example.com','555-423-1098'),
    ('William','Taylor','william@example.com','555-321-6547'),
    ('Olivia','Adams','olivia@example.com','555-765-4321')

INSERT INTO Lease(vehicleID, customerID, startDate, endDate, type) 
OUTPUT inserted.*
VALUES
	(1,1,'2023-01-01','2023-01-05','Daily'),
	(2,2,'2023-02-15','2023-02-28','Monthly'),
	(3,3,'2023-03-10','2023-03-15','Daily'),
	(4,4,'2023-04-20','2023-04-30','Monthly'),
	(5,5,'2023-05-05','2023-05-10','Daily'),
	(4,3,'2023-06-15','2023-06-30','Monthly'),
	(7,7,'2023-07-01','2023-07-10','Daily'),
	(8,8,'2023-08-12','2023-08-15','Monthly'),
	(3,3,'2023-09-07','2024-01-05','Daily'),
	(10,10,'2023-10-10','2024-01-26','Monthly')

INSERT INTO Payment(leaseID, paymentDate, amount) 
OUTPUT inserted.*
VALUES
	(1,'2023-01-03',200),
    (2,'2023-02-03',1000),
    (3,'2023-03-03',75),
    (4,'2023-04-03',900),
    (5,'2023-05-03',60),
    (6,'2023-06-03',1200),
    (7,'2023-07-03',40),
    (8,'2023-08-03',1100),
    (9,'2023-09-03',80),
    (10,'2023-10-03',1500)

/*1. Update the daily rate for a Mercedes car to 68.*/
select * from Vehicle where make = 'Mercedes'
UPDATE Vehicle SET dailyRate = 68 WHERE make = 'Mercedes'
select * from Vehicle where make = 'Mercedes'

/*2. Delete a specific customer and all associated leases and payments.*/
DECLARE @customerID INT
SET @customerID = 4
DELETE FROM Customer WHERE customerID = @customerID
--As we've used 'ON DELETE CASCADE', data from other tables referencing to this table have been removed

/*3. Rename the "paymentDate" column in the Payment table to "transactionDate".*/
EXEC sp_rename 'Payment.paymentDate', 'transactionDate', 'COLUMN'

/*4. Find a specific customer by email.*/
DECLARE @email VARCHAR(255)
SET @email = 'robert@example.com'
SELECT * FROM Customer WHERE email = @email

/*5. Get active leases for a specific customer.*/
DECLARE @customerID INT
SET @customerID = 3
SELECT * FROM Lease WHERE customerID = @customerID and endDate > GETDATE()

/*6. Find all payments made by a customer with a specific phone number.*/
DECLARE @phoneNo VARCHAR(255)
SET @phoneNo = '555-789-1234'
SELECT C.*, P.* FROM Customer C
LEFT JOIN Lease L ON C.customerID = L.customerID
LEFT JOIN Payment P ON L.leaseID = P.leaseID
WHERE C.phoneNumber = @phoneNo

/*7. Calculate the average daily rate of all available cars.*/
SELECT AVG(dailyRate) AS [Average Daily Rate] FROM Vehicle WHERE status = 1

/*8. Find the car with the highest daily rate.*/
SELECT (select Vehicle.vehicleID from Vehicle where vehicleID=V.vehicleID) vehicleID,
	   (select CONCAT(make, ' ', model) Vehicle where vehicleID=V.vehicleID) [Vehicle Make & Model],
	   dailyRate
FROM Vehicle V
WHERE dailyRate = 
	(SELECT MAX(dailyRate) FROM Vehicle)

/*9. Retrieve all cars leased by a specific customer.*/
DECLARE @customerID INT
SET @customerID = 5
SELECT V.* FROM Vehicle V
RIGHT JOIN Lease L ON V.vehicleID = L.vehicleID
WHERE L.customerID = @customerID

/*10. Find the details of the most recent lease.*/
SELECT TOP 1 * FROM Lease ORDER BY startDate DESC

/*11. List all payments made in the year 2023.*/
SELECT * FROM Payment WHERE YEAR(transactionDate) = 2023

/*12. Retrieve customers who have not made any payments.*/
SELECT C.*, ISNULL(sum(P.amount), 0) FROM Customer C
LEFT JOIN Lease L ON C.customerID = L.customerID
LEFT JOIN Payment P ON L.leaseID = P.leaseID
GROUP BY C.customerID, C.firstName, C.lastName, C.email, C.phoneNumber
HAVING C.customerID NOT IN
	(SELECT C.customerID FROM Customer C
	LEFT JOIN Lease L ON C.customerID = L.customerID
	LEFT JOIN Payment P ON L.leaseID = P.leaseID
	GROUP BY C.customerID
	having COALESCE(sum(P.amount),0) > 0)

/*13. Retrieve Car Details and Their Total Payments.*/
SELECT V.*,  COUNT(P.amount) [Number of Payments], SUM(P.amount) [Total Payments] FROM Vehicle V
LEFT JOIN Lease L ON V.vehicleID = L.vehicleID
LEFT JOIN Payment P ON L.leaseID = P.leaseID
GROUP BY V.vehicleID, V.make, V.model, V.year, V.dailyRate, V.status, V.passengerCapacity, V.engineCapacity

/*14. Calculate Total Payments for Each Customer.*/
SELECT C.customerID, COALESCE(SUM(P.amount), 0) [Total Payments]
FROM Customer C
LEFT JOIN Lease L ON C.customerID = L.customerID
LEFT JOIN Payment P ON L.leaseID = P.leaseID
GROUP BY C.customerID

/*15. List Car Details for Each Lease.*/
SELECT L.*, V.* FROM Vehicle V
RIGHT JOIN Lease L ON V.vehicleID = L.vehicleID

/*16. Retrieve Details of Active Leases with Customer and Car Information.*/
SELECT L.*, C.*, V.*
FROM Lease L
JOIN Customer C ON L.customerID = C.customerID
JOIN Vehicle V ON L.vehicleID = V.vehicleID
WHERE GETDATE() between L.startDate and L.endDate

/*17. Find the Customer Who Has Spent the Most on Leases.*/
SELECT C.customerID, SUM(P.amount) [Total Payments] FROM Customer C
join Lease L on C.customerID = L.customerID
join Payment P on L.leaseID = P.leaseID
GROUP BY C.customerID
HAVING SUM(P.amount) = (
	SELECT TOP 1 SUM(P.amount) FROM Customer C
	JOIN Lease L ON C.customerID = L.customerID
	JOIN Payment P ON L.leaseID = P.leaseID
	GROUP BY C.customerID
	ORDER BY SUM(P.amount) DESC)

/*18. List All Cars with Their Current Lease Information.*/
SELECT V.*, L.* FROM Lease L
FULL OUTER JOIN Vehicle V ON L.vehicleID = V.vehicleID