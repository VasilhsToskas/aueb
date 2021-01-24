/*
Finds the rooms that have an exact location and the coordinate geometry_coordinates_0_0_81_0 of their location is not null .
Then it sorts them by listing id.
2622 rows
*/

SELECT "Geolocation".properties_neighbourhood,"Location".listing_id,"Location".is_location_exact,"Geolocation".geometry_coordinates_0_0_81_0
FROM "Geolocation"
INNER JOIN "Location" 
ON "Geolocation".properties_neighbourhood="Location".neighbourhood_cleansed 
WHERE "Geolocation".geometry_coordinates_0_0_81_0 is not null AND is_location_exact='True'
ORDER BY "Location".listing_id ;



/*
Calculates the average availability_30 price for each area for the houses that have been rated more than 100 times
45 rows
*/


SELECT "Location".neighbourhood_cleansed, Round (AVG("Listing".availability_30))
FROM "Location"
left OUTER JOIN "Listing"
ON "Location".listing_id="Listing".id AND number_of_reviews>100
GROUP BY  "Location".neighbourhood_cleansed;







/*
Finds the guests allowed by the host per bed (in all his/hers houses)
and shows the guests that allow at least 2 guests per bed 
(sum(beds)>0 exists in order to avoid dividing by 0)
3736 rows
*/

select "Host".id, Round(Sum(accommodates)/sum(beds))
FROM "Host" 
INNER JOIN "Listing" on "Listing".host_id="Host".id
INNER JOIN "Room" ON "Listing".id="Room".listing_id 
GROUP BY "Host".id
HAVING   sum(beds)>0 AND (Round(Sum(accommodates)/sum(beds)))>=2 ;



/*
Finds the houses with known location 
and then calculates the average price , the maximum price ,and the minimun rent price for each area
and shows the areas with 50 < average rent price < 100.
20 rows
*/


SELECT "Location".neighbourhood_cleansed, Round (AVG("Price".price)) AS AVG ,MAX("Price".price) AS MAX,MIN("Price".price) AS MIN
FROM "Price"
INNER JOIN "Location"
ON "Price".listing_id="Location".listing_id 
WHERE is_location_exact='true'
GROUP BY "Location".neighbourhood_cleansed
HAVING Round (AVG("Price".price)) <100 AND (AVG("Price".price)) >50;






/*
For each area , it finds the number of houses/rooms that have deposit guarantee less than 20.
45 rows
*/



SELECT "Location".neighbourhood_cleansed, count(DISTINCT ("Price".listing_id))
FROM "Location"
LEFT OUTER JOIN "Price"
ON "Price".listing_id="Location".listing_id AND  security_deposit<20
GROUP BY "Location".neighbourhood_cleansed;

