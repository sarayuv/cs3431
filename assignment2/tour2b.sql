/* 1a. List for each level of guide - junior guide, guide or 
senior guide - how many mismatches there are between the required tour’s 
vehicle type and the guide's license type. */
select count(*) as mismatches
from ReservedTours rt, Tours t, Guides g
where rt.tourID = t.tourID and rt.guideID = g.guideID and g.title = 'Junior Guide'
and not (
    (t.vehicleType = 'car' and g.licenseType in ('land', 'both')) or
    (t.vehicleType = 'bus' and g.licenseType in ('land', 'both')) or
    (t.vehicleType = 'boat' and g.licenseType in ('sea', 'both'))
);

select count(*) as mismatches
from ReservedTours rt, Tours t, Guides g
where rt.tourID = t.tourID and rt.guideID = g.guideID and g.title = 'Guide'
and not (
    (t.vehicleType = 'car' and g.licenseType in ('land', 'both')) or
    (t.vehicleType = 'bus' and g.licenseType in ('land', 'both')) or
    (t.vehicleType = 'boat' and g.licenseType in ('sea', 'both'))
);

select count(*) as mismatches
from ReservedTours rt, Tours t, Guides g
where rt.tourID = t.tourID and rt.guideID = g.guideID and g.title = 'Senior Guide'
and not (
    (t.vehicleType = 'car' and g.licenseType in ('land', 'both')) or
    (t.vehicleType = 'bus' and g.licenseType in ('land', 'both')) or
    (t.vehicleType = 'boat' and g.licenseType in ('sea', 'both'))
);

/* 1b. Include as a comment below your SQL code for 1a, why using 
natural joins gives you the wrong answer for this problem. */
/* Natural joins give you the wrong answer because they join tables based on
columns with the same name. This leads to incorrect joining of columns that 
are not supposed to be joined.*/

/* 2. Update the ReservedTours prices based on the prices in Tours. 
Note: You will need to create a nested SELECT statement in the SET clause 
after the equal sign. */
update ReservedTours rt
set rt.price = (
    select t.price
    from Tours t
    where t.tourID = rt.tourID
);

/* 3. For each customer, list the first name, last name, and total amount 
being spent for land-based tours. Format the price so it is displayed with 
two decimals and with the heading TotalLandPrice. If the price is less than 
1.00, then display a leading zero. For example, display 0.75 instead of .75. 
Sort by price in descending order so we can see who has paid the most for 
land-based tours. Sort by lastname and then first name. */
select c.firstName, c.lastName, sum(rt.price) as TotalLandPrice
from Customers c, ReservedTours rt, Tours t
where c.customerID = rt.customerID and rt.tourID = t.tourID and t.vehicleType in ('car', 'bus')
group by c.firstName, C.lastName
order by TotalLandPrice desc, c.lastName, c.firstName;

/* 4. For each vehicle type needed for a tour, list the number of locations 
(name the column Places) that vehicle type will be used for a given location 
type. For example, how many historic locations will require a boat or how many
museums will require a bus? Only display those results where the number of 
places is greater than one. */
select t.vehicleType, l.locationType, count(l.locationID) as Places
from Locations l, tours t
where l.tourID = t.tourID
group by t.vehicleType, l.locationType
having count(l.locationID) > 1;

/* 5. List the full name of a guide (name the column GuideName), and the total 
price with a tax of 10% of the tours that guide is responsible for (name the
column TotalRevenue). The TotalRevenue should be formatted to display a comma
for the thousands place, only two decimal places, and for amounts less than a 
dollar there will not be a zero to the left of the decimal. */
select 
    g.firstName || ' ' || g.lastName as GuideName,
    round(sum(rt.price * 1.1), 2) as TotalRevenue
from Guides g, ReservedTours rt
where g.guideID = rt.guideID
group by g.firstName, g.lastName;
