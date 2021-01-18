UPDATE "Calendar" SET  price= replace(price, '$', '');
UPDATE "Calendar" SET  adjusted_price= replace(adjusted_price, '$', '');

UPDATE "Calendar" SET  price= replace(price, ',', '');
UPDATE "Calendar" SET  adjusted_price= replace(adjusted_price, ',', '');

ALTER TABLE "Calendar" ALTER COLUMN price TYPE numeric(10,2) USING price::numeric(10,2);
ALTER TABLE "Calendar" ALTER COLUMN adjusted_price TYPE numeric(10,2) USING adjusted_price::numeric(10,2);

ALTER TABLE "Calendar" ALTER COLUMN available TYPE BOOLEAN ;