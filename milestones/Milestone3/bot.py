# bot.py
# This file is intended to be a "getting started" code example for students.
# The code in this file is fully functional.
# Students are free to edit the code in the milestone 3 folder.
# Students are NOT allowed to distribute this code without the express permission of the class instructor
# IMPORTANT: How to set your secret environment variables? read README guidelines.

# imports
import os
import discord
import database as db


# environment variables
token = os.environ['DISCORD_TOKEN']
server = os.environ['DISCORD_GUILD']
# server_id = os.environ['SERVER_ID']  # optional
# channel_id = os.environ['CHANNEL_ID']  # optional

# database connection
# secret keys related to your database must be updated. Otherwise, it won't work
db_conn = db.connect()
# bot events
client = discord.Client()


@client.event
async def on_ready():
    """
    This method triggers with the bot connects to the server
    Note that the sample implementation here only prints the
    welcome message on the IDE console, not on Discord
    :return: VOID
    """
    print("{} has joined the server".format(client.user.name))


@client.event
async def on_message(message):
    """
    This method triggers when a user sends a message in any of your Discord server channels
    :input message: the message from the user. Note that this message is passed automatically by the Discord API
    :return: VOID
    """
    response = None  # will save the response from the bot
    if message.author == client.user:
        return  # the message was sent by the bot
    if message.type is discord.MessageType.new_member:
        response = "Welcome {}".format(
            message.author)  # a new member joined the server. Welcome him.
    else:
        # A message was send by the user.
        msg = message.content
        print(msg)
        response = validate_message(msg)
        #edit here:
        # response = db.response(msg)
        #response is a method made in database file
    if response:
        # bot sends response to the Discord API and the response is show
        # on the channel from your Discord server that triggered this method.
        embed = discord.Embed(description=response)
        await message.channel.send(embed=embed)


def validate_message(msg):

    command_part = msg.split(" ")
    userInputExists = len(command_part) >= 2
    bot_command = command_part[0]

    if userInputExists:
        input = command_part[1]
    else:
        input = None

    if "milestone3" in msg:
        return "I am alive. Signed: 'your bot'"

    elif "$atleastXSongsArtist" in bot_command and userInputExists:

        array_of_dictionaries = db.atleastXSongsArtist(input)
        return array_of_dictionaries

    elif "$moreRatingAlbum" in bot_command and userInputExists:

        array_of_dictionaries = db.moreRatingAlbum(input)
        return  array_of_dictionaries

    elif "$mailingNotMessagingUsers" in bot_command:

        array_of_dictionaries = db.mailingNotMessagingUsers()
        return array_of_dictionaries

    elif "$advertisementLastXYears" in bot_command and userInputExists:

        array_of_dictionaries = db.advertisementLastXYears(input)
        return array_of_dictionaries

    elif "$organization_no_support" in bot_command and userInputExists:

        array_of_dictionaries = db.organization_no_support(input)
        return array_of_dictionaries

    
    elif "$bannedPodcastInRegion" in bot_command and userInputExists:

        array_of_dictionaries = db.bannedPodcastInRegion(input)
        return array_of_dictionaries

      
    elif "$songsInAlbum" in bot_command and userInputExists:

        array_of_dictionaries = db.songsInAlbum(input)
        return array_of_dictionaries

    elif "$lowestRatedTracks" in bot_command and userInputExists:

        array_of_dictionaries = db.lowestRatedTracks(input)
        return array_of_dictionaries

    elif "$podcastMaxRatingMaxAverage" in bot_command:

        array_of_dictionaries = db.podcastMaxRatingMaxAverage()
        return array_of_dictionaries

    elif "$differenceInAvg" in bot_command:

        array_of_dictionaries = db.differenceInAvg()
        return array_of_dictionaries

    elif "$podcastsMoreThanXRating" in bot_command and userInputExists:

        array_of_dictionaries = db.podcastsMoreThanXRating(input)

        return array_of_dictionaries

    elif "$longestpodcast" in bot_command and userInputExists:
        return "Not executed yet!"

    elif "$second_highest_payment" in bot_command and userInputExists:
        return "Throws error so I commented it out"
      
    elif "$insert_device" in bot_command and userInputExists:
        return "Not executed yet!"

    elif "$addAudioToFamousChoice" in bot_command and userInputExists:
        return "Not executed yet!"

    elif "$track_more_than_5" in bot_command and userInputExists:
        return "Not executed yet!" 

    elif "$refund" in bot_command and userInputExists:
        return "Not executed yet!" 

    elif "$audiobook_rating" in bot_command and userInputExists:
        return "Not executed yet!"  
      

  
    return "No bot_command found! Please check your input is lowercase, starts with a $ and has _ wherever its needed."



try:
    # start the bot and keep the above methods listening for new events
    client.run(token)
except:
    print(
        "Bot is offline because your secret environment variables are not set. Head to the left panel, "
        +
        "find the lock icon, and set your environment variables. For more details, read the README file in your "
        + "milestone 3 repository")
