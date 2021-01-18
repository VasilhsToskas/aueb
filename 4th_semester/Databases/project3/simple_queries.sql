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
Βρίσκει τις εγγραφές δωματίων που υπάρχουν στο calendar για τον Μάρτη του 2020 , 
στις οποίες ο οικοδεσπότης παρείχε government id  στα στοιχεία του (δηλαδη το host_verification του δωματίου περιέχει το 'government_id')
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
Selects the ratings that  Βρίσκει τις αξιολογήσεις που έγιναν τον Μάιο του 2020 για σπίτια με τουλάχιστον 2 υπνοδωμάτια και τουλάχιστον 5 κρεβάτια.
(ταξινομημένα με βάση το id του σπιτιού)
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
Βρίσκει τις αξιολογήσεις που έγιναν το απο την 1η Γενάρη του 2020 για σπίτια-δωμάτια στην περιοχή Γκάζι ,
τα οποία έχουν ευέλικτη πολιτική ακυρώσεων και δεν χρειάζονται κατάθεση εγγύησης .(έχουν κατάθεση εγγύησης ίση με $0.00, ΔΕΝ συνυπολογίζονται όσα δεν παρέχουν πληροφιορίες για την κατάθεση εγγύησης) 
(ταξινομημένα με βάση το id του σπιτιού)
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
Βρίσκει τις αξιολογήσεις που έγιναν τον Μάρτη του 2020 για τα σπίτια δωμάτια που επιτρέπουν κατοικίδια στις ανέσεις (amenities).
(ταξινομημένα με βάση το id του σπιτιού)
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
Βρίσκει τα σπίτια-δωμάτια που αξιολογήθηκαν τον Μάρτη του 2020 και υπολογίζει το πλήθος των αξιολογήσεων που είχαν εκείνο το μήνα 
καθώς και την πρώτη και την τελευταία αξιολόγηση που είχαν μεσα στο μήνα .
(ταξινομημένα με βάση το id του σπιτιού)
2200 rows
*/
SELECT "Reviews".listing_id,COUNT(*),MIN("Reviews".date),MAX("Reviews".date)
FROM "Reviews"
WHERE "Reviews".date BETWEEN '2020-03-01'AND'2020-03-31'
GROUP BY "Reviews".listing_id
ORDER BY "Reviews".listing_id;

/*
9
Για κάθε περιοχή του table Neighbourhoods , υπολογίζει το πλήθος των σπιτιών που έχουν περισσότερα απο 10 κρεβάτια και το μέγιστο πλήθος κρεβατιών
(Για τις περιοχές που δεν έχουν σπίτι με >10 κρεβάτια , εμφανίζει απλά το όνομά τους)
45 rows ( οσα εχει το table Neighbourhoods)
*/
SELECT "Neighbourhoods".neighbourhood,"Listings".neighbourhood_cleansed,COUNT(*), MAX("Listings".beds)
FROM "Neighbourhoods"
left OUTER JOIN "Listings"
ON "Neighbourhoods".neighbourhood="Listings".neighbourhood_cleansed
AND "Listings".beds>10
GROUP BY  "Neighbourhoods".neighbourhood,"Listings".neighbourhood_cleansed;

/*
10
Για κάθε περιοχή του table Neighbourhoods, υπολογίζει το μέσο πλήθος αξιολογήσεων ,
για τα σπίτια όπου η τελευταία αξιολόγηση έγινε απο την 1η γενάρη 2020 και μετά , και έχει επαληθευτεί η ταυτότητα του οικοδεσπότη τους.
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


