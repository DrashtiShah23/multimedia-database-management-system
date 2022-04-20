USE Multimedia_Content_Management_DB; 
SET foreign_key_checks = 0;

DELIMITER $$
CREATE TRIGGER trigger_insert AFTER INSERT ON account
    FOR EACH ROW
		BEGIN 
				INSERT INTO account VALUES (new.account_id);
		END $$
DELIMITER ; 

DELIMITER $$

CREATE TRIGGER before_advertisement_update BEFORE UPDATE ON advertisements
    FOR EACH ROW
		BEGIN 
				INSERT INTO advertisements
                SET advertisement_id = 5,
                advertisement_name = OLD.advertisement_name;
		END $$
DELIMITER ;



 
