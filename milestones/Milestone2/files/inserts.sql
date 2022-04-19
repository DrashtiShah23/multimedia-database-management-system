-- Script name: inserts.sql
-- Author:     Drashti Shah
-- Purpose:     insert sample data to test the integrity of this database system
   
-- the database used to insert the data into.
USE Multimedia_Content_Management_DB;

SET FOREIGN_KEY_CHECKS=0;
 -- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`db_mmdb_m2`.`account`, CONSTRAINT `fk_account_region1` FOREIGN KEY (`region_region_id`) REFERENCES `region` (`region_id`))
 --  got this error, so set checking of Fk = 1 on the top!
 
-- -------------------- general user-----------------------
-- Truncate table generaluser;
INSERT INTO generaluser(guest_name,email) VALUES ('bob', 'bob@gmail.com'), ('mary', 'mary@gmail.com'), ('stark', 'tonystark@yahoo.com');
-- SELECT * FROM generaluser;
--  
-- INSERT INTO generaluser(guest_name, email) VALUES ('pika', 'bob@gmail.com');  ----> Throws error : UNIQUE KEY FOR EMAIL WORKS!


-- -----------------account-----------------------------
 

INSERT INTO account(username, user_password, expires_on, region_region_id, generaluser_user_id) 
 VALUES ('bob123', 1234, str_to_date("4/19/2025", "%m/%d/%Y"), 1, 1);
  
 INSERT INTO account(username, user_password, expires_on, region_region_id, generaluser_user_id) 
 VALUES  ('mary123', 123, str_to_date("7/29/2029", "%m/%d/%Y"), 1, 2);
 
INSERT INTO account(username, user_password, expires_on, region_region_id, generaluser_user_id) 
 VALUES ('glen12', 56678, str_to_date("3/29/2025", "%m/%d/%Y"), 1, 3);

-- SELECT * FROM account;

-- ------------------------------------account_has_role-------------------------------------------------------
INSERT INTO account_has_role(account_account_id, role_role_id) VALUES (12, 1), (7, 2), (15, 1);
-- SELECT * FROM account_has_role;


--  -------------------------actions -------------------------------
-- SELECT * FROM actions;
INSERT INTO actions(action_id, action_name)  VALUES (1, 'stream'), (2, 'download'), (3, 'stream and download');

-- TRUNCATE TABLE registereduser;
-- SELECT * FROM registereduser;
INSERT INTO registereduser(registered_user_id, r_name, admin_registereduser_registered_user_id, generaluser_user_id, has_logged_from_devices_device_id)
VALUES (1, 'elaine', 2, 1, 1);

INSERT INTO registereduser(registered_user_id, r_name, admin_registereduser_registered_user_id, generaluser_user_id, has_logged_from_devices_device_id)
 VALUES (1, 'beca', 3, 6, 1);

INSERT INTO registereduser(registered_user_id, r_name, admin_registereduser_registered_user_id, generaluser_user_id, has_logged_from_devices_device_id)
 VALUES (9, 'dhruv', 11, 11, 0);

------------------------ admin ---------------------------------
INSERT INTO admin(permission_id, admin_name, registereduser_registered_user_id, generaluser_user_id) VALUES (29, 'elope', 23, 12);
INSERT INTO admin(permission_id, admin_name, registereduser_registered_user_id, generaluser_user_id) VALUES (31, 'frank', 27, 32);

-- -- SELECT * FROM admin;

-- ---------------------------------advertisements ------------------------------------------
INSERT INTO advertisements(advertisement_id, advertisement_name) VALUES (1,"Spotify"), (2,"hollister"), (3,"Ck");

-- SELECT * FROM advertisements;


-- --------------------------advertisements_has_organization--------------------------------------------------
INSERT INTO advertisements_has_organization(advertisements_advertisement_id, organization_organization_id) VALUES (1,1), (2,2), (3,3);
--  SELECT * FROM advertisements_has_organization;

-- ---------------------------advertisements_has_promotions------------------------------------------------------
INSERT INTO advertisements_has_promotions(advertisements_advertisement_id, promotions_promotion_id) VALUES (1,5), (2,6), (3,7);
-- SELECT * FROM advertisements_has_promotions;



-- -------------------------------advertisements_linked_to-------------------------------------------------------------

-- SELECT * FROM advertisements_linked_to;
 INSERT INTO advertisements_linked_to(Basic_basic_id, advertisements_advertisement_id) VALUES (1,1), (2,2), (3,3);


-- ------------------------------audio_books --------------------------------------------------------------------
--  SELECT *  FROM audio_books;
INSERT INTO audio_books(audio_book_id, audio_book_name, audio_book_duration, Multimedia_Content_cdn_id, audiobook_release_date)
VALUES (1, "wings of fire", TIME("00:30:10"), 1, str_to_date("4/19/2017", "%m/%d/%Y"));
 
 INSERT INTO audio_books(audio_book_id, audio_book_name, audio_book_duration, Multimedia_Content_cdn_id, audiobook_release_date)
VALUES (2, "Red, white and Royal Blue", TIME("01:40:10"), 1, str_to_date("7/23/2019", "%m/%d/%Y")),
 (3, "One by One", TIME ("02:10:45"), 2, str_to_date("06/09/2016", "%m/%d/%Y"));



-- --------------------------------authors -------------------------------------------------------------------------
-- SELECT * FROM authors;
INSERT INTO authors(author_id, author_name, author_description) 
VALUES (1, "A. P. J Kalam", "Rocket Scientist...wrote exemplary books"), 
(2, "Stephen Fry", "Wrote about Sherlock holmes"),
(3, "Ruth Ware", "NY best seller author!");


-- ---------------------------- bank_account ------------------------------------------------------------------

INSERT INTO bank_account(account_number, routing_number, acc_holder_name, bank_name, payment_method_payment_method_id)
VALUES (1001001234, 699988877, 'John Doe', 'Chase', 12),
(1002001234, 688877766, 'Jane Doe' , 'Bank of America', 23),
(1003001234, 677766655, 'Karen Doe', 'Wells Fargo', 45 );
-- SELECT * FROM bank_account;


-- ---------------------------------basic ------------------------------------------------------------------------
INSERT INTO basic(basic_id, account_account_id, role_id) 
VALUES (6, 6, 2),
(2, 2, 1),
(4,4,2);
-- SELECT  * FROM basic;

-- SELECT * FROM premium;
INSERT INTO premium(premium_id, role_id, account_account_id) VALUES  (20, 1, 20), (21,2,21), (22,3,22);
-- ---------------------------------basic_can_stream_music ------------------------------------------------------------------------
-- SELECT * FROM basic_can_stream_music;
 INSERT INTO basic_can_stream_music(Basic_basic_id, music_music_id) VALUES (1,1), (2,2), (3,3);

-- ---------------------------------basic_can_stream_podcast ------------------------------------------------------------------------
--  SELECT * FROM basic_can_stream_podcast;
INSERT INTO basic_can_stream_podcast(Basic_basic_id, podcast_podcast_id) VALUES (1,1), (2,2), (3,3);



-- -----------------------------------cdn------------------------------------------------------------------------
-- SELECT * FROM cdn;
 INSERT INTO cdn(cdn_id, manifest_id, region_region_id) VALUES (1, 1, 1), (2,2,2), (3,3,3);



-- ---------------------------------credit_card------------------------------------------------------------------------
INSERT INTO credit_card(credit_card_number, credit_card_holder_name, CVV, zipcode, expiration_date, payment_method_payment_method_id)
VALUES (00112146, 'Nicholas Berry' , 123, 94132, str_to_date("7/29/2029", "%m/%d/%Y"), 12),
(001039012, 'Min Cheng' , 946, 95126, str_to_date("5/20/2024", "%m/%d/%Y"),23),
(0010003412, 'Lyla Johnson' , 789, 94112, str_to_date("9/14/2025", "%m/%d/%Y"),45);
-- SELECT * FROM credit_card;


-- ---------------------------------debit_card------------------------------------------------------------------------
INSERT INTO debit_card(debit_card_number, expiration_date, CVV, debit_card_holder_name, bank_account_account_number)
VALUES (00223344, str_to_date("1/16/2024", "%m/%d/%Y"), 789, 'Ben Mu',1001001235 ), 
(00334455, str_to_date("2/17/2025", "%m/%d/%Y"), 438, 'Ken doll',1009001234 ),
(01997564,str_to_date("3/18/2026", "%m/%d/%Y"), 903, 'Ruth Mancha',1001001839 );
-- SELECT * FROM debit_card;


-- --------------------------------devices------------------------------------------------------------------------
-- SELECT * FROM devices;
 INSERT INTO devices(device_id, device_ip, account_id) VALUES (1, "123.12.234", 1),(2, "124.56.7891", 1),(3, "123.456.6789",3);


-- ---------------------------------generaluser_has_messaging_list-----------------------------------------------------------------------
--  SELECT * FROM generaluser_has_messaging_list;
INSERT INTO generaluser_has_messaging_list(generaluser_user_id, messaging_list_messaging_id) VALUES (1, 1),(2,2),(3,4);

-- ---------------------------------MAILING_LIST_USERS-----------------------------------------------------------------------

 INSERT INTO mailing_list_users(generaluser_user_id, mailing_list_mailing_id) VALUES (1, 1),(2,2),(3,4);
-- SELECT * FROM mailing_list_users;


-- ---------------------------------group_plan-----------------------------------------------------------------------
 INSERT INTO group_plan(group_plan_id, premium_premium_id)
 VALUES (1, 5), (2, 7), (3, 12);

  -- SELECT * FROM group_plan;


-- ---------------------------------student_plan-----------------------------------------------------------------------
INSERT INTO student_plan(student_plan_id, premium_premium_id)
 VALUES (1, 8), (2, 9), (3, 14);
--  SELECT * FROM student_plan;



-- ---------------------------------has_logged_from-----------------------------------------------------------------------
 INSERT INTO has_logged_from(is_ip_validated, devices_device_id) VALUES (1,1), (0,2), (1,3); 
  -- SELECT * FROM has_logged_from;
 


-- ---------------------------------individual_plan----------------------------------------------------------------------
INSERT INTO individual_plan(individual_plan_id, premium_premium_id)
VALUES (1, 4), (2, 2), (3, 1);
--  SELECT * FROM individual_plan;




-- ---------------------------------mailing_list-----------------------------------------------------------------------
 INSERT INTO mailing_list(mailing_id, email) VALUES (1, 'bob@gmail.com'),(5, 'claire@gmail.com'),(19, 'dhruv@mail.com');
--  SELECT * FROM mailing_list;


-- ---------------------------------mailing_list_users-----------------------------------------------------------------------
 -- SELECT * FROM mailing_list_users


-- ---------------------------------messaging_list-----------------------------------------------------------------------
  INSERT INTO messaging_list(messaging_id, phone_number) Values (1, 6281234566), (2, 7654321778), (3, 1234567899);
--  SELECT * FROM  messaging_list;
 

-- ---------------------------------messaging_list_users-----------------------------------------------------------------------

 -- SELECT * FROM generaluser_has_messaging_list;

-- ---------------------------------manifest-----------------------------------------------------------------------
 INSERT INTO manifest(manifest_id, region) VALUES (1, 'US'), (2, 'CANADA'), (3, 'INDIA');
-- SELECT * FROM manifest; 



-- ---------------------------------manifest_has_cdn-----------------------------------------------------------------------
 INSERT INTO manifest_has_cdn(manifest_manifest_id, CDN_cdn_id) VALUES (1, 1), (2,1), (3,2);
-- SELECT * FROM manifest_has_cdn;


-- ---------------------------------multimedia_content-----------------------------------------------------------------------
  INSERT INTO multimedia_content(cdn_id, premium_actions) VALUES (1, 2), (2, 1), (3,3);
-- SELECT * FROM multimedia_content;


-- ---------------------------------multimedia_content_has_authors-----------------------------------------------------------------------
INSERT INTO multimedia_content_has_authors(Multimedia_Content_cdn_id, authors_author_id)
VALUES (1, 4), (1,6), (1,7);
-- SELECT * FROM multimedia_content_has_authors;

-- ---------------------------------multimedia_content_has_cdn-----------------------------------------------------------------------
  INSERT INTO multimedia_content_has_cdn(Multimedia_Content_cdn_id, CDN_cdn_id)
  VALUES (1, 1), (2,1), (3,3);
 --  SELECT * FROM multimedia_content_has_cdn;


-- ---------------------------------multimedia_tracker-----------------------------------------------------------------------
INSERT INTO multimedia_tracker(tracker_id, author_id, date_time)
VALUES (1,1, '2021-05-08 12:35:00'),
(2,2,'2022-01-08  16:20:10'),
(3,3,'2021-05-08 18:05:35');
-- SELECT * FROM multimedia_tracker;



-- ---------------------------------music-----------------------------------------------------------------------
 INSERT INTO music(music_id, music_title, duration, Multimedia_Content_cdn_id, music_author_name, music_release_year)
 VALUES (1, "The Real Slim Shady", '00:04:30', 1, 'Andre R. Young', 2000),
 (2, "In the End", '00:03:36', 1, 'Chester Bennington', 2000),
 (3, "Money", '00:06:22', 2, 'Roger Wasters', 1973);
--  SELECT * FROM music;



-- ---------------------------------organization-----------------------------------------------------------------------
INSERT INTO organization(organization_id, organization_name, organization_contact_num, description)
VALUES (1, 'Apple', 4155377153, 'Founded in 1976'), 
		(2, 'Comcast', 2204153082, 'largest global media companiy '),
        (3, 'Sony', 6466208944, 'music giant');
-- SELECT * FROM organization;

-- ---------------------------------payment_method-----------------------------------------------------------------------
INSERT INTO payment_method(payment_method_id, account_id, payment_amount, payment_type)
VALUES (1,1, 10, 1), (2,5, 20, 2), (3,8,5, 3 );
--  SELECT * FROM payment_method;



-- ---------------------------------paypal-----------------------------------------------------------------------
  INSERT INTO paypal(paypal_id, email, payment_method_payment_method_id)
  VALUES (1, 'bob@gmail.com', 3), (2, 'ethan@mail.com', 16), (3, 'lyla@gmail.com', 21);
--   SELECT * FROM paypal;




-- ---------------------------------podcast-----------------------------------------------------------------------
INSERT INTO podcast(podcast_id, podcast_title, Multimedia_Content_cdn_id)
VALUES (1, 'Crime Junkie', 1), (2, 'Deepwater Horizon Pt. 1', 1), (3, 'Up All Night', 2); 
-- SELECT * FROM podcast;


-- ---------------------------------premium_action-----------------------------------------------------------------------
INSERT INTO premium_action(premium_premium_id, Multimedia_Content_cdn_id, actions_action_id, premium_action_name)
Values (1, 1, 1, "stream"), (2,1,2, "download"), (3, 2, 3, "stream and download");
-- SELECT * FROM premium_action;
-- ---------------------------------premium_action_has_multimedia_tracker-----------------------------------------------------------------------
INSERT INTO premium_action_has_multimedia_tracker(premium_action_premium_premium_id, multimedia_tracker_tracker_id) 
VALUES (1, 1) , (2, 425), (56, 725);
--  SELECT * FROM premium_action_has_multimedia_tracker;


-- ---------------------------------premium_has_payment_method-----------------------------------------------------------------------
INSERT INTO premium_has_payment_method(premium_premium_id, payment_method_payment_method_id) 
VALUES (1, 1), (2,2), (3, 214);
-- SELECT * FROM premium_has_payment_method;

-- ---------------------------------profile-----------------------------------------------------------------------
-- SELECT * FROM profile;
INSERT INTO profile(role_id, alias, group_plan_group_plan_id)
VALUES (11, 'tom', 12 ), (15, 'bob', 18), (31, 'alia',54 );

-- ---------------------------------promotions-----------------------------------------------------------------------
  INSERT INTO promotions(promotion_id, promotion_title) VALUES (1, "HAPPY FRIDAY"), (2, "BOGO"), (3, "30% OFF");
-- SELECT * FROM promotions;


-- ---------------------------------published_audiobooks-----------------------------------------------------------------------

 -- SELECT * FROM published_audiobooks;

-- ---------------------------------published_music-----------------------------------------------------------------------
  INSERT INTO published_music(music_id, publisher_publisher_id) VALUES (1, 2), (3,2), (5, 3);
--  SELECT * FROM published_music
 

-- ---------------------------------published_podcast-----------------------------------------------------------------------
 INSERT INTO published_podcast(published_podcast_id, publisher_publisher_id, podcast_podcast_id) VALUES (1, 1, 1) ,(2,2,2), (3,3,3);
-- SELECT * FROM published_podcast;


-- ---------------------------------publisher-----------------------------------------------------------------------
INSERT INTO publisher(publisher_id, publisher_name)
 VALUES (1, 'Prince'), (2, 'MacLauren'), (3, 'commons');
-- SELECT * FROM publisher;


-- ---------------------------------region-----------------------------------------------------------------------
INSERT INTO region(region_id, region_name, device_id, country_code, cdn_id)
VALUES (1, 'US', 1, '+1', 1),(2, 'CANADA', 2, '+1' ,2 ),(3, 'INDIA', 3, '+91', 3);
--  SELECT * FROM region;


-- ---------------------------------published_audiobooks-----------------------------------------------------------------------
 INSERT INTO published_audiobooks(published_audiobooks_id, publisher_publisher_id, audio_books_audio_book_id)
 VALUES (1, 1, 1),(2,2,2),(3,1,4);
--  SELECT * FROM published_audiobooks


-- ---------------------------------role-----------------------------------------------------------------------
  INSERT INTO role(role_id, admin_id) VALUES (1, 1), (2,2), (3,3);
--  SELECT * FROM role;
 
























