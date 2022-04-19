-- Script name: tests.sql
-- Author:     Drashti Shah
-- Purpose:     test sample data to test if the constraints are working in the  database system

USE Multimedia_Content_Management_DB;
SET SQL_SAFE_UPDATES = 0;

 -- -------------------------------------------Incorrect Fails in update/delete ------------------------------------------------
 -- DELETE FROM mailing_list_users WHERE mailing_list_users = 4;
 -- Comments: Typed mailing_list_users after where clause instead of mailing_list_id;
 
 --  UPDATE group_plan SET groups_plan_cost = 3 WHERE groups_plan_id = 2; 
 --  DELETE from groups_plan where groups_plan_cost = 3;
 -- comment: spelling  error

 --  DELETE FROM registereduser WHERE admin_registereduser_registerf_user_id = 11;
 -- Comments: Error Code: 1054. Unknown column 'admin_registereduser_registerf_user_id' in 'where clause' 
			-- : made a spelling mistake
            
-- DELETE account_account_id FROM basic where role_id = 1;
-- Comment :Error Code: 1109. Unknown table 'account_account_id' in MULTI DELETE
-- Tried to delete multiple tables

-- Update advertisements_linked_to SET basic_id = 3 WHERE advertisements_advertisements_id = 3;
-- Comment : spelling mistake, error in advertisements_advertisement_id;
  
-- SELECT * FROM bank_account;
-- UPDATE bank_account SET account_number = 123451001234 WHERE  payment_method_payment_method_id = 13;
-- Error Code: 1264. Out of range value for column 'account_number' at row 1

-- UPDATE credit_card SET credit_card_number = 115677777789 where credit_card_holder_name ="Nicholas Berry"; 
-- comment - out of bounds for cc_number;

-- UPDATE debit_card SET debit_card_number = 100143569874 WHERE debit_card_holder_name = 'Ken doll'; 
-- comment - out of bounds for dc_number;
  
-- UPDATE music SET music_release_year = 02 WHERE music_id = 1;
-- comment - no error but not doing anything essentially even though it is on cascade

-- UPDATE manifest_has_cdn SET manifest_manifest_id = 103 WHERE CDN_cdn_id = 1;
-- sql got confused due to duplicate entries and we weren't able to update the column

-- UPDATE published_music set publisher_publisher_id = 8 where publisher_music_id = 1;
--  SELECT * FROM published_music;
-- comment : copied the wrong table
            
-- update Basic_can_stream_music set basic_id = 23 where music_id = 2;
-- comment : incorrect table names

-- update profile set role_id = 15 where alias = 'tom';
-- comment next time add better testing query-- 

 -- ------------------------Working but logically incorrect --------------------------------------
-- SELECT * FROM registereduser;
-- UPDATE registereduser
-- SET r_name = 'Drashti', registered_user_id = 5;     
-- Comments: Missed the where clause and changed all the registered user name to the same name

-- update Basic_can_stream_podcast set Basic_basic_id = 2 WHERE podcast_podcast_id = 3;
-- SELECT * FROM Basic_can_stream_podcast;
-- comment :  Got updated in the primary key not keeping the column unique

 -- DELETE FROM account WHERE region_region_id = 5;
--  SELECT * FROM account;       
-- comment : it shouldn't change because delete was set to no action.

-- DELETE FROM bank_account WHERE payment_method_payment_id = 23; 
-- comment :  Unknown column 'payment_method_payment_id' in 'where clause', id is incorrectly written.

-- DELETE FROM premium_action where actions_action_id = 2;
-- SELECT * FROM premium_action;



-- -----------------WORKING -------------------------------------
UPDATE mailing_list_users 
SET generaluser_user_id = 5
WHERE mailing_list_mailing_id = 2; 
SELECT * FROM mailing_list_users;


DELETE FROM generaluser_has_messaging_list WHERE generaluser_user_id = 1;
UPDATE generaluser_has_messaging_list
SET messaging_list_messaging_id = 9 WHERE generaluser_user_id = 3;
SELECT * FROM generaluser_has_messaging_list;

 -- SELECT * FROM generaluser;
SELECT * FROM has_logged_from;
 DELETE FROM has_logged_from WHERE devices_device_id = 3;
UPDATE has_logged_from 
SET is_ip_validated = 3
WHERE devices_device_id = 2;
 
 SELECT * FROM registereduser;
 update registereduser SET has_logged_from_devices_device_id = 3 where registered_user_id = 9;
 
 SELECT * FROM admin;
Update admin SET registereduser_registered_user_id = 5 WHERE admin_id = 1;
DELETE FROM admin WHERE admin_id = 1;

  -- UPDATE account set region_region_id = 5 WHERE account_id = 2;

UPDATE account SET username = "Mike" where generaluser_user_id = 1;
 -- DELETE FROM account WHERE generaluser_user_id = 1;
 -- SELECT * FROM account;
 
 --   UPDATE account_has_role SET role_role_id = 3 WHERE account_account_id = 12;
 DELETE FROM account_has_role WHERE role_role_id = 3;
SELECT * FROM account_has_role; 

 --  SELECT * FROM account;
 -- DELETE FROM BASIC WHERE role_id = 1;
  
  --  SELECT * FROM basic;
 -- UPDATE basic SET basic_id = 5 WHERE account_account_id = 6;
 -- DELETE from basic where role_id = 2;
 
SELECT * FROM premium;
UPDATE premium SET premium_id = 5 WHERE account_account_id = 20;
DELETE from premium where role_id = 2;
 
 -- UPDATE basic SET basic_id = 5 WHERE account_account_id = 6;
 -- DELETE from basic where role_id = 2;
 
 -- SELECT * FROM advertisements_linked_to;
  DELETE from advertisements_linked_to WHERE advertisements_advertisement_id = 2;
 
SELECT * FROM advertisements_has_organization;
DELETE FROM advertisements_has_organization WHERE organization_organization_id = 1;
UPDATE advertisements_has_organization SET  organization_organization_id = 123455 where advertisements_advertisement_id = 2;

UPDATE paypal SET payment_method_payment_method_id = 9 WHERE paypal_id = 1;
DELETE FROM paypal WHERE email = "bob@gmail.com";
SELECT * FROM paypal;

SELECT * FROM credit_card;
DELETE from credit_card where payment_method_payment_method_id = 23;

SELECT * FROM debit_card;
 DELETE from debit_card where bank_account_account_number = 1001001235;

DELETE FROM CDN where region_region_id = 1;
UPDATE CDN SET region_region_id = 5 where cdn_id = 2;
SELECT * FROM CDN;

UPDATE Multimedia_Content_has_CDN SET CDN_cdn_id = 2 WHERE Multimedia_Content_cdn_id = 2;
DELETE FROM  Multimedia_Content_has_CDN WHERE CDN_cdn_id = 1;
SELECT * FROM Multimedia_Content_has_CDN;

SELECT * FROM podcast;
UPDATE podcast SET Multimedia_Content_cdn_id = 1 where podcast_id =1;


UPDATE audio_books SET audio_book_id = 23 WHERE Multimedia_Content_cdn_id = 2;
SELECT * FROM audio_books;

DELETE FROM published_podcast WHERE publisher_publisher_id = 3;
UPDATE published_podcast set publisher_publisher_id = 8 where published_podcast_id = 1;
 SELECT * FROM published_podcast;
 
 -- DELETE FROM published_music WHERE publisher_publisher_id = 3;



DELETE FROM published_podcast WHERE publisher_publisher_id = 3;
UPDATE published_podcast set publisher_publisher_id = 8 where published_podcast_id = 1;
 SELECT * FROM published_podcast;

UPDATE premium_action set actions_action_id = 3 where premium_premium_id = 1;


UPDATE student_plan SET student_plan_cost = 3 WHERE student_plan_id = 2; 
DELETE from student_plan where student_plan_cost = 3;
SELECT * FROM student_plan;

SELECT * FROM profile;
DELETE from profile where alias = 'tom';
DELETE FROM manifest_has_cdn WHERE CDN_cdn_id = 2;
SELECT * FROM manifest_has_cdn;
