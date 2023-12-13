-- Coding Challenge - PetPals, The Pet Adoption Platform

-- 1. Provide a SQL script that initializes the database for the Pet Adoption Platform ”PetPals”.
if exists (select * from sys.databases where name = 'PetPals')
begin
	drop database PetPals;
end;
go

create database PetPals;

use PetPals;

-- 2. Create tables for pets, shelters, donations, adoption events, and participants.
-- 3. Define appropriate primary keys, foreign keys, and constraints.
-- 4. Ensure the script handles potential errors, such as if the database or tables already exist.
IF OBJECT_ID(N'dbo.Pets', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Pets];  
GO
IF OBJECT_ID(N'dbo.Shelters', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Shelters];  
GO
IF OBJECT_ID(N'dbo.Donations', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Donations];  
GO
IF OBJECT_ID(N'dbo.AdoptionEvents', N'U') IS NOT NULL  
   DROP TABLE [dbo].[AdoptionEvents];  
GO
IF OBJECT_ID(N'dbo.Donations', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Donations];  
GO
IF OBJECT_ID(N'dbo.Users', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Users];  
GO
IF OBJECT_ID(N'dbo.Adoption', N'U') IS NOT NULL  
   DROP TABLE [dbo].[MyTable0];  
GO

create table Pets (
    PetID int primary key,
    Name varchar(255),
    Age int,
    Breed varchar(255),
    Type varchar(255),
    AvailableForAdoption int
);

create table Shelters (
    ShelterID int primary key,
    Name varchar(255),
    Location varchar(255)
);

create table Donations (
    DonationID int primary key,
    DonorName varchar(255),
    DonationType varchar(255),
    DonationAmount DECIMAL,
    DonationItem varchar(255),
    DonationDate datetime
);

create table AdoptionEvents (
    EventID int primary key,
    EventName varchar(255),
    EventDate datetime,
    Location varchar(255)
);

create table Participants (
    ParticipantID int primary key,
    ParticipantName varchar(255),
    ParticipantType varchar(255),
    EventID int,
    foreign key (EventID) references AdoptionEvents(EventID)
);

-- Insert 10 entries into Pets table
insert into Pets (PetID, Name, Age, Breed, Type, AvailableForAdoption)
values
    (1, 'Argus', 2, 'German Shepherd', 'Dog', 1),
    (2, 'Alf', 1, 'Persian', 'Cat', 1),
    (3, 'Basil', 3, 'German Shepherd', 'Dog', 0),
    (4, 'Ivory', 1, 'Pomeranian', 'Dog', 1),
    (5, 'Houdini', 2, 'Ragdoll', 'Cat', 1),
    (6, 'Jake', 4, 'Beagle', 'Dog', 1),
    (7, 'Nellie', 1, 'Maine Coon', 'Dog', 0),
    (8, 'Mitch', 2, 'Siamese', 'Cat', 1),
    (9, 'Wayne', 1, 'Golden Retriever', 'Dog', 1),
    (10, 'Scarlett', 3, 'Golden Retriever', 'Dog', 1);

-- Insert 10 entries into Shelters table
insert into Shelters (ShelterID, Name, Location)
values
    (1, 'Loving Paws Sanctuary', 'Mumbai, Maharashtra'),
    (2, 'Harmony Haven for Pets', 'Delhi, Delhi'),
    (3, 'Whisker Haven', 'Bangalore, Karnataka'),
    (4, 'Rainbow Shelter', 'Chennai, Tamil Nadu'),
    (5, 'Fur-ever Home Shelter', 'Kolkata, West Bengal'),
    (6, 'Furry Friends Shelter', 'Hyderabad, Telangana'),
    (7, 'Tail Wagging Retreat', 'Pune, Maharashtra'),
    (8, 'Joyful Tails', 'Ahmedabad, Gujarat'),
    (9, 'Rescue Me Pet Sanctuary', 'Jaipur, Rajasthan'),
    (10, 'Second Chance Critter Rescue', 'Lucknow, Uttar Pradesh');

-- Insert 10 entries into Donations table
insert into Donations (DonationID, DonorName, DonationType, DonationAmount, DonationItem, DonationDate)
values
    (1, 'Alexander Mitchell Reynolds', 'Cash', 100.00, NULL, '2023-01-15 10:30:00'),
    (2, 'Sophia Grace Anderson', 'Item', NULL, 'Pet Food', '2023-02-02 15:45:00'),
    (3, 'Emma Rose Bennett', 'Cash', 50.00, NULL, '2023-03-10 08:20:00'),
    (4, 'Ananya Sharma', 'Item', NULL, 'Pet Toys', '2023-04-05 12:10:00'),
    (5, 'Vikram Jain', 'Cash', 75.00, NULL, '2023-05-20 14:55:00'),
    (6, 'Ava Katherine Foster', 'Item', NULL, 'Pet Bed', '2023-06-18 09:30:00'),
    (7, 'Isabella Claire Jenkins', 'Cash', 120.00, NULL, '2023-07-03 11:40:00'),
    (8, 'Priya Sharma', 'Item', NULL, 'Cat Litter', '2023-08-22 16:15:00'),
    (9, 'Grace Elizabeth Roberts', 'Cash', 90.00, NULL, '2023-09-14 13:25:00'),
    (10, 'Oliver James Parker', 'Item', NULL, 'Dog Leash', '2023-10-30 07:50:00');

-- Insert 10 entries into AdoptionEvents table
insert into AdoptionEvents (EventID, EventName, EventDate, Location)
values
    (1, 'Paws and Adoptions Festival', '2023-01-25 11:00:00', 'Mumbai, Maharashtra'),
    (2, 'Furry Friends Find Homes Expo', '2023-03-15 14:30:00', 'Lucknow, Uttar Pradesh'),
    (3, 'Adopt-a-Palooza', '2023-05-05 12:00:00', 'Bangalore, Karnataka'),
    (4, 'Whiskers and Wags Adoption Extravaganza', '2023-07-10 10:00:00', 'Bangalore, Karnataka'),
    (5, 'Tail-Endearing Adoption Carnival', '2023-09-02 15:00:00', 'Ahmedabad, Gujarat'),
    (6, 'Paws for Love', '2023-10-18 13:45:00', 'Mumbai, Maharashtra'),
    (7, 'Homes for Hounds & Meows Fair', '2023-12-01 09:30:00', 'Lucknow, Uttar Pradesh'),
    (8, 'Hearts Shelter Adoption Drive', '2024-02-08 11:20:00', 'Kolkata, West Bengal'),
    (9, 'Heartstrings Adoption Showcase', '2024-04-03 16:00:00', 'Jaipur, Rajasthan'),
    (10, 'Wagging Tails Adoption Affair', '2024-06-22 10:45:00', 'Chennai, Tamil Nadu');

-- Insert 10 entries into Participants table
insert into Participants (ParticipantID, ParticipantName, ParticipantType, EventID)
values
    (1, 'Loving Paws Sanctuary', 'Shelter', 1),
    (2, 'Alexander Mitchell Reynolds', 'Adopter', 1),
    (3, 'Second Chance Critter Rescue', 'Shelter', 2),
    (4, 'Oliver James Parker', 'Adopter', 2),
    (5, 'Harmony Haven for Pets', 'Shelter', 3),
    (6, 'Grace Elizabeth Roberts', 'Adopter', 3),
    (7, 'Joyful Tails', 'Shelter', 4),
    (8, 'Isabella Claire Jenkins', 'Adopter', 4),
    (9, 'Rainbow Shelter', 'Shelter', 5),
    (10, 'Ananya Sharma', 'Adopter', 5);

--5. Write an SQL query that retrieves a list of available pets (those marked as available for adoption)
--   from the "Pets" table. Include the pet's name, age, breed, and type in the result set. Ensure that
--   the query filters out pets that are not available for adoption.
select Name, Age, Breed, Type from Pets 
where AvailableForAdoption = 1;

--6. Write an SQL query that retrieves the names of participants (shelters and adopters) registered 
--   for a specific adoption event. Use a parameter to specify the event ID. Ensure that the query 
--   joins the necessary tables to retrieve the participant names and types
declare @EventID int;
set @EventID = 1;
select P.* from AdoptionEvents as A 
join Participants P on A.EventID=P.EventID 
where A.EventID = @EventID;

--7. Create a stored procedure in SQL that allows a shelter to update its information (name and 
--   location) in the "Shelters" table. Use parameters to pass the shelter ID and the new information. 
--   Ensure that the procedure performs the update and handles potential errors, such as an invalid shelter ID
declare @ShelterID int
declare @ShelterName varchar(255)
declare @ShelterLocation varchar(255)
set @ShelterID = 2
set @ShelterName = 'Pets Haven'
set @ShelterLocation = 'Hyderabad, Telengana'
update Shelters set Name = @ShelterName, Location = @ShelterLocation where ShelterID = @ShelterID
select * from Shelters where ShelterID=@ShelterID;

--8. Write an SQL query that calculates and retrieves the total donation amount for each shelter (by 
--   shelter name) from the "Donations" table. The result should include the shelter name and the 
--   total donation amount. Ensure that the query handles cases where a shelter has received no donations
alter table Donations add ShelterID int foreign key references Shelters(ShelterID);

update Donations set ShelterID = 1 where DonationID = 1;
update Donations set ShelterID = 2 where DonationID = 2;
update Donations set ShelterID = 3 where DonationID = 3;
update Donations set ShelterID = 4 where DonationID = 4;
update Donations set ShelterID = 5 where DonationID = 5;
update Donations set ShelterID = 5 where DonationID = 6;
update Donations set ShelterID = 7 where DonationID = 7;
update Donations set ShelterID = 8 where DonationID = 8;
update Donations set ShelterID = 10 where DonationID = 9;
update Donations set ShelterID = 10 where DonationID = 10;

select S.Name as [Shelter Name], coalesce(sum(D.DonationAmount), 0) as [Total Donation Amount]
from Shelters S 
left join Donations D on S.ShelterID=D.ShelterID 
group by S.ShelterID, S.Name;

--9. Write an SQL query that retrieves the names of pets from the "Pets" table that do not have an 
--   owner (i.e., where "OwnerID" is null). Include the pet's name, age, breed, and type in the result set
-- Creating a table 'Users' with columns 'UserID' and 'UserName', and 'UserID' will be referenced by the 'OwnerID' column in the Pets table.
create table Users(
	UserID int primary key,
	UserName varchar(255)
);

insert into Users values	
	(1, 'Colt Y. Petty'),
	(2, 'Kasper G. Buckley'),
	(3, 'Fritz M. Compton');

-- Creating new column 'OwnerID' in Pets table which references 'UserID' column in the 'Users' table
alter table Pets add OwnerID int foreign key references Users(UserID);

update Pets set OwnerID = 2 where PetID = 2;
update Pets set OwnerID = 3 where PetID = 7;

-- Ans of Query 9
select Name, Age, Breed, Type from Pets 
where OwnerID is null;

--10. Write an SQL query that retrieves the total donation amount for each month and year
select format(DonationDate, 'MMMM yyyy') as Month_Year, coalesce(sum(DonationAmount), 0) as TotalDonationAmount
from Donations
group by format(DonationDate, 'MMMM yyyy');

--11. Retrieve a list of distinct breeds for all pets that are either aged between 1 and 3 years or older than 5 years.
select distinct Breed from Pets 
where (Age between 1 and 3) or (Age > 5);

--12. Retrieve a list of pets and their respective shelters where the pets are currently available for adoption.
alter table Pets add ShelterID int foreign key references Shelters(ShelterID);

update Pets set ShelterID = 1 where PetID = 1;
update Pets set ShelterID = 2 where PetID = 2;
update Pets set ShelterID = 1 where PetID = 3;
update Pets set ShelterID = 4 where PetID = 4;
update Pets set ShelterID = 5 where PetID = 5;
update Pets set ShelterID = 5 where PetID = 6;
update Pets set ShelterID = 7 where PetID = 7;
update Pets set ShelterID = 8 where PetID = 8;
update Pets set ShelterID = 10 where PetID = 9;
update Pets set ShelterID = 10 where PetID = 10;

select P.Name as [Pet Name], S.Name as [Shelter Name] 
from Pets P 
left join Shelters S on P.ShelterID = S.ShelterID 
where P.AvailableForAdoption = 1;

--13. Find the total number of participants in events organized by shelters located in specific city
select count(P.ParticipantID) as [Total Participants] 
from Participants P 
join AdoptionEvents AE on P.EventID = AE.EventID
join Shelters S on AE.Location = S.Location 
where S.Location = 'Lucknow, Uttar Pradesh';

--14. Retrieve a list of unique breeds for pets with ages between 1 and 5 years
select distinct Breed from Pets 
where Age between 1 and 5;

--15. Find the pets that have not been adopted by selecting their information from the 'Pet' table
select PetID, Name, Age, Breed, Type, ShelterID from Pets 
where AvailableForAdoption = 1;

--16. Retrieve the names of all adopted pets along with the adopter's name from the 'Adoption' and User' tables.
-- As the 'Adoption' table were not specified in the schema, it is created below and filled with some values.

create table Adoption(
	AdoptionID int primary key,
	PetID int foreign key references Pets(PetID),
	UserID int foreign key references Users(UserID)
);

insert into Adoption values 
	(1, 3, 1),
	(2, 7, 2);

select P.Name [Name of Pet], U.UserName as [Adopter Name]
from Pets as P 
join Adoption as A on P.PetID = A.PetID 
join Users U on A.UserID = U.UserID;

--17. Retrieve a list of all shelters along with the count of pets currently available for adoption in each shelter.
select S.ShelterID, S.Name AS ShelterName, count(P.PetID) as [Pets Available For Adoption]
from Shelters S
left join Pets P ON S.ShelterID = P.ShelterID
where P.AvailableForAdoption = 1
group by S.ShelterID, S.Name;

--18. Find pairs of pets from the same shelter that have the same breed.
select P1.PetID, P1.Name, P1.Breed, P1.ShelterID from Shelters S 
join Pets P1 on S.ShelterID = P1.ShelterID 
join Pets P2 on P1.Breed = P2.Breed and P1.PetID <> P2.PetID;

--19. List all possible combinations of shelters and adoption events
select S.ShelterID, S.Name as [Shelter Name], AE.EventID, AE.EventName [Adoption Event Name], AE.EventDate, AE.Location as [Event Location]
from Shelters S
cross join AdoptionEvents AE;

--20. Determine the shelter that has the highest number of adopted pets
select 
	ShelterID, 
	(select Name from Shelters where ShelterID = Pets.ShelterID) [Shelter Name], 
	count(PetID) as [Number of Pets] from Pets
group by ShelterID
having count(PetID) = 
	(select top 1 count(*) from Pets group by ShelterID order by count(*) desc);
