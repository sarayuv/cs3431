-- decreases the price of tours that are $100 or more by $100 but only in 
-- states of CA and NY
update Tour
set price = price - 100
where price >= 100
    and state in ('CA', 'NY');
    
-- list all the guides who are doing either a Freedom Trail tour or are a
-- junior tour guide
select distinct Guide.FirstName, Guide.LastName
from Guide
natural join ReservedTour
natural join Tour
where Tour.tourName = 'Freedom Trail'
    or Guide.Title = 'Junior Guide'
order by Guide.LastName, Guide.FirstName;

-- list tours that have customers who are over 65 OR tours that use boats
select ReservedTour.travelDate, 
    Customer.firstName || ' ' || Customer.lastName as fullName,
    Customer.age,
    Tour.tourName
from ReservedTour
join Customer on ReservedTour.customerID = Customer.customerID
join Tour on ReservedTour.tourID = Tour.tourID
where Customer.age > 65 
    or Tour.vehicleType = 'boat'
order by Tour.tourName, fullName;

-- list the 5 tours and names of the guides who will be giving those tours
select distinct Tour.tourName, Guide.FirstName, Guide.LastName
from ReservedTour
join Tour on ReservedTour.tourID = Tour.tourID
join Guide on ReservedTour.guideID = Guide.guideID
and rownum <= 5
order by Tour.tourName, Guide.LastName, Guide.FirstName
