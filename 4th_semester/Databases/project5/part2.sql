/*
Βρίσκει τα δωμάτια των οποίων η ακριβής τοποθεσία είναι γνωστή και η συντεταγμένη  geometry_coordinates_0_0_81_0 της περιοχής τους δεν είναι null .
Στη συνέχεια τα ταξινομεί σε αύξουσα σειρά με βάση το listing_id.
2622 rows
*/

SELECT "Geolocation".properties_neighbourhood,"Location".listing_id,"Location".is_location_exact,"Geolocation".geometry_coordinates_0_0_81_0
FROM "Geolocation"
INNER JOIN "Location" 
ON "Geolocation".properties_neighbourhood="Location".neighbourhood_cleansed 
WHERE "Geolocation".geometry_coordinates_0_0_81_0 is not null AND is_location_exact='True'
ORDER BY "Location".listing_id ;



/*
Υπολογίζει τη μέση τιμή availability_30  για κάθε περιοχή περιοχή για τα σπίτια που έχουν πάνω απο 100 αξιολογήσεις.
45 rows
*/


SELECT "Location".neighbourhood_cleansed, Round (AVG("Listing".availability_30))
FROM "Location"
left OUTER JOIN "Listing"
ON "Location".listing_id="Listing".id AND number_of_reviews>100
GROUP BY  "Location".neighbourhood_cleansed;







/*
Βρίσκει τους φιλοξενούμενους ανά κρεβάτι που επιτρέπει ο κάθε οικοδεσπότης (σε όλα τα σπίτια του μαζί) 
και εμφάνιζει τους οικοδεσπότες που επιτρέπουν τουλάχιστον 2 φιλοξενούμενους για κάθε κρεβάτι που παρέχουν 
(η συνθήκη sum(beds)>0 υπάρχει για να μην γίνει διαίρεση με το μηδέν)
3736 rows
*/

select "Host".id, Round(Sum(accommodates)/sum(beds))
FROM "Host" 
INNER JOIN "Listing" on "Listing".host_id="Host".id
INNER JOIN "Room" ON "Listing".id="Room".listing_id 
GROUP BY "Host".id
HAVING   sum(beds)>0 AND (Round(Sum(accommodates)/sum(beds)))>=2 ;



/*
Βρίσκει τα σπίτια που έχουν γνωστή ακριβής τοποθεσία
και στη συνέχεια βρίσκει την μέση τιμή , τη μέγιστη τιμή και την ελάχιστη τιμή ενοικίασης για κάθε περιοχή
και τα επιστρέφει για όσες περιοχές έχουν μέση τιμή μεγαλύτερη απο 50 και μικρότερη απο 100. 
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
Για κάθε περιοχή , βρίσκει το πλήθος των ενοικιαζόμενων που έχουν κατάθεση εγγύησης μικρότερη των 20 ευρώ.
45 rows
*/



SELECT "Location".neighbourhood_cleansed, count(DISTINCT ("Price".listing_id))
FROM "Location"
LEFT OUTER JOIN "Price"
ON "Price".listing_id="Location".listing_id AND  security_deposit<20
GROUP BY "Location".neighbourhood_cleansed;

