-- 1 - NoLabMgr

create or replace view CSStaffNotLabMgr as
select s.accountName, s.officeID
from CSStaff s
left join CSStaffTitles t on s.accountName = t.accountName
left join Titles t2 on t.acronym = t2.acronym
where t2.titleName is null or t2.titleName != 'Lab Manager';

create or replace view NumOfficeStaff as
select officeID, count(*) as numStaff
from CSStaffNotLabMgr
group by officeID;

create or replace view NoLabMgr as
select o.officeID, o.numStaff
from NumOfficeStaff o
join Offices off on o.officeID = off.officeID
join Locations l on off.officeID = l.locationID
where l.locationType = 'Office' and o.numStaff > 1;

select * from NoLabMgr;

-- 2 - NumberOfStaff

set serveroutput on;

create or replace procedure NumberOfStaff(officeID_param varchar2) is
    staffCount_var number;
begin
    select count(*)
    into staffCount_var
    from CSStaff
    where officeID = officeID_param;

    dbms_output.put_line('Number of CS staff in office ' || officeID_param || ': ' || staffCount_var);
end;
/

-- Trigger 1

create or replace trigger NoSameLocations
before insert on Edges
for each row
begin
    if :new.startingLocationID = :new.endingLocationID then
        raise_application_error(-20000, 'Edges that are added cannot have two of the same locations.');
    end if;
end;
/

-- Trigger 2 - CrossFloorEdge

create or replace trigger CrossFloorEdge
before insert on Edges
for each row
declare
    startLocationType varchar2(15);
    endLocationType varchar2(15);
begin
    select locationType
    into startLocationType
    from Locations
    where locationID = :new.startingLocationID;
    
    select locationType
    into endLocationType
    from Locations
    where locationID = :new.endingLocationID;
    
    if startLocationType != endLocationType 
        and not ((startLocationType = 'Elevator' 
        and endLocationType = 'Elevator') 
        or (startLocationType = 'Staircase' and endLocationType = 'Staircase')) 
        then raise_application_error(-20000, 'The only edges that can be added with locations on different floors are those edges that have either both elevator locations or staircase locations.');
    end if;
end;
/


-- Trigger 3 - MustBeOffice

create or replace trigger MustBeOffice
before insert or update on Offices
for each row
declare
    cursor location_cursor is
        select locationID, locationType
        from Locations
        where locationID = :new.officeID;
        
    location_record location_cursor%rowtype;
begin
    open location_cursor;
    fetch location_cursor into location_record;
    
    if location_cursor%notfound then
        raise_application_error(-20000, 'Location ID ' || :new.officeID || ' does not exist in Locations table.');
    else
        if location_record.locationType != 'Office' then
            raise_application_error(-20000, 'Office ID ' || :new.officeID || ': The matching locationID in Locations is not of type Office.');
        end if;
    end if;
    
    close location_cursor;
end;
/

-- Trigger 4 - TitleLimit

create or replace trigger TitleLimit
after insert or update on CSStaffTitles
declare
    cursor prof_cursor is
        select accountName, count(acronym) as title_count
        from CSStaffTitles
        group by accountName
        having count(acronym) > 3;
begin
    for prof_rec in prof_cursor loop
        raise_application_error(-20000, 'Professor ' || prof_rec.accountName || ' has more than 3 titles.');
    end loop;
end;
/

-- Testing Triggers

insert into Locations (locationID, locationName, locationType, xcoord, ycoord, mapFloor) values ('L1', 'Location 1', 'Office', 100, 100, '1');
insert into Locations (locationID, locationName, locationType, xcoord, ycoord, mapFloor) values ('L4', 'Location 4', 'Elevator', 400, 400, '2');
insert into Locations (locationID, locationName, locationType, xcoord, ycoord, mapFloor) Values ('L7', 'Location 7', 'Lab', 700, 700, '1');

-- invalid edge insertions
insert into Edges (edgeID, startingLocationID, endingLocationID) values ('E1', 'L1', 'L1');
insert into Edges (edgeID, startingLocationID, endingLocationID) values ('E2', 'L1', 'L4');

-- invalid office insertion
insert into Offices (officeID) values ('L7');

-- invalid title insertion
insert into CSStaff (accountName, firstName, lastName, officeID) values ('prof_sarayu', 'Sarayu', 'Vijayanagaram', '129');
insert into CSStaffTitles (accountName, acronym) values ('prof_sarayu', 'Prof');
insert into CSStaffTitles (accountName, acronym) values ('prof_sarayu', 'Asst TProf');
insert into CSStaffTitles (accountName, acronym) values ('prof_sarayu', 'Assoc Prof');
insert into CSStaffTitles (accountName, acronym) values ('prof_sarayu', 'DeptHead');
