import csv
import mysql.connector
import uuid

taken_uuids = set()
artist_map = {}
genre_map = {}
topic_map = {}

def generate_uuid(prefix, size):
    while True:
        new_uuid = str(uuid.uuid4())[:size - len(prefix)]
        new_id = prefix + new_uuid
        if new_id not in taken_uuids:
            taken_uuids.add(new_id)
            return new_id

def connect_to_mysql():
    return mysql.connector.connect(
        user="root",
        password="password",
        host="localhost",
        database="projectdb"
    )

def insert_artist(cursor, artist_id, artist_name):
    sql = "INSERT INTO artist (ARTIST_ID, ARTIST_NAME) VALUES (%s, %s)"
    cursor.execute(sql, (artist_id, artist_name))
    artist_map[artist_name] = artist_id

def insert_genre(cursor, genre_id, genre_name):
    sql = "INSERT INTO genre (GENRE_ID, GENRE_NAME) VALUES (%s, %s)"
    cursor.execute(sql, (genre_id, genre_name))
    genre_map[genre_name] = genre_id

def insert_lyrics(cursor, lyrics_id, lyrics_text, word_count):
    sql = "INSERT INTO lyrics (LYRICS_ID, LYRICS_TEXT, WORD_COUNT) VALUES (%s, %s, %s)"
    cursor.execute(sql, (lyrics_id, lyrics_text, word_count))

def insert_mood(cursor, mood_id, song_id, *values):
    sql = "INSERT INTO mood (MOOD_ID, SONG_ID, DATING_VAL, VIOLENCE_VAL, WORLDLIFE_VAL, NIGHTTIME_VAL, SHAKING_VAL, FAM_GOSPEL_VAL, ROMANTIC_VAL, COMMS_VAL, OBSCENE_VAL, MUSIC_VAL, MOVMTPLACES_VAL, VISUAL_VAL, FAM_SPIRIT_VAL, LIKE_GIRLS_VAL, SADNESS_VAL, FEELINGS_VAL, DANCE_VAL, LOUDNESS_VAL, ACOUSTIC_VAL, INSTRUMENT_VAL, VALANCE_VAL, ENERGY_VAL) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    cursor.execute(sql, (mood_id, song_id, *values))

def insert_topic(cursor, topic_id, topic_name):
    sql = "INSERT INTO topic (TOPIC_ID, TOPIC_NAME) VALUES (%s, %s)"
    cursor.execute(sql, (topic_id, topic_name))
    topic_map[topic_name] = topic_id

def insert_song(cursor, song_id, song_name, artist_id, release_date, genre_id, lyrics_id, mood_id, topic_id):
    sql = "INSERT INTO song (SONG_ID, SONG_NAME, ARTIST_ID, RELEASE_DATE, GENRE_ID, LYRICS_ID, MOOD_ID, topic_TOPIC_ID) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
    cursor.execute(sql, (song_id, song_name, artist_id, release_date, genre_id, lyrics_id, mood_id, topic_id))


def process_csv(filename):
    try:
        connection = connect_to_mysql()
        cursor = connection.cursor()

        with open(filename, 'r') as file:
            csv_reader = csv.reader(file)
            next(csv_reader)  
            for row in csv_reader:

                artist_name = row[1]
                genre_name = row[4]
                topic_name = row[30]

                artist_id = None
                genre_id = None
                topic_id = None
                
                if artist_name in artist_map:
                    artist_id = artist_map[artist_name]
                else:
                    artist_id = generate_uuid("A", 7)
                    insert_artist(cursor, artist_id, artist_name)

                if genre_name in genre_map:
                    genre_id = genre_map[genre_name]
                else:
                    genre_id = generate_uuid("G", 7)
                    insert_genre(cursor, genre_id, genre_name)

                if topic_name in topic_map:
                    topic_id = topic_map[topic_name]
                else:
                    topic_id = generate_uuid("T", 7)
                    insert_topic(cursor, topic_id, topic_name)

                song_id = generate_uuid("S", 15)
                lyrics_id = generate_uuid("L", 15)
                mood_id = generate_uuid("M", 7)

                song_name = row[2]
                release_date = row[3]
                lyrics_text = row[5]
                word_count = row[6]
                mood_values = [float(value) for value in row[7:29]]
                
                insert_lyrics(cursor, lyrics_id, lyrics_text, word_count)
                mood_values = [float(value) for value in row[7:29]]
                insert_mood(cursor, mood_id, song_id, *mood_values)                
                insert_song(cursor, song_id, song_name, artist_id, release_date, genre_id, lyrics_id, mood_id, topic_id)
                print("Data inserted for song:", song_name)

        connection.commit()
        print("Data inserted successfully!")
    except mysql.connector.Error as error:
        print("Error inserting data into MySQL:", error)
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
            print("MySQL connection is closed.")

process_csv('./Dataset_Music.csv')
