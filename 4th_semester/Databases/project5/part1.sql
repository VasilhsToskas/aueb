CREATE TABLE "Amenities" AS
SELECT listing_id,regexp_split_to_table("Room".amenities, ',')
FROM "Room";



ALTER TABLE "Amenities" 
RENAME COLUMN regexp_split_to_table TO amenity_name;



UPDATE "Amenities" SET  amenity_name= replace(amenity_name, '}', '');
UPDATE "Amenities" SET  amenity_name= replace(amenity_name, '{', '');
UPDATE "Amenities" SET  amenity_name= replace(amenity_name, '"', '');

CREATE TABLE "Amenity"(
   amenity_id SERIAL PRIMARY KEY,
   amenity_name VARCHAR(50)
);


INSERT INTO "Amenity"(amenity_name)
SELECT DISTINCT(amenity_name) FROM "Amenities" ;






ALTER TABLE "Room"
DROP COLUMN amenities;





ALTER TABLE "Amenity"
ADD CONSTRAINT constraint_name UNIQUE (amenity_name);

ALTER TABLE "Amenities"
ADD CONSTRAINT constraint_fk
FOREIGN KEY (listing_id)
REFERENCES "Room"(listing_id);

ALTER TABLE "Amenities"
ADD CONSTRAINT constraint_fk1
FOREIGN KEY (amenity_name)
REFERENCES "Amenity"(amenity_name);


ALTER TABLE "Geolocation" ADD PRIMARY KEY(properties_neighbourhood);
