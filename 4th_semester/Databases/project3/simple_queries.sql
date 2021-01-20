/*
1
Selects the rooms that were available for 18/3/2020 and had a cost of $50.00.   
289 rows 
*/
SELECT "Listings".id,"Calendar".date,"Calendar".available,"Calendar".price, "Listings".listing_url
FROM "Listings"
INNER JOIN "Calendar"
ON "Listings".id = "Calendar".listing_id
WHERE "Calendar".date = '2020-03-18' AND "Calendar".available='t' AND "Calendar".price='$50.00';

/*
2
Selects the room that exist for March 2020 , in which the host has government id in his room's data. (room's host_verification has 'government_id')
61080
*/
SELECT "Listings".id,"Calendar".date,"Calendar".date,"Listings".host_verifications
FROM "Listings"
INNER JOIN "Calendar"
ON "Listings".id = "Calendar".listing_id
WHERE "Listings".host_verifications LIKE '%government_id%'  AND "Calendar".available='t'AND "Calendar".date BETWEEN '2020-03-01'AND'2020-03-31';

/*
3
Selects the rooms that were rated at 2/1/2020 with a total rating of 100.
62 rows
*/
SELECT "Listings".id,"Reviews".id,"Reviews".date,"Listings".review_scores_rating
FROM "Listings"
FULL OUTER JOIN "Reviews"
ON "Listings".id = "Reviews".listing_id
WHERE "Reviews".date='2020-01-02' and "Listings".review_scores_rating ='100';

/*
4
Selects the ratings tha took place at March 2020 for houses/rooms in Gyzi area (sorted by room id).
27 rows 
*/
SELECT "Listings".id,"Reviews".id,"Reviews".date,"Listings".neighbourhood
FROM "Listings"
INNER JOIN "Reviews"
ON "Listings".id = "Reviews".listing_id
WHERE "Listings".neighbourhood='Gazi' AND "Reviews".date BETWEEN '2020-03-01'AND'2020-03-31'
ORDER BY "Listings".id;

/*
5

Selects the ratings that occured in May 2020 for houses with at least 2 bedrooms and 5 beds.
(sorted by room/house id)
216 rows 
*/
SELECT "Listings".id,"Reviews".id,"Reviews".date,"Listings".neighbourhood, "Listings".price
FROM "Listings"
INNER JOIN "Reviews"
ON "Listings".id = "Reviews".listing_id
WHERE "Listings".beds>=5 AND "Listings".beds>=2 AND "Reviews".date BETWEEN '2020-03-01'AND'2020-03-31'
ORDER BY "Listings".id;

/*
6
Select the ratings that occured at 1/1/2020 for homes and rooms in Gazi area ,
which have a flexible cancelation policy and done need a deposit guarantee. (their deposit guarantee is $0.00, we dont count houses that give no information about their deposit guarantee )
(stored by room/home id) 
29 rows
*/
SELECT "Listings".id,"Reviews".id,"Reviews".date
FROM "Listings"
INNER JOIN "Reviews"
ON "Listings".id = "Reviews".listing_id
WHERE "Listings".security_deposit='$0.00' AND "Listings".cancellation_policy='flexible' AND "Reviews".date>'2020-01-01' AND "Listings".neighbourhood='Gazi'
ORDER BY "Listings".id;

/*
7
Select the ratings tha occured in March 2020 for rooms/houses tha allow pets.(sorted by room/home id)
416 rows 
*/
SELECT "Listings".id,"Reviews".id,"Reviews".date
FROM "Listings"
INNER JOIN "Reviews"
ON "Listings".id = "Reviews".listing_id
WHERE "Listings".amenities LIKE '%"Pets allowed"%'  AND "Reviews".date BETWEEN '2020-03-01'AND'2020-03-31'
ORDER BY "Listings".id;


/*
8
Selects the rooms/houses that were rated in March 2020 and calculates tha average number of rating they had that month,
and the first and last rating they had in March.(only the date)
(sorted by room/house id)
2200 rows
*/
SELECT "Reviews".listing_id,COUNT(*),MIN("Reviews".date),MAX("Reviews".date)
FROM "Reviews"
WHERE "Reviews".date BETWEEN '2020-03-01'AND'2020-03-31'
GROUP BY "Reviews".listing_id
ORDER BY "Reviews".listing_id;

/*
9
For every area in Neighbourhoods table , it counts the number of houses that have more that 10 beds and show's the maximum number of beds in each area.
(It also selects the name of the neigbourhoods tha dont have a house with more than 10 beds)
45 rows 
*/
SELECT "Neighbourhoods".neighbourhood,"Listings".neighbourhood_cleansed,COUNT(*), MAX("Listings".beds)
FROM "Neighbourhoods"
left OUTER JOIN "Listings"
ON "Neighbourhoods".neighbourhood="Listings".neighbourhood_cleansed
AND "Listings".beds>10
GROUP BY  "Neighbourhoods".neighbourhood,"Listings".neighbourhood_cleansed;

/*
10
For every area in Neighbourhoods table, it calculates the average number of ratings,
for the houses that have been rate at least once in 2020 and their host identity has been verified.
45 rows ( οσα εχει το table Neighbourhoods)
*/
SELECT "Neighbourhoods".neighbourhood, ROUND(AVG("Listings".number_of_reviews))
FROM "Neighbourhoods"
left OUTER JOIN "Listings"
ON "Neighbourhoods".neighbourhood="Listings".neighbourhood_cleansed AND "Listings".host_identity_verified='t' 
AND "Listings".last_review>'01-01-2020'
GROUP BY  "Neighbourhoods".neighbourhood,"Listings".neighbourhood_cleansed;

/*
11
Finds out the number of different hosts. (Some hosts may have more that 1 rooms/houses)
1 row
*/
SELECT COUNT(DISTINCT(host_id)) FROM "Listings";


/*
12
Selects the first 100 (sorted by id) rooms/houses located at an area that the coordinate column geometry_coordinates_0_0_87_0 reflects is not null.
100 rows 
*/
SELECT "Geolocation".properties_neighbourhood,"Listings".id,"Geolocation".geometry_coordinates_0_0_87_0
FROM "Geolocation"
INNER JOIN "Listings" 
ON "Geolocation".properties_neighbourhood="Listings".neighbourhood_cleansed AND "Geolocation".geometry_coordinates_0_0_87_0 is not null 
ORDER BY "Listings".id 
LIMIT 100;


