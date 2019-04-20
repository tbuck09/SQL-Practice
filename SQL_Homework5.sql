USE sakila;

SHOW CREATE TABLE address;

CREATE TABLE IF NOT EXISTS address (
	address_id SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
    address VARCHAR(50) NOT NULL,
    address2 VARCHAR(50) DEFAULT NULL,
    district VARCHAR(20) NOT NULL,
    city_id SMALLINT(5) UNSIGNED NOT NULL,
    postal_code varchar(10) DEFAULT NULL,
    phone varchar(20) NOT NULL,
	location geometry NOT NULL,
	last_update timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`address_id`),
	KEY idx_fk_city_id (`city_id`),
	SPATIAL KEY idx_location (`location`),
	CONSTRAINT fk_address_city FOREIGN KEY (`city_id`) REFERENCES city (`city_id`) ON UPDATE CASCADE
) 
ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8