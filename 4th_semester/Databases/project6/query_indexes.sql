//1
CREATE INDEX Locationindex
ON "Location" (is_location_exact);

//2
CREATE INDEX Listingindex
ON "Listing"(number_of_reviews);

//3
CREATE INDEX Listingindex2
ON "Listing"(id,host_id);

//4
CREATE INDEX Locationindex
ON "Location" (is_location_exact);

//5

CREATE INDEX PriceIndex2
ON "Price"(security_deposit);

//6
CREATE INDEX HostIndex 
ON "Listing"(host_id);

//7
CREATE INDEX PriceIndex
ON "Price"(price);