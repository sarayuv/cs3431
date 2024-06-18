-- delete the tables
DROP TABLE ReservedTour;
DROP TABLE Tour;
DROP TABLE Guide;
DROP TABLE Customer;

-- drop the sequences
DROP SEQUENCE seq_ReservedTourID;
DROP SEQUENCE seq_customerID;
DROP SEQUENCE seq_tourID;
DROP SEQUENCE seq_guideID;

-- create the tables
CREATE TABLE Customer (
	customerID number(3) PRIMARY KEY,
	firstName varchar2(15),
	lastName varchar2(20),
	address varchar2(30),
	phone number(10),
	age number(3)
);

CREATE TABLE Tour (
	tourID number(2) PRIMARY KEY,
	tourName varchar2(25),
	description varchar2(35),
	city varchar2(25),
	state char(2),
	vehicleType varchar2(10),
	price number(5,2),
	CONSTRAINT check_vehicle CHECK (vehicleType IN ('boat', 'bus', 'car'))
);

CREATE TABLE Guide (
	guideID number(2) PRIMARY KEY,
	FirstName varchar2(15),
	LastName varchar2(20),
	driverLicense number(8) UNIQUE NOT NULL,
	Title varchar2(15),
	Salary number(7,2)
);

CREATE TABLE ReservedTour (
	reservedTourID number(3) PRIMARY KEY,
	travelDate date,
	customerID number(3),
	tourID number(2),
	guideID number(2),
	CONSTRAINT fk_customerID FOREIGN KEY (customerID) REFERENCES Customer(customerID) ON DELETE SET NULL,
	CONSTRAINT fk_tourID FOREIGN KEY (tourID) REFERENCES Tour(tourID) ON DELETE SET NULL,
	CONSTRAINT fk_guideID FOREIGN KEY (guideID) REFERENCES Guide(guideID) ON DELETE SET NULL
);

-- create sequences for the primary keys of the four tables
CREATE SEQUENCE seq_ReservedTourID
START WITH 100
INCREMENT BY 5;

CREATE SEQUENCE seq_customerID
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE seq_tourID
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE seq_guideID
START WITH 1
INCREMENT BY 1;

-- insert the spreadsheet data into the tables
insert into Customer values(seq_customerID.NEXTVAL, 'Michael', 'Davis', '8711 Meadow St.', 2497873464, 67);
insert into Customer values(seq_customerID.NEXTVAL, 'Lisa', 'Ward', '17 Valley Drive', 9865553232, 20);
insert into Customer values(seq_customerID.NEXTVAL, 'Brian', 'Gray', '1212 8th St.', 4546667821, 29);
insert into Customer values(seq_customerID.NEXTVAL, 'Nicole', 'Myers', '9 Washington Court', 9864752346, 18);
insert into Customer values(seq_customerID.NEXTVAL, 'Kelly', 'Ross', '98 Lake Hill Drive', 8946557732, 26);
insert into Customer values(seq_customerID.NEXTVAL, 'Madison', 'Powell', '100 Main St.', 8915367188, 57);
insert into Customer values(seq_customerID.NEXTVAL, 'Ashley', 'Martin', '42 Oak St.', 1233753684, 73);
insert into Customer values(seq_customerID.NEXTVAL, 'Joshua', 'White', '1414 Cedar St.', 6428369619, 18);
insert into Customer values(seq_customerID.NEXTVAL, 'Tyler', 'Clark', '42 Elm Place', 1946825344, 22);
insert into Customer values(seq_customerID.NEXTVAL, 'Anna', 'Young', '657 Redondo Ave.', 7988641411, 25);
insert into Customer values(seq_customerID.NEXTVAL, 'Justin', 'Powell', '5 Jefferson Ave.', 2324648888, 17);
insert into Customer values(seq_customerID.NEXTVAL, 'Bruce', 'Allen', '143 Cambridge Ave.', 5082328798, 45);
insert into Customer values(seq_customerID.NEXTVAL, 'Rachel', 'Sanchez', '77 Massachusetts Ave.', 6174153059, 68);
insert into Customer values(seq_customerID.NEXTVAL, 'Dylan', 'Lee', '175 Forest St.', 2123043923, 19);
insert into Customer values(seq_customerID.NEXTVAL, 'Austin', 'Garcia', '35 Tremont St.', 7818914567, 82);

insert into Tour values(seq_tourID.NEXTVAL, 'Alcatraz', 'Alcatraz Island', 'San Francisco', 'CA', 'boat', 75.5);
insert into Tour values(seq_tourID.NEXTVAL, 'Magnificent Mile', 'Tour of Michigan Ave', 'Chicago', 'IL', 'bus', 22.75);
insert into Tour values(seq_tourID.NEXTVAL, 'Duck Tour', 'Aquatic tour of the Charles River', 'Boston', 'MA', 'boat', 53.99);
insert into Tour values(seq_tourID.NEXTVAL, 'Freedom Trail', 'Historic tour of Boston', 'Boston', 'MA', 'car', 34.25);
insert into Tour values(seq_tourID.NEXTVAL, 'NY Museums', 'Tour of NYC Museums', 'New York', 'NY', 'bus', 160.8);

insert into Guide values(seq_guideID.NEXTVAL, 'Emily', 'Williams', 74920983, 'Senior Guide', 24125);
insert into Guide values(seq_guideID.NEXTVAL, 'Ethan', 'Brown', 72930684, 'Guide', 30500);
insert into Guide values(seq_guideID.NEXTVAL, 'Chloe', 'Jones', 50973848, 'Senior Guide', 27044);
insert into Guide values(seq_guideID.NEXTVAL, 'Ben', 'Miller', 58442323, 'Junior Guide', 32080);
insert into Guide values(seq_guideID.NEXTVAL, 'Mia', 'Davis', 56719583, 'Junior Guide', 49000);
insert into Guide values(seq_guideID.NEXTVAL, 'Noah', 'Garcia', 93291234, 'Guide', 22000);
insert into Guide values(seq_guideID.NEXTVAL, 'Liam', 'Rodriguez', 58799394, 'Junior Guide', 31750);
insert into Guide values(seq_guideID.NEXTVAL, 'Mason', 'Wilson', 88314545, 'Senior Guide', 45000);
insert into Guide values(seq_guideID.NEXTVAL, 'Olivia', 'Smith', 82391452, 'Junior Guide', 25025);
insert into Guide values(seq_guideID.NEXTVAL, 'Sofia', 'Johnson', 12930638, 'Guide', 47000);

insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '6-Feb-18', 6, 1, 2);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '31-Aug-18', 14, 3, 5);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '10-Apr-19', 11, 4, 1);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '29-Jul-18', 7, 2, 4);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '15-Mar-18', 14, 3, 2);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '28-Feb-19', 12, 4, 6);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '3-Jun-18', 14, 4, 2);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '17-May-18', 5, 1, 10);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '11-Apr-19', 9, 5, 3);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '24-Nov-18', 13, 4, 9);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '3-Aug-18', 3, 5, 7);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '13-Dec-17', 2, 1, 7);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '9-Nov-17', 4, 5, 1);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '21-Jan-19', 10, 2, 10);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '11-Dec-17', 5, 1, 7);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '12-Aug-18', 1, 3, 5);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '22-Jun-18', 5, 3, 8);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '1-Feb-19', 8, 2, 9);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '15-Oct-17', 15, 4, 8);
insert into ReservedTour values(seq_ReservedTourID.NEXTVAL, '8-Mar-18', 4, 1, 3);
