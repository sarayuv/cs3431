-- DROP FK CONSTRAINTS
alter table ReservedTours drop constraint fk_guideID2;
alter table ReservedTours drop constraint fk_tourID2;
alter table ReservedTours drop constraint fk_customerID2;
alter table Locations drop constraint fk_toursTable;

-- DROP TABLES
drop table Customers;
drop table Guides;
drop table Tours;
drop table Locations;
drop table ReservedTours;

-- DROP SEQUENCES
drop sequence seq_ReservedTourID;
drop sequence seq_customerID;
drop sequence seq_tourID;
drop sequence seq_guideID;

-- CREATE TABLES
create table Customers (
    customerID number(3) primary key,
    firstName varchar2(15),
    lastName varchar2(20),
    address varchar2(30),
    phone number(10) unique,
    age number(3) not null
);

create table Tours (
    tourID number(2) primary key,
    tourName varchar2(25),
    description varchar2(35),
    city varchar2(25),
    state char(2),
    vehicleType varchar2(10),
    price number(5, 2),
    constraint check_vehicleType check (vehicleType in ('boat', 'bus', 'car'))
);

create table Locations (
    locationID char(3) primary key,
    locationName varchar2(40),
    locationType varchar2(15),
    address varchar2(40),
    tourID number(2),
    constraint fk_toursTable foreign key (tourID) references Tours(tourID)
);

create table Guides (
    guideID number(2) primary key,
    firstName varchar2(15),
    lastName varchar2(20),
    driverLicense number(8) unique not null,
    title varchar2(15),
    salary number(7, 2),
    licenseType varchar2(10),
    constraint check_license check (licenseType in ('land', 'sea', 'both'))
    -- land licenses permit the use of buses and cars, sea licenses permit the use of boats
);

create table ReservedTours (
    reservedTourID number(3) primary key,
    travelDate date,
    customerID number(3),
    tourID number(2),
    guideID number(2),
    price number(6, 2) default null,
    constraint fk_customerID2 foreign key (customerID) references Customers(customerID) on delete set null,
    constraint fk_tourID2 foreign key (tourID) references Tours(tourID) on delete set null,
    constraint fk_guideID2 foreign key (guideID) references Guides(guideID) on delete set null
);

-- CREATE SEQUENCES FOR THE PRIMARY KEYS
create sequence seq_ReservedTourID start with 100 increment by 5;
create sequence seq_customerID start with 1 increment by 1;
create sequence seq_tourID start with 1 increment by 1;
create sequence seq_guideID start with 1 increment by 1;

-- INSERT THE SPREADSHEET DATA INTO THE TABLES
insert into Customers values(1, 'Michael', 'Davis', '8711 Meadow St.', 2497873464, 67);
insert into Customers values(2, 'Lisa', 'Ward', '17 Valley Drive', 9865553232, 20);
insert into Customers values(3, 'Brian', 'Gray', '1212 8th St.', 4546667821, 29);
insert into Customers values(4, 'Nicole', 'Myers', '9 Washington Court', 9864752346, 18);
insert into Customers values(5, 'Kelly', 'Ross', '98 Lake Hill Drive', 8946557732, 26);
insert into Customers values(6, 'Madison', 'Powell', '100 Main St.', 8915367188, 57);
insert into Customers values(7, 'Ashley', 'Martin', '42 Oak St.', 1233753684, 73);
insert into Customers values(8, 'Joshua', 'White', '1414 Cedar St.', 6428369619, 18);
insert into Customers values(9, 'Tyler', 'Clark', '42 Elm Place', 1946825344, 22);
insert into Customers values(10, 'Anna', 'Young', '657 Redondo Ave.', 7988641411, 25);
insert into Customers values(11, 'Justin', 'Powell', '5 Jefferson Ave.', 2324648888, 17);
insert into Customers values(12, 'Bruce', 'Allen', '143 Cambridge Ave.', 5082328798, 45);
insert into Customers values(13, 'Rachel', 'Sanchez', '77 Massachusetts Ave.', 6174153059, 68);
insert into Customers values(14, 'Dylan', 'Lee', '175 Forest St.', 2123043923, 19);
insert into Customers values(15, 'Austin', 'Garcia', '35 Tremont St.', 7818914567, 82);

insert into Tours values(1, 'Alcatraz', 'Alcatraz Island', 'San Francisco', 'CA', 'boat', 75.5);
insert into Tours values(2, 'Magnificent Mile', 'Tour of Michigan Ave', 'Chicago', 'IL', 'bus', 22.75);
insert into Tours values(3, 'Duck Tour', 'Aquatic tour of the Charles River', 'Boston', 'MA', 'boat', 53.99);
insert into Tours values(4, 'Freedom Trail', 'Historic tour of Boston', 'Boston', 'MA', 'car', 34.25);
insert into Tours values(5, 'NY Museums', 'Tour of NYC Museums', 'New York', 'NY', 'bus', 160.8);

insert into Locations values('AI1', 'San Francisco Pier 33', 'Historic', 'Pier 33 Alcatraz Landing', 1);
insert into Locations values('AI2', 'Alcatraz Ferry Terminal', 'Historic', 'Ferry Terminal', 1);
insert into Locations values('AI3', 'Agave Trail', 'Park', 'Alcatraz Agave Trail', 1);
insert into Locations values('MM1', 'Art Institute', 'Museum', '111 S Michigan Avenue', 2);
insert into Locations values('MM2', 'Chicago Tribune', 'Historic', '435 N Michigan Avenue', 2);
insert into Locations values('MM3', 'White Castle', 'Restaurant', 'S Wabash Avenue', 2);
insert into Locations values('DT1', 'Charles River', 'Historic', '10 Mass Avenue', 3);
insert into Locations values('DT2', 'Salt and Pepper Bridge', 'Historic', '100 Broadway', 3);
insert into Locations values('FT1', 'Boston Common', 'Park', '139 Tremont Street', 4);
insert into Locations values('FT2', 'Kings Chapel', 'Historic', '58 Tremont Street', 4);
insert into Locations values('FT3', 'Omni Parker House', 'Restaurant', '60 School Street', 4);
insert into Locations values('FT4', 'Paul Revere House', 'Historic', '19 North Square', 4);
insert into Locations values('FT5', 'Bunker Hill Monument', 'Historic', 'Monument Square', 4);
insert into Locations values('NY1', 'Metropolitan Museum of Art', 'Museum', '1000 5th Ave', 5);
insert into Locations values('NY2', 'Museum of Modern Art', 'Museum', '11 W 53rd St', 5);
insert into Locations values('NY3', 'New York Botanical Garden', 'Park', '2900 Southern Boulevard', 5);
insert into Locations values('NY4', 'New Museum', 'Museum', '235 Bowery', 5);

insert into Guides values(1, 'Emily', 'Williams', 74920983, 'Senior Guide', 24125, 'land');
insert into Guides values(2, 'Ethan', 'Brown', 72930684, 'Guide', 30500, 'sea');
insert into Guides values(3, 'Chloe', 'Jones', 50973848, 'Senior Guide', 27044, 'both');
insert into Guides values(4, 'Ben', 'Miller', 58442323, 'Junior Guide', 32080, 'both');
insert into Guides values(5, 'Mia', 'Davis', 56719583, 'Junior Guide', 49000, 'land');
insert into Guides values(6, 'Noah', 'Garcia', 93291234, 'Guide', 22000, 'land');
insert into Guides values(7, 'Liam', 'Rodriguez', 58799394, 'Junior Guide', 31750, 'sea');
insert into Guides values(8, 'Mason', 'Wilson', 88314545, 'Senior Guide', 45000, 'land');
insert into Guides values(9, 'Olivia', 'Smith', 82391452, 'Junior Guide', 25025, 'sea');
insert into Guides values(10, 'Sofia', 'Johnson', 12930638, 'Guide', 47000, 'both');

insert into ReservedTours values(100, TO_DATE('6-Feb-18', 'DD-Mon-YY'), 6, 1, 2, null);
insert into ReservedTours values(105, TO_DATE('31-Aug-18', 'DD-Mon-YY'), 14, 3, 5, null);
insert into ReservedTours values(110, TO_DATE('10-Apr-19', 'DD-Mon-YY'), 11, 4, 1, null);
insert into ReservedTours values(115, TO_DATE('29-Jul-18', 'DD-Mon-YY'), 7, 2, 4, null);
insert into ReservedTours values(120, TO_DATE('15-Mar-18', 'DD-Mon-YY'), 14, 3, 2, null);
insert into ReservedTours values(125, TO_DATE('28-Feb-19', 'DD-Mon-YY'), 12, 4, 6, null);
insert into ReservedTours values(130, TO_DATE('3-Jun-18', 'DD-Mon-YY'), 14, 4, 2, null);
insert into ReservedTours values(135, TO_DATE('17-May-18', 'DD-Mon-YY'), 5, 1, 10, null);
insert into ReservedTours values(140, TO_DATE('11-Apr-19', 'DD-Mon-YY'), 9, 5, 3, null);
insert into ReservedTours values(145, TO_DATE('24-Nov-18', 'DD-Mon-YY'), 13, 4, 9, null);
insert into ReservedTours values(150, TO_DATE('3-Aug-18', 'DD-Mon-YY'), 3, 5, 7, null);
insert into ReservedTours values(155, TO_DATE('13-Dec-17', 'DD-Mon-YY'), 2, 1, 7, null);
insert into ReservedTours values(160, TO_DATE('9-Nov-17', 'DD-Mon-YY'), 4, 5, 1, null);
insert into ReservedTours values(165, TO_DATE('21-Jan-19', 'DD-Mon-YY'), 10, 2, 10, null);
insert into ReservedTours values(170, TO_DATE('11-Dec-17', 'DD-Mon-YY'), 5, 1, 7, null);
insert into ReservedTours values(175, TO_DATE('12-Aug-18', 'DD-Mon-YY'), 1, 3, 5, null);
insert into ReservedTours values(180, TO_DATE('22-Jun-18', 'DD-Mon-YY'), 5, 3, 8, null);
insert into ReservedTours values(185, TO_DATE('1-Feb-19', 'DD-Mon-YY'), 8, 2, 9, null);
insert into ReservedTours values(190, TO_DATE('15-Oct-17', 'DD-Mon-YY'), 15, 4, 8, null);
insert into ReservedTours values(195, TO_DATE('8-Mar-18', 'DD-Mon-YY'), 4, 1, 3, null);
