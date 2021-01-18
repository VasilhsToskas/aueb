CREATE TABLE "Host" AS
SELECT 
    host_id, host_url, host_name, host_since, host_location, host_about,
host_response_time, host_response_rate, host_acceptance_rate, host_is_superhost,
host_thumbnail_url, host_picture_url, host_neighbourhood, host_listings_count,
host_total_listings_count, host_verifications, host_has_profile_pic, host_identity_verified,
calculated_host_listings_count
FROM
    "Listings";




ALTER TABLE "Host" 
RENAME COLUMN host_id TO id;

ALTER TABLE "Host"
RENAME COLUMN host_url TO url;

ALTER TABLE "Host" 
RENAME COLUMN host_name TO name;

ALTER TABLE "Host" 
RENAME COLUMN host_since TO since;

ALTER TABLE "Host" 
RENAME COLUMN host_location TO location;

ALTER TABLE "Host" 
RENAME COLUMN host_about TO about;

ALTER TABLE "Host" 
RENAME COLUMN host_response_time TO response_time;

ALTER TABLE "Host" 
RENAME COLUMN host_response_rate  TO responce_rate;

ALTER TABLE "Host" 
RENAME COLUMN host_acceptance_rate TO acceptance_rate;

ALTER TABLE "Host" 
RENAME COLUMN host_is_superhost TO is_superhost;

ALTER TABLE "Host" 
RENAME COLUMN host_thumbnail_url TO thumbnail_url;

ALTER TABLE "Host" 
RENAME COLUMN host_picture_url TO picture_url;

ALTER TABLE "Host" 
RENAME COLUMN host_neighbourhood TO neighbourhood;

ALTER TABLE "Host" 
RENAME COLUMN host_listings_count TO listings_count;

ALTER TABLE "Host" 
RENAME COLUMN host_total_listings_count TO total_listings_count;

ALTER TABLE "Host" 
RENAME COLUMN host_verifications TO verifications;

ALTER TABLE "Host" 
RENAME COLUMN host_has_profile_pic TO has_profile_pic;

ALTER TABLE "Host" 
RENAME COLUMN  host_identity_verified TO identity_verified;

ALTER TABLE "Host" 
RENAME COLUMN calculated_host_listings_count TO calculated_listings_count;




ALTER TABLE "Listings" 
DROP COLUMN host_url;

ALTER TABLE "Listings" 
DROP COLUMN host_name;

ALTER TABLE "Listings"  
DROP COLUMN host_since;

ALTER TABLE"Listings"  
DROP COLUMN host_location;

ALTER TABLE "Listings"  
DROP COLUMN host_about;

ALTER TABLE "Listings"  
DROP COLUMN host_response_time;

ALTER TABLE "Listings" 
DROP COLUMN host_response_rate;

ALTER TABLE "Listings" 
DROP COLUMN host_acceptance_rate;

ALTER TABLE "Listings" 
DROP COLUMN host_is_superhost;

ALTER TABLE "Listings" 
DROP COLUMN host_thumbnail_url;

ALTER TABLE "Listings" 
DROP COLUMN host_picture_url;

ALTER TABLE "Listings" 
DROP COLUMN host_neighbourhood;

ALTER TABLE "Listings" 
DROP COLUMN host_listings_count;

ALTER TABLE "Listings" 
DROP COLUMN host_total_listings_count;

ALTER TABLE "Listings" 
DROP COLUMN host_verifications;

ALTER TABLE "Listings" 
DROP COLUMN host_has_profile_pic;

ALTER TABLE "Listings" 
DROP COLUMN host_identity_verified;

ALTER TABLE "Listings"  
DROP COLUMN calculated_host_listings_count;





ALTER TABLE "Host" 
RENAME COLUMN responce_rate TO response_rate;




CREATE TABLE "kappa2" AS
SELECT 
    Distinct (id),url, name, since, location, about,
response_time, response_rate, acceptance_rate, is_superhost,
thumbnail_url, picture_url, neighbourhood, listings_count,
total_listings_count, verifications, has_profile_pic, identity_verified,
calculated_listings_count
FROM
    "Host";

DROP TABLE "Host" ;
ALTER TABLE "kappa2" RENAME TO "Host";



ALTER TABLE "Host" ADD PRIMARY KEY (id);


ALTER TABLE "Listings"
ADD CONSTRAINT constraint_fk3
FOREIGN KEY (host_id)
REFERENCES "Host"(id);