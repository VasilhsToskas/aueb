CREATE TABLE "Price" AS
SELECT 
    "Listings".id, price, weekly_price, monthly_price,
	security_deposit, cleaning_fee,
	guests_included, extra_people, minimum_nights, maximum_nights,
	minimum_minimum_nights, maximum_minimum_nights,
	minimum_maximum_nights,
	maximum_maximum_nights, minimum_nights_avg_ntm,
	maximum_nights_avg_ntm
FROM
    "Listings","Room"
WHERE "Listings".id="Price".id;
	
	
ALTER TABLE "Listings" 
DROP COLUMN    cleaning_fee,
DROP COLUMN    guests_included,
DROP COLUMN    extra_people,
DROP COLUMN    minimum_nights,
DROP COLUMN    maximum_nights,
DROP COLUMN    minimum_minimum_nights,
DROP COLUMN    maximum_minimum_nights,
DROP COLUMN    minimum_maximum_nights,
DROP COLUMN    maximum_maximum_nights,
DROP COLUMN    minimum_nights_avg_ntm,
DROP COLUMN    maximum_nights_avg_ntm;



ALTER TABLE "Price" ADD PRIMARY KEY (id);

ALTER TABLE "Price"
ADD CONSTRAINT constraint_fk
FOREIGN KEY (id)
REFERENCES "Listings"(id);



UPDATE "Price" SET  price= replace(price, '$', '');
UPDATE "Price" SET  weekly_price= replace(weekly_price, '$', '');
UPDATE "Price" SET  monthly_price= replace(monthly_price, '$', '');
UPDATE "Price" SET  security_deposit= replace(security_deposit, '$', '');
UPDATE "Price" SET  cleaning_fee= replace(cleaning_fee, '$', '');
UPDATE "Price" SET  extra_people= replace(extra_people, '$', '');




UPDATE "Price" SET  price= replace(price, ',', '');
UPDATE "Price" SET  weekly_price= replace(price, ',', '');
UPDATE "Price" SET  monthly_price= replace(price, ',', '');
UPDATE "Price" SET  security_deposit= replace(price, ',', '');
UPDATE "Price" SET  cleaning_fee= replace(price, ',', '');
UPDATE "Price" SET  extra_people= replace(price, ',', '');



ALTER TABLE "Price" ALTER COLUMN price TYPE numeric(10,2) USING price::numeric(10,2);
ALTER TABLE "Price" ALTER COLUMN weekly_price TYPE numeric(10,2) USING weekly_price::numeric(10,2);
ALTER TABLE "Price" ALTER COLUMN monthly_price TYPE numeric(10,2) USING monthly_price::numeric(10,2);
ALTER TABLE "Price" ALTER COLUMN security_deposit TYPE numeric(10,2) USING security_deposit::numeric(10,2);
ALTER TABLE "Price" ALTER COLUMN cleaning_fee TYPE numeric(10,2) USING cleaning_fee::numeric(10,2);
ALTER TABLE "Price" ALTER COLUMN extra_people TYPE numeric(10,2) USING extra_people::numeric(10,2);
ALTER TABLE "Price" ALTER COLUMN minimum_nights_avg_ntm TYPE numeric(10,1) USING minimum_nights_avg_ntm::numeric(10,1);
ALTER TABLE "Price" ALTER COLUMN maximum_nights_avg_ntm TYPE numeric(10,1) USING maximum_nights_avg_ntm::numeric(10,1);

ALTER TABLE "Price" 
RENAME COLUMN id TO listing_id;