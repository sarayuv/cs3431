-- drop statements
drop table Path2;
drop table Path;
drop table Edge;
drop table Employee;
drop table Title;
drop table Location;

-- create tables
create table Location (
    locationID varchar2(40) primary key,
    location_name varchar2(40),
    location_type varchar2(40),
    x_coord number(5),
    y_coord number(5),
    location_floor char(1),
    constraint x_y_floor unique (x_coord, y_coord, location_floor)
);

create table Office (
    locationID varchar2(40) primary key,
    foreign key (locationID) references Location(locationID)
);

create table Hallway (
    locationID varchar2(40) primary key,
    description varchar2(100),
    foreign key (locationID) references Location(locationID)
);

create table Title (
    acronym varchar2(40) primary key,
    title_name varchar2(50) unique
);

create table Employee (
    account varchar2(40) primary key,
    first_name varchar2(40) not null,
    last_name varchar2(40) not null,
    office_location varchar2(40),
    phone_ext varchar2(40),
    acronym varchar2(40),
    constraint employee_office_location_FK foreign key (office_location) references Location(locationID)
);

create table Edge (
    start_location varchar2(40),
    end_location varchar2(40),
    primary key (start_location, end_location),
    constraint edge_start_location_FK foreign key (start_location) references Location (locationID),
    constraint edge_end_location_FK foreign key (end_location) references Location(locationID)
);

create table Path (
    pathID number(5) primary key,
    path_name varchar2(40)
);

create table Path2 (
    pathID number(5),
    locationID varchar(40),
    locations_list number(5),
    primary key (pathID, locations_list),
    constraint path2_location_pathID_FK foreign key (pathID) references Path(pathID),
    constraint path2_location_locationID_FK foreign key (locationID) references Location(locationID)
);

-- insert data into tables
insert into Location values ('307', 'FL307', 'Office', 900, 440, '3');
insert into Location values ('308', 'FL308', 'Office', 900, 335, '3');
insert into Location values ('311', 'FL311', 'Conference Room', 900, 375, '3');
insert into Location values ('312', 'FL312', 'Office', 945, 510, '3');
insert into Location values ('314', 'FL314', 'Office', 845, 660, '3');
insert into Location values ('316', 'FL316', 'Office', 845, 760, '3');
insert into Location values ('317', 'FL317', 'Office', 925, 670, '3');
insert into Location values ('318', 'FL318', 'Office', 950, 700, '3');
insert into Location values ('319', 'FL319', 'Office', 925, 735, '3');
insert into Location values ('320', 'FL320', 'Lecture Hall', 900, 920, '3');
insert into Location values ('3E1', '3rd Floor Elevator', 'Elevator', 820, 415, '3');
insert into Location values ('3H1', 'FL3H1', 'Hallway', 790, 150, '3');
insert into Location values ('3H2', 'FL3H2', 'Hallway', 790, 340, '3');
insert into Location values ('3H3', 'FL3H3', 'Hallway', 790, 375, '3');
insert into Location values ('3H4', 'FL3H4', 'Hallway', 790, 420, '3');
insert into Location values ('3H5', 'FL3H5', 'Hallway', 790, 465, '3');
insert into Location values ('3H6', 'FL3H6', 'Hallway', 900, 465, '3');
insert into Location values ('3H7', 'FL3H7', 'Hallway', 900, 510, '3');
insert into Location values ('3H8', 'FL3H8', 'Hallway', 790, 660, '3');
insert into Location values ('3H9', 'FL3H9', 'Hallway', 790, 700, '3');
insert into Location values ('3H10', 'FL3H10', 'Hallway', 925, 700, '3');
insert into Location values ('3H11', 'FL3H11', 'Hallway', 790, 755, '3');
insert into Location values ('3H12', 'FL3H12', 'Hallway', 790, 925, '3');
insert into Location values ('3H13', 'FL3H13', 'Hallway', 840, 920, '3');
insert into Location values ('3S1', '3rd Floor Staircase 1', 'Staircase', 835, 340, '3');
insert into Location values ('3S2', '3rd Floor Staircase 2', 'Staircase', 840, 965, '3');

insert into Title values ('Adj Assoc Prof', 'Adjunct Associate Professor');
insert into Title values ('Admin 5', 'Administrative Assistant V');
insert into Title values ('Admin 6', 'Administrative Assistant VI');
insert into Title values ('Asst Prof', 'Assistant Professor');
insert into Title values ('Asst TProf', 'Assistant Teaching Professor');
insert into Title values ('Assoc Prof', 'Associate Professor');
insert into Title values ('C-MGRG', 'Coordinator of Mobile Graphics Research Group');
insert into Title values ('DeptHead', 'Department Head');
insert into Title values ('Dir-DS', 'Director of Data Science');
insert into Title values ('Dir-LST', 'Director of Learn Sciences and Technologies');
insert into Title values ('GradAdmin', 'Graduate Admin Coordinator');
insert into Title values ('Lab1', 'Lab Manager I');
insert into Title values ('Lab2', 'Lab Manager II');
insert into Title values ('Prof', 'Professor');
insert into Title values ('SrInst', 'Senior Instructor');
insert into Title values ('TProf', 'Teaching Professor');

--insert into Employee values ('ruiz', 'Carolina', 'Ruiz', '232', '5640', 'Assoc Prof');
--insert into Employee values ('rich', 'Charles', 'Rich', 'B25b', '5945', 'Prof');
--insert into Employee values ('ccaron', 'Christine', 'Caron', '233', '5678', 'Admin 6');
--insert into Employee values ('cshue', 'Craig', 'Shue', '236', '4933', 'Asst Prof');
--insert into Employee values ('cew', 'Craig', 'Wills', '234', '5357, 5622', 'Prof, DeptHead');
--insert into Employee values ('dd', 'Daniel', 'Dougherty', '231', '5621', 'Prof');
--insert into Employee values ('deselent', 'Douglas', 'Selent', '144', '5493', 'Asst TProf');
--insert into Employee values ('rundenst', 'Elke', 'Rundensteiner', '135', '5815', 'Prof, Dir-DS');
--insert into Employee values ('emmanuel', 'Emmanuel', 'Agu', '139', '5568', 'Assoc Prof, C-MGRG');
--insert into Employee values ('heineman', 'George', 'Heineman', 'B20', '5502', 'Assoc Prof');
--insert into Employee values ('ghamel', 'Glynis', 'Hamel', '132', '5252', 'SrInst');
--insert into Employee values ('lauer', 'Hugh', 'Lauer', '144', '5493', 'TProf');
--insert into Employee values ('jleveillee', 'John', 'Leveillee', '244', '5822', 'Lab1');
--insert into Employee values ('josephbeck', 'Joseph', 'Beck', '138', '6156', 'Assoc Prof');
--insert into Employee values ('kfisler', 'Kathryn', 'Fisler', '130', '5118', 'Prof');
--insert into Employee values ('kven', 'Krishna', 'Venkatasubramanian', '137', '6571', 'Asst Prof');
--insert into Employee values ('claypool', 'Mark', 'Claypool', 'B24', '5409', 'Prof');
--insert into Employee values ('hofri', 'Micha', 'Hofri', '133', '6911', 'Prof');
--insert into Employee values ('ciaraldi', 'Michael', 'Ciaraldi', '129', '5117', 'SrInst');
--insert into Employee values ('mvoorhis', 'Michael', 'Voorhis', '245', '5669, 5674', 'Lab2');
--insert into Employee values ('meltabakh', 'Mohamed', 'Eltabakh', '235', '6421', 'Assoc Prof');
--insert into Employee values ('nth', 'Neil', 'Heffernan', '237', '5569', 'Prof, Dir-LST');
--insert into Employee values ('nkcaligiuri', 'Nicole', 'Caligiuri', '233', '5357', 'Admin 5');
--insert into Employee values ('rcane', 'Refie', 'Cane', '233', '5357', 'GradAdmin');
--insert into Employee values ('tgannon', 'Thomas', 'Gannon', '243', '5357', 'Adj Assoc Prof');
--insert into Employee values ('wwong2', 'Wilson', 'Wong', 'B19', '5706', 'Asst Prof');

insert into Edge values ('3H1', '3H2');
insert into Edge values ('3H2', '3H1');
insert into Edge values ('3H2', '3S1');
insert into Edge values ('3S1', '3H2');
insert into Edge values ('3H2', '3H3');
insert into Edge values ('3H3', '3H2');
insert into Edge values ('3H3', '3H4');
insert into Edge values ('3H4', '3H3');
insert into Edge values ('3H4', '3E1');
insert into Edge values ('3E1', '3H4');
insert into Edge values ('3H4', '3H5');
insert into Edge values ('3H5', '3H4');
insert into Edge values ('3H5', '3H6');
insert into Edge values ('3H6', '3H5');
insert into Edge values ('3H6', '3H7');
insert into Edge values ('3H7', '3H6');
insert into Edge values ('3H7', '312');
insert into Edge values ('312', '3H7');
insert into Edge values ('3H6', '308');
insert into Edge values ('308', '3H6');
insert into Edge values ('3H7', '3H8');
insert into Edge values ('3H8', '3H7');
insert into Edge values ('3H8', '3H9');
insert into Edge values ('3H9', '3H8');
insert into Edge values ('3H9', '318');
insert into Edge values ('318', '3H9');
insert into Edge values ('3H9', '3H10');
insert into Edge values ('3H10', '3H9');
insert into Edge values ('3H10', '319');
insert into Edge values ('319', '3H10');
insert into Edge values ('3H8', '314');
insert into Edge values ('314', '3H8');
insert into Edge values ('3H8', '3H11');
insert into Edge values ('3H11', '3H8');
insert into Edge values ('3H11', '316');
insert into Edge values ('316', '3H11');
insert into Edge values ('3H11', '3H12');
insert into Edge values ('3H12', '3H11');
insert into Edge values ('3H12', '3S2');
insert into Edge values ('3S2', '3H12');
insert into Edge values ('3H12', '320');
insert into Edge values ('320', '3H12');
insert into Edge values ('3H12', '3H13');
insert into Edge values ('3H13', '3H12');
insert into Edge values ('3H13', '3H11');
insert into Edge values ('3H11', '3H13');

insert into Path values (1, 'Elevator E1 to Room 320');
insert into Path values (2, 'Room 312 to Room 319');
insert into Path values (3, 'Bottom Stairs S2 to Room 308');

-- path 1: elevator E1 to room 320
insert into Path2 values (1, '3E1', 1);
insert into Path2 values (1, '3H4', 2);
insert into Path2 values (1, '3H5', 3);
insert into Path2 values (1, '3H6', 4);
insert into Path2 values (1, '3H7', 5);
insert into Path2 values (1, '3H8', 6);
insert into Path2 values (1, '3H11', 7);
insert into Path2 values (1, '3H12', 8);
insert into Path2 values (1, '3H13', 9);
insert into Path2 values (1, '320', 10);

-- path 2: room 312 to room 319
insert into Path2 values (2, '312', 1);
insert into Path2 values (2, '3H7', 2);
insert into Path2 values (2, '3H6', 3);
insert into Path2 values (2, '3H5', 4);
insert into Path2 values (2, '3H8', 5);
insert into Path2 values (2, '3H9', 6);
insert into Path2 values (2, '3H10', 7);
insert into Path2 values (2, '319', 8);

-- path 3: bottom stairs S2 to room 308
insert into Path2 values (3, '3S2', 1);
insert into Path2 values (3, '3H12', 2);
insert into Path2 values (3, '3H11', 3);
insert into Path2 values (3, '3H8', 4);
insert into Path2 values (3, '3H7', 5);
insert into Path2 values (3, '3H6', 6);
insert into Path2 values (3, '3H5', 7);
insert into Path2 values (3, '3H4', 8);
insert into Path2 values (3, '3H3', 9);
insert into Path2 values (3, '3H2', 10);
insert into Path2 values (3, '3H1', 11);
insert into Path2 values (3, '308', 12);
