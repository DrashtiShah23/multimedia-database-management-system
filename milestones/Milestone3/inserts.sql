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
INSERT INTO generaluser(guest_name,email) VALUES ('thomas', 't123@gmail.com'),('jose', 'j@gmail.com'),('kiki', 'kiki@gmail.com'),('kyle','kyle@gmail.com'),('sammy','sobeid@gmail.com'),
('ryan','r@gmail.com'),('kim','kim123@gmail.com'),('anaira','anaira12@gmail.com');
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

-- ---------------------- admin ---------------------------------
INSERT INTO admin(permission_id, admin_name, registereduser_registered_user_id, generaluser_user_id) VALUES (29, 'elope', 23, 12);
INSERT INTO admin(permission_id, admin_name, registereduser_registered_user_id, generaluser_user_id) VALUES (31, 'frank', 27, 32);

-- -- SELECT * FROM admin;

-- ---------------------------------advertisements ------------------------------------------
INSERT INTO advertisements(advertisement_id, advertisement_name, advertisement_date) VALUES (1,"Spotify", '2021-01-22'), (2,"hollister",'2022-07-12'), (3,"Ck",'2021-06-13'), 
(4, "Exclaim LLC", '2022-01-19'), (7, "Jump Tap, Inc.", '2022-07-23'), (10, "Capstone", '2020-01-22'), (13, "In Design", '2019-01-22'),
(5, "Taktical Digital", '2019-08-01'), (8, "Latin Works", '2018-07-16'), (11, "Chatter Buzz", '2019-08-23'), (14, "EUKU Agency", '2018-08-23'),  
(6, "Blue Fountain Media", '2021-09-15'), (9, "Where Is My Brand", '2020-05-29'), (12, "Share Your Story", '2021-08-23'), (15, "Ironpaper", '2018-01-22');
INSERT INTO advertisements(advertisement_id, advertisement_name, advertisement_date) VALUES (16, "PBJ Trades", '2018-02-23'), (17, "Vividly Marketing", '2017-05-22'),
(18, "Motion Pictures", '2018-06-22'), (19, "The Bold Choice", '2019-07-22'), (20, "Essie Electronics", '2020-08-22');
SELECT * FROM advertisements;


-- --------------------------advertisements_has_organization--------------------------------------------------
INSERT INTO advertisements_has_organization(advertisements_advertisement_id, organization_organization_id) VALUES (1,1), (4,1), (5,1), (8,1),(10,1);
INSERT INTO advertisements_has_organization(advertisements_advertisement_id, organization_organization_id) VALUES (2,2), (6,2), (9,2), (13,2),(15,2) ;
INSERT INTO advertisements_has_organization(advertisements_advertisement_id, organization_organization_id) VALUES  (3,3), (7,3), (11,3), (12,3),(14,3);


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
 
 INSERT INTO mailing_list_users(generaluser_user_id, mailing_list_mailing_id) VALUES (4,3),(5,5),(6,6),(7,7),(8,8);
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
  SELECT * FROM mailing_list_users;


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
--  INSERT INTO music(music_id, music_title, duration, Multimedia_Content_cdn_id, music_author_name, music_release_year)
--  VALUES (1, "The Real Slim Shady", '00:04:30', 1, 'Andre R. Young', 2000),
--  (2, "In the End", '00:03:36', 1, 'Chester Bennington', 2000),
--  (3, "Money", '00:06:22', 2, 'Roger Wasters', 1973);

INSERT INTO music_tracks(music_id, music_title, duration, Multimedia_Content_cdn_id, music_artist, music_album, music_genre, music_track_rating, year)
VALUES(1, "The Real Slim Shady", '00:04:30',1, 1, 1, 1, 4, 2000),
(2, "In the End", '00:03:36', 1, 2, 2, 1, 5,2005 ),
(3, "Money", '00:06:22', 2, 3, 3, 2, 4, 1995 ),
(4, "Bury a Friend", '00:02:40', 2, 4, 4, 4, 5, 1984),
(5, 'Lovely', '00:01:50', 2, 4, 4, 4, 5, 1985),
(6, 'Copy cat', '00:05:20',2, 4, 4, 4 , 4, 1990 ),
(7, 'Ironic', '00:04:25', 1, 5, 5, 3, 3, 1995 ),
(8, 'Feel your love', '00:02:48', 1, 5, 5, 2, 3, 1995);
INSERT INTO music_tracks(music_id, music_title, duration, Multimedia_Content_cdn_id, music_artist, music_album, music_genre, music_track_rating, year)
VALUES(24, "Taki Taki", '00:04:30',1, 4, 1, 1, 4, 2021);

INSERT INTO music_tracks(music_id, music_title, duration, Multimedia_Content_cdn_id, music_artist, music_album, music_genre, music_track_rating, year)
VALUES(9, 'Superman' , '00:04:30',1, 1, 1, 1, 1, 2005),(10, 'Just by my own' , '00:04:30',1, 1, 1, 1, 3, 2010), (11, 'All or nothing' , '00:04:30',1, 1, 1, 1, 2, 2015), (12, 'Perfect' , '00:04:30',1, 1, 1, 1, 5, 2007), 
(13, "Donation", '00:03:36', 1, 2, 2, 1, 4, 2015 ),(14, "Bad Religion", '00:03:36', 1, 2, 2, 1, 3, 2020 ), (15, "Oops", '00:03:36', 1, 2, 2, 1, 2, 2007 ), (16, "Danger", '00:03:36', 1, 2, 2, 1, 1, 2009),
(17, "Wish you were here", '00:06:22', 2, 3, 3, 2, 5, 2010),(18, "Time", '00:06:22', 2, 3, 3, 2, 4, 2008),(19, "Comfortably Numb", '00:06:22', 2, 3, 3, 2, 3, 2009),
(20, "Another Brick in the Wall", '00:06:22', 2, 3, 3, 2, 2, 2021), (21, 'Night Changes', '00:04:25', 1, 5, 5, 3, 3, 2012 ),(22, 'Story of my life', '00:04:25', 1, 5, 5, 3, 3, 2015),
(23, 'Drag Me Down', '00:04:25', 1, 5, 5, 3, 3, 2008);
 


SELECT * FROM music_tracks;

SELECT * FROM music_artist;
INSERT INTO music_artist(music_artist_id, music_artist_name) VALUES (1, 'Eminem'), (2, 'Chester Bennigton'), (3, 'Pink Floyd'), (4, 'AC/DC'), (5, 'Billie Ellish');

SELECT * FROM music_genre;
INSERT INTO music_genre(music_genre_id, description) VALUES (1, 'Rock');
INSERT INTO music_genre (music_genre_id, description) VALUES (2, 'Jazz');
INSERT INTO music_genre (music_genre_id, description) VALUES (3, 'Metal');
INSERT INTO music_genre (music_genre_id, description) VALUES (4, 'Alternative & Punk');
INSERT INTO music_genre (music_genre_id, description) VALUES (5, 'Rock And Roll');
INSERT INTO music_genre (music_genre_id, description) VALUES (6, 'Blues');
INSERT INTO music_genre (music_genre_id, description) VALUES (7, 'Latin');
INSERT INTO music_genre (music_genre_id, description) VALUES (9, 'Pop');
INSERT INTO music_genre (music_genre_id, description) VALUES (10, 'Dance & Electronic');

SELECT * FROM music_artist;
SELECT * FROM music_album;
INSERT INTO  music_album ( music_album_id, tile, year_released, artist_id) VALUES (1, 'Do not smile at me', 2019,1);
INSERT INTO  music_album ( music_album_id, tile, year_released,artist_id) VALUES (2, 'Alanis',1993,4), (3, 'Jagged Little Pill', 1995,2);
INSERT INTO  music_album ( music_album_id, tile, year_released,artist_id) VALUES (4, 'fly on the wall', 1994,3);
INSERT INTO  music_album ( music_album_id, tile, year_released,artist_id) VALUES (5, 'Objection overruled',1993, 1), (6, 'Death Row', 1996, 4);
INSERT INTO  music_album ( music_album_id, tile, year_released,artist_id) VALUES (7,'Check to check', 1975,5);
INSERT INTO  music_album ( music_album_id, tile, year_released,artist_id) VALUES (8,'Kamikaze', 2018,1), (9,'The Marshall Mathers LP', 2000,1), 
(10,'Recovery', 2010,1), (11,'Curtain Call', 2005,1), (12,'The Slim Shady', 1999,1),(13,'Encore', 2004,1);
INSERT INTO  music_album ( music_album_id, tile, year_released,artist_id) VALUES (14, 'Back in Black', 1994 ,4), (15, 'Iron Man 2', 2010 ,4), (16, 'High Voltage', 1997 ,4),
(17, 'Highway to Hell', 1996 ,4), (18, 'Shot in the dark', 1980 ,4);
INSERT INTO  music_album ( music_album_id, tile, year_released,artist_id) VALUES (19, 'Hybrid Theory',2000,2), (20, 'Meteora', 2003,2), (21, 'Minutes to Midnight', 2007,2), 
(22, 'One More Light', 2017,2), (23, 'New Divide', 2009,2), (24, 'We Made It', 2008,2), (25, 'Living Things', 2012,2), (26, 'Not Alone', 2011,2),
 (27, 'Recharged', 2013,2), (28, 'Heavy', 2017,2), (29, 'The Catalyst', 2010,2);
INSERT INTO  music_album ( music_album_id, tile, year_released,artist_id) VALUES (30, 'The Wall',1990 ,3), (31, 'Pulse',1995 ,3), (32, 'Meddle',2020 ,5), (33, 'Relics',1998 ,5), 
(34, 'Atom Heart Mother',2000 ,3), (35, 'The Endless River',2014 ,3); 
INSERT INTO  music_album ( music_album_id, tile, year_released,artist_id) VALUES (36, 'Remain in Light', 1999 ,1), (37, 'She so Unusual', 1993, 1), (38, 'Happier Than Ever',2021 , 5), (39, 'The Division Bell', 2000, 3),
(40, 'Echoes', 2001, 3), (41, 'Box Set', 2002, 4), (42, 'When we fall Asleep', 2002, 5), (43, 'Bellyache', 2003, 5), (44, 'Oxytocin', 2006, 5), (45, 'Your power', 2006, 5), 
(46, 'Shady Classics', 2014, 1), (47, 'XV' ,2014, 1), (48, 'Kings Never Die', 2015, 1), (49, 'Bad Guy', 2015, 5) , (50, 'Ocean Eyes', 2016, 5), (51, 'Male Fantasy', 2022, 5);


-- ----------------------------------------------------album_rating------------------------------------------
SELECT * FROM album_rating;
insert into album_rating(mid, stars, year) values(1, 5, 2019), (2, 4, 2017),(3, 5, 2018),(4, 5, 2015),(5, 1, 2016);
insert into album_rating(mid, stars, year) values(6, 4, 2016), (7, 3, 2016),(8, 4, 2018),(9, 5, 2019),(10, 4, 2015);
insert into album_rating(mid, stars, year) values(11, 4, 2017);
insert into album_rating(mid, stars, year) values(12, 2, 2002), (13, 3, 2002),(14, 5, 2003),(15, 2, 2004), (16, 3, 1996);
insert into album_rating(mid, stars, year) values(18, 4, 2005),(19, 4, 2006),(20, 4, 2007),(21, 4, 2008),(22, 4, 2009);
insert into album_rating(mid, stars, year) values(23, 2, 2010);
insert into album_rating(mid, stars, year) values(24, 3, 2012);
insert into album_rating(mid, stars, year) values(25, 3, 2012);
insert into album_rating(mid, stars, year) values(26, 2, 2013);
insert into album_rating(mid, stars, year) values(27, 4, 2009);
insert into album_rating(mid, stars, year) values(28, 3, 2014);
insert into album_rating values(29, 5, 2015);
insert into album_rating values(30, 5, 2010),(32, 5, 2004),(33, 5, 2003),(34, 5, 2008),(35, 5, 2013);
insert into album_rating values(31, 3, 2006);
insert into album_rating values(36, 4, 1999),(37, 3, 1993),(38, 5,2021),(39, 5, 2000),(40, 3, 2001),(41, 3, 2002),(42, 4, 2002), (43,5, 2003 ), (44, 4,2003), (45,5, 2006),
(46, 4, 2006),(47,5, 2014),(48, 4, 2015),(49, 5, 2015),(50, 4, 2016),(51, 5, 2022);




-- ---------------------------------organization-----------------------------------------------------------------------
INSERT INTO organization(organization_id, organization_name, organization_contact_num, description)
VALUES (1, 'Creative Infoway', 4155377153, 'Founded in 1976'), 
		(2, 'Accenture Interactive', 2204153082, 'largest global media companiy '),
        (3, 'Be Bold Ltd.', 6466208944, 'Leading org for advertisement');
SELECT * FROM organization;

SELECT * FROM organization_payment;
INSERT INTO organization_payment(payment_id, organization_id, year, payment) VALUES (1, 1, 2021, 500), (2, 2, 2021, 1475), (3,3, 2021, 1500);
INSERT INTO organization_payment(payment_id, organization_id, year, payment) VALUES (4, 1, 2020, 440), (5, 2, 2020, 1360), (6,3, 2020, 1390);
INSERT INTO organization_payment(payment_id, organization_id, year, payment) VALUES (10, 1, 2019, 1275), (11, 2, 2019, 1000), (12,3, 2019, 1900),
(19, 1, 2018, 950), (20, 2, 2018, 1220), (21,3, 2018, 1250),(13, 1,2017, 1000), (14, 2, 2017, 1400), (15,3, 2017, 1100),(16, 1, 2016, 1300), (17, 2, 2016, 1400), (18,3, 2016, 1000);

-- ---------------------------------payment_method-----------------------------------------------------------------------
INSERT INTO payment_method(payment_method_id, account_id, payment_amount, payment_type)
VALUES (1,1, 10, 1), (2,5, 20, 2), (3,8,5, 3 );
--  SELECT * FROM payment_method;



-- ---------------------------------paypal-----------------------------------------------------------------------
  INSERT INTO paypal(paypal_id, email, payment_method_payment_method_id)
  VALUES (1, 'bob@gmail.com', 3), (2, 'ethan@mail.com', 16), (3, 'lyla@gmail.com', 21);
--   SELECT * FROM paypal;




-- ---------------------------------podcast-----------------------------------------------------------------------
INSERT INTO podcast(podcast_id, podcast_title, Multimedia_Content_cdn_id, podcast_duration, year)
VALUES (1, 'Crime Junkie', 1, 459, 2019), (2, 'Deepwater Horizon Pt. 1', 1, 239, 2019), (3, 'Up All Night', 2, 350, 2019),  (4, 'A Bad Feeling', 2, 180, 2019),  (5, 'This is Uncomfortable', 2, 290, 2019); 
INSERT INTO podcast(podcast_id, podcast_title, Multimedia_Content_cdn_id, podcast_duration, year)
VALUES (6, 'Rebel Eaters Club', 2, 420, 2020),(7, 'Spit', 2, 359, 2020),(8, 'Undermine', 2, 120, 2020),(9, 'The Soul Awakening', 2, 280, 2020),(10, 'BoyMom', 2, 213, 2020);
INSERT INTO podcast(podcast_id, podcast_title, Multimedia_Content_cdn_id, podcast_duration, year)
VALUES (11, 'Greatness Within', 3, 512, 2021),(12, 'Mises U 2020', 3, 352, 2021),(13, 'Voice of Reason', 3, 123, 2021),(14, 'Murdaugh Murders', 3, 456,2021),(15, 'Cmon Guys', 3, 179, 2021);
INSERT INTO podcast(podcast_id, podcast_title, Multimedia_Content_cdn_id, podcast_duration, year)
VALUES (16, 'Lent 2022 Present', 1, 321, 2022),(17, 'Aurdino Week', 1, 203, 2022),(18, 'Messari Crypto Series', 1, 143, 2022),(19, 'Un Verano Sin', 2, 239, 2022),(20, 'Ultimate NFL', 2, 156, 2022);
INSERT INTO podcast(podcast_id, podcast_title, Multimedia_Content_cdn_id, podcast_duration, year)
VALUES (21, 'The GenTwenty Podcast', 3, 390, 2018),(22, 'The union', 1, 259, 2018),(23, 'Aphmau Podcast', 1, 152, 2018),(24, 'The What Podcast', 3, 232, 2018),(25, 'The Pin Pin Podcast', 1, 154, 2018);
SELECT * FROM podcast;
SELECT * FROM podcast_rating;
INSERT INTO podcast_rating(pid, stars, avg_stars) VALUES (1, 5, 5), (2, 4, 4), (3, 3, 3), (4, 2, 2), (5, 1, 1);
INSERT INTO podcast_rating(pid, stars, avg_stars) VALUES (6, 5, 5), (7, 3, 3 ), (8, 4, 2), (9, 2, 2), (10, 1, 3 );
INSERT INTO podcast_rating(pid, stars, avg_stars) VALUES (11, 5, 5), (12, 4, 4), (13, 3, 2), (14, 4, 3), (15, 3, 1);
INSERT INTO podcast_rating(pid, stars, avg_stars) VALUES (16, 5, 5), (17, 4,3), (18, 3,2), (19, 3, 1), (20, 4,1);
INSERT INTO podcast_rating(pid, stars, avg_stars) VALUES (21, 5, 5), (22, 4, 2), (23, 3, 1), (24, 2, 3), (25, 1, 5);

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
 --  INSERT INTO published_music(music_id, publisher_publisher_id) VALUES (1, 2), (3,2), (5, 3);
SELECT * FROM published_music;

INSERT INTO published_music(music_id, publisher_publisher_id) VALUES (1,1), (2,1), (3,2), (4,1), (5,1), (6,3), (7,4), (8,2), (9,1), (10,3),
(11,1),(12,1),(13,2),(14,1),(15,1),(16,3),(17,4),(18,2),(19,1),(20,3),
(21,3),(22,2),(23,4);
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
 
























