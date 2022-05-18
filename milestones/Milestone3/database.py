# database.py
# Handles all the methods interacting with the database of the application.
# Students must implement their own methods here to meet the project requirements.

import os
import pymysql.cursors


db_host = os.environ['DB_HOST']
db_username = os.environ['DB_USER']
db_password = os.environ['DB_PASSWORD']
db_name = os.environ['DB_NAME']


def connect():
    try:
        conn = pymysql.connect(host=db_host,
                               port=3306,
                               user=db_username,
                               password=db_password,
                               db=db_name,
                               charset="utf8mb4",
                               cursorclass=pymysql.cursors.DictCursor)
        print("Bot connected to database {}".format(db_name))
        return conn
    except:
        print(
            "Bot failed to create a connection with your database because your secret environment variables "
            + "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set".format(
                db_name))
        print("\n")


# your code here


def atleastXSongsArtist(count):
    result = None
    try:
        connection = connect()
        if connection:
            cursor = connection.cursor()
            query = """SELECT COUNT(music_artist_id) as successfulArtists
FROM (
SELECT music_artist.music_artist_id, music_artist.music_artist_name, COUNT(*) num_of_album_published FROM music_album 
JOIN music_artist ON music_album.artist_id = music_artist.music_artist_id
GROUP BY music_artist.music_artist_id, music_artist.music_artist_name
HAVING COUNT(*) > %s) AS num_of_artists""" % count


            cursor.execute(query)
            connection.commit()
            result = cursor.fetchall()
            connection.close()
            if result:
                return result
    except Exception as error:
        return error


def moreRatingAlbum(year):
    result = None
    try:
        connection = connect()
        #     #checking/validating if connection exists
        if connection:
            cursor = connection.cursor()
            query = """SELECT  music_album_id , tile as title, ma.year_released, ar.stars from music_album ma
JOIN album_rating ar ON ar.mid = ma.music_album_id
JOIN music_tracks mt ON mt.music_id = ma.music_album_id
WHERE year_released = %s
AND (SELECT MAX(stars) From album_rating);""" % year

            cursor.execute(query)
            connection.commit()
            result = cursor.fetchall()
            connection.close()
            if result:
                return result

    except Exception as error:
        return error

def mailingNotMessagingUsers():
    result = None
    try:
        connection = connect()
        #     #checking/validating if connection exists
        if connection:
            cursor = connection.cursor()
            query = """SELECT COUNT(generaluser_user_id)
FROM (
SELECT generaluser_user_id  FROM mailing_list_users as mailgen
WHERE NOT EXISTS (
SELECT generaluser_user_id FROM generaluser_has_messaging_list as messgen
WHERE mailgen.generaluser_user_id = messgen.generaluser_user_id)
) as a"""

            cursor.execute(query)
            connection.commit()
            result = cursor.fetchall()
            connection.close()
            if result:
                return result

    except Exception as error:
        return error   

def advertisementLastXYears(year):
    result = None
    try:
        connection = connect()
        #     #checking/validating if connection exists
        if connection:
            cursor = connection.cursor()
            query = """SELECT organization_id, COUNT(advertisement_id) FROM advertisements_has_organization as ao
JOIN advertisements a on a.advertisement_id = ao.advertisements_advertisement_id
JOIN organization o on o.organization_id = ao.organization_organization_id
WHERE DATE_SUB(CURDATE(),INTERVAL %s YEAR) <= a.advertisement_date
GROUP BY organization_id""" % year

            cursor.execute(query)
            connection.commit()
            result = cursor.fetchall()
            connection.close()
            if result:
                return result

    except Exception as error:
        return error 

def organization_no_support(specific_order):
    result = None
    try:
        connection = connect()
        #     #checking/validating if connection exists
        if connection:
            cursor = connection.cursor()
            query = """SELECT advertisement_id, advertisement_name FROM advertisements ad
WHERE advertisement_id NOT IN (SELECT advertisements_has_organization.advertisements_advertisement_id FROM advertisements_has_organization )
ORDER BY advertisement_name %s""" % specific_order

            cursor.execute(query)
            connection.commit()
            result = cursor.fetchall()
            connection.close()
            if result:
                return result

    except Exception as error:
        return error  

# def second_highest_payment(year):
#     result = None
#     try:
#         connection = connect()
        
#         if connection:
#             cursor = connection.cursor()
#             query = """SELECT payment FROM 
# (SELECT payment FROM organization_payment
# WHERE year = %s
# HAVING payment < AVG(payment)
# ORDER BY payment DESC LIMIT 2) AS op 
# ORDER BY payment LIMIT 1;
# """ % year

#             cursor.execute(query)
#             connection.commit()
#             result = cursor.fetchall()
#             connection.close()
#             if result:
#                 return result

#     except Exception as error:
#         return error  

def bannedPodcastInRegion(region_id):
    result = None
    try:
        connection = connect()
        #     #checking/validating if connection exists
        if connection:
            cursor = connection.cursor()
            query = """SELECT p.podcast_title, r.region_name, r.region_id FROM podcast p
JOIN region r ON r.cdn_id = p.Multimedia_Content_cdn_id
WHERE NOT region_id = %s
ORDER BY region_name;""" % region_id

            cursor.execute(query)
            connection.commit()
            result = cursor.fetchall()
            connection.close()
            if result:
                return result

    except Exception as error:
        return error  

def songsInAlbum(specific_order):
    result = None
    try:
        connection = connect()
        #     #checking/validating if connection exists
        if connection:
            cursor = connection.cursor()
            query = """SELECT music_id, music.music_album, music_album_id, tile as album_title  FROM music_tracks as music
JOIN music_album ma ON ma.music_album_id  = music.music_id
ORDER BY music.music_album %s;
""" % specific_order
            
            cursor.execute(query)
            connection.commit()
            result = cursor.fetchall()
            connection.close()
            if result:
                return result

    except Exception as error:
        return error  

def lowestRatedTracks(year):
    result = None
    try:
        connection = connect()
        #     #checking/validating if connection exists
        if connection:
            cursor = connection.cursor()
            query = """SELECT m.year, m.music_track_rating, m.music_title FROM music_tracks m,
(SELECT year, MIN(music_track_rating) as minrating FROM music_tracks
GROUP BY year) AS rate
WHERE m.year = rate.year AND rate.minrating = m.music_track_rating AND m.year >= %s
ORDER BY m.year ASC, m.music_title ASC;""" % year

            cursor.execute(query)
            connection.commit()
            result = cursor.fetchall()
            connection.close()
            if result:
                return result

    except Exception as error:
        return error 

def podcastMaxRatingMaxAverage():
    result = None
    try:
        connection = connect()
        #     #checking/validating if connection exists
        if connection:
            cursor = connection.cursor()
            query = """SELECT MAX(pr.stars) as max_rating, AVG(pr.avg_stars) as avg_stars FROM podcast p
JOIN podcast_rating pr ON pr.pid = p.podcast_id;""" 

            cursor.execute(query)
            connection.commit()
            result = cursor.fetchall()
            connection.close()
            if result:
                return result

    except Exception as error:
        return error 

def differenceInAvg():
    result = None
    try:
        connection = connect()
        #     #checking/validating if connection exists
        if connection:
            cursor = connection.cursor()
            query = """SELECT AVG(Before1985.avg) - AVG(After1985.avg)
FROM (
  SELECT AVG(music_track_rating) AS avg
  FROM music_tracks
  
  WHERE year < 1985
  GROUP BY music_tracks.music_id
) AS Before1985, (
  SELECT AVG(music_track_rating) AS avg
  FROM music_tracks
 
  WHERE year > 1985
  GROUP BY music_tracks.music_id
) AS After1985;""" 

            cursor.execute(query)
            connection.commit()
            result = cursor.fetchall()
            connection.close()
            if result:
                return result

    except Exception as error:
        return error 

def podcastsMoreThanXRating(rating):
    result = None
    try:
        connection = connect()
        #     #checking/validating if connection exists
        if connection:
            cursor = connection.cursor()
            query = """SELECT podcast_title, podcast_id, pr.stars as max_stars FROM podcast p
JOIN podcast_rating pr ON pr.pid = p.podcast_id
WHERE stars > %s 
""" % rating

            cursor.execute(query)
            connection.commit()
            result = cursor.fetchall()
            connection.close()
            if result:
                return result

    except Exception as error:
        return error


# def longestpodcast(year):
#     result = None
#     try:
#         connection = connect()
#         #     #checking/validating if connection exists
#         if connection:
#             cursor = connection.cursor()
#             query = """DELIMITER $$
# CREATE FUNCTION longest_podcast(year INT) as long
# RETURNS VARCHAR(235)
# DETERMINISTIC
# BEGIN 
#     DECLARE track_name VARCHAR(235);
    
#     Set track_name = (SELECT Concat(podcast.podcast_title, " ", max(podcast.podcast_duration)) from podcast podcast 
#                         WHERE podcast.year = %s
#                        Group BY podcast.podcast_title
#                        ORDER BY podcast.podcast_title DESC
#                        Limit 1);
      
# 	return track_name;
# END $$
          

# DELIMITER ;
#           SELECT longest_podcast(year)
#           """ % year

  
#             cursor.execute(query)
#             result = cursor.fetchOne()
#             connection.close()
#             if result:
#                 return result
#     except Exception as error:
#         return error


      

