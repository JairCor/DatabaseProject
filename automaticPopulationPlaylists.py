import mysql.connector
from mysql.connector import Error

def connect_to_mysql():
    return mysql.connector.connect(
        user="root",
        password="password",
        host="localhost",
        database="projectdb"
    )


def get_playlist_id(cursor, playlist_name):
    cursor.execute("SELECT PLAYLIST_ID FROM playlist WHERE PLAYLIST_NAME = %s", (playlist_name,))
    playlist_id = cursor.fetchone()[0]
    return playlist_id

def get_songs(cursor, mood_criteria):
    mood_conditions = []
    for mood, value in mood_criteria.items():
        if isinstance(value, dict):
            mood_conditions.append(f"mood.{mood} {value['operator']} {value['value']}")
        else:
            mood_conditions.append(f"mood.{mood} > {value}")

    query = f"""
        SELECT song.SONG_ID, song.SONG_NAME 
        FROM song 
        JOIN mood ON song.MOOD_ID = mood.MOOD_ID
        WHERE {' AND '.join(mood_conditions)}
    """
    cursor.execute(query)
    songs = cursor.fetchall()
    return songs

def get_song_genres(cursor, song_id):
    cursor.execute("SELECT genre.GENRE_NAME FROM song JOIN genre ON song.GENRE_ID = genre.GENRE_ID WHERE song.SONG_ID = %s", (song_id,))
    genres = [row[0] for row in cursor.fetchall()]
    return genres

def get_song_topics(cursor, song_id):
    cursor.execute("SELECT topic.TOPIC_NAME FROM song JOIN topic ON song.TOPIC_ID = topic.TOPIC_ID WHERE song.SONG_ID = %s", (song_id,))
    topics = [row[0] for row in cursor.fetchall()]
    return topics

def insert_songs_into_playlist(cursor, connection, playlist_id, songs):
    insert_query = "INSERT INTO playlist_songs (PLAYLIST_ID, SONG_ID) VALUES (%s, %s)"
    cursor.executemany(insert_query, [(playlist_id, song[0]) for song in songs])
    connection.commit()

def insert_playlist_with_genre(cursor, connection, playlist_id, genre):
    get_genre_id_query = "SELECT GENRE_ID FROM genre WHERE GENRE_NAME = %s"
    cursor.execute(get_genre_id_query, (genre,))
    result = cursor.fetchone()
    if result:
        genre_id = result[0]
        insert_playlist_genre_query = "INSERT INTO playlist_genre (PLAYLIST_ID, GENRE_ID) VALUES (%s, %s)"
        cursor.execute(insert_playlist_genre_query, (playlist_id, genre_id))
        connection.commit()
    else:
        print(f"No genre found for '{genre}'. Playlist '{playlist_id}' will have an unspecified genre.")

def insert_playlist_with_topic(cursor, connection, playlist_id, topic):
    get_topic_id_query = "SELECT TOPIC_ID FROM topic WHERE TOPIC_NAME = %s"
    cursor.execute(get_topic_id_query, (topic,))
    result = cursor.fetchone()
    if result:
        topic_id = result[0]
        insert_playlist_topic_query = "INSERT INTO playlist_topic (PLAYLIST_ID, TOPIC_ID) VALUES (%s, %s)"
        cursor.execute(insert_playlist_topic_query, (playlist_id, topic_id))
        connection.commit()
    else:
        print(f"No topic found for '{topic}'. Playlist '{playlist_id}' will have an unspecified topic.")

def main():
    connection = connect_to_mysql()

    cursor = connection.cursor()

    playlist_mood_criteria = {
        'Hype': {'ENERGY_VAL': 0.8, 'DANCE_VAL': 0.7, 'LOUDNESS_VAL': 0.7, 'COMMS_VAL': 0.5, 'VALANCE_VAL': 0.6, 'SADNESS_VAL': 0.2},
        'Workout Pump': {'ENERGY_VAL': 0.85, 'DANCE_VAL': 0.6, 'LOUDNESS_VAL': 0.8, 'MOVMTPLACES_VAL': 0.6, 'VALANCE_VAL': 0.5, 'SADNESS_VAL': 0.3},
        'Chill': {'ENERGY_VAL': {'operator': '<', 'value': 0.5}, 'DANCE_VAL': {'operator': '<', 'value': 0.5}, 'ACOUSTIC_VAL': 0.6, 'VALANCE_VAL': 0.4, 'SADNESS_VAL': {'operator': '>', 'value': 0.3}, 'VIOLENCE_VAL': {'operator': '<', 'value': 0.1}},
        'Road Trip': {'ENERGY_VAL': 0.7, 'DANCE_VAL': 0.5, 'MOVMTPLACES_VAL': 0.5, 'VALANCE_VAL': 0.6, 'SADNESS_VAL': 0.2, 'VIOLENCE_VAL': {'operator': '<', 'value': 0.1}},
        'Hip Hop Groove': {'ENERGY_VAL': 0.7, 'DANCE_VAL': 0.6, 'SHAKING_VAL': 0.6, 'VALANCE_VAL': 0.5, 'SADNESS_VAL': 0.3, 'ROMANTIC_VAL': {'operator': '<', 'value': 0.2}},
        'Morning Motivation': {'ENERGY_VAL': 0.75, 'DANCE_VAL': 0.6, 'LOUDNESS_VAL': 0.7, 'VALANCE_VAL': 0.7, 'COMMS_VAL': 0.4, 'SADNESS_VAL': 0.3},
        'Party Starters': {'ENERGY_VAL': 0.8, 'DANCE_VAL': 0.7, 'SHAKING_VAL': 0.7, 'VALANCE_VAL': 0.6, 'SADNESS_VAL': 0.3, 'ROMANTIC_VAL': {'operator': '<', 'value': 0.2}},
        'Dance Floor': {'ENERGY_VAL': 0.8, 'DANCE_VAL': 0.8, 'LOUDNESS_VAL': 0.8, 'VALANCE_VAL': 0.7, 'SADNESS_VAL': 0.3, 'ROMANTIC_VAL': {'operator': '<', 'value': 0.2}},
        'Retro Rewind': {'ENERGY_VAL': 0.6, 'DANCE_VAL': 0.6, 'VALANCE_VAL': 0.6, 'SADNESS_VAL': 0.3},
        'Rainy Day': {'ENERGY_VAL': {'operator': '<', 'value': 0.5}, 'ACOUSTIC_VAL': 0.7, 'VALANCE_VAL': 0.4, 'SADNESS_VAL': 0.6, 'ROMANTIC_VAL': {'operator': '<', 'value': 0.2}},
        'Indie Gems': {'ENERGY_VAL': 0.6, 'DANCE_VAL': 0.6, 'ACOUSTIC_VAL': 0.7, 'VALANCE_VAL': 0.5, 'SADNESS_VAL': 0.4},
        'Throwbacks': {'ENERGY_VAL': 0.6, 'DANCE_VAL': 0.6, 'ACOUSTIC_VAL': 0.5, 'VALANCE_VAL': 0.5, 'SADNESS_VAL': 0.3},
        'Late Night Drives': {'ENERGY_VAL': 0.5, 'DANCE_VAL': 0.5, 'LOUDNESS_VAL': 0.5, 'VALANCE_VAL': 0.4, 'SADNESS_VAL': 0.6, 'NIGHTTIME_VAL': 0.7},
        'Ambient Escapes': {'ENERGY_VAL': {'operator': '<', 'value': 0.5}, 'ACOUSTIC_VAL': 0.8, 'VALANCE_VAL': 0.4, 'SADNESS_VAL': 0.4},
        'Pool Party': {'ENERGY_VAL': 0.8, 'DANCE_VAL': 0.8, 'LOUDNESS_VAL': 0.7, 'VALANCE_VAL': 0.7, 'SADNESS_VAL': 0.3},
        'Night City Vibes': {'ENERGY_VAL': 0.7, 'DANCE_VAL': 0.6, 'LOUDNESS_VAL': 0.6, 'VALANCE_VAL': 0.6, 'SADNESS_VAL': 0.3, 'NIGHTTIME_VAL': 0.8},
        'Lonely Sad Mix': {'ENERGY_VAL': 0.4, 'DANCE_VAL': 0.4, 'ACOUSTIC_VAL': 0.7, 'VALANCE_VAL': 0.3, 'SADNESS_VAL': 0.8, 'ROMANTIC_VAL': {'operator': '<', 'value': 0.2}},
        'Floating': {'ENERGY_VAL': {'operator': '<', 'value': 0.5}, 'ACOUSTIC_VAL': 0.6, 'VALANCE_VAL': 0.5, 'SADNESS_VAL': 0.4},
        'Lowkey Vibes': {'ENERGY_VAL': 0.5, 'ACOUSTIC_VAL': 0.6, 'VALANCE_VAL': 0.5, 'SADNESS_VAL': 0.4},
        'Phonk': {'ENERGY_VAL': 0.7, 'DANCE_VAL': 0.7, 'LOUDNESS_VAL': 0.7, 'VALANCE_VAL': 0.6, 'SADNESS_VAL': 0.3},
        'Enough Said': {'ENERGY_VAL': 0.6, 'DANCE_VAL': 0.6, 'ACOUSTIC_VAL': 0.6, 'VALANCE_VAL': 0.5, 'SADNESS_VAL': 0.3},
        'Focus Homework Mix': {'ENERGY_VAL': 0.6, 'DANCE_VAL': 0.5, 'ACOUSTIC_VAL': 0.7, 'VALANCE_VAL': 0.5, 'SADNESS_VAL': 0.3},
        'Drum and Bass Mix': {'ENERGY_VAL': 0.8, 'DANCE_VAL': 0.8, 'LOUDNESS_VAL': 0.8, 'VALANCE_VAL': 0.6, 'SADNESS_VAL': 0.2},
        'Aux': {'ENERGY_VAL': {'operator': '<', 'value': 0.5}, 'DANCE_VAL': {'operator': '<', 'value': 0.5}, 'ACOUSTIC_VAL': {'operator': '>', 'value': 0.5}, 'VALANCE_VAL': 0.5, 'SADNESS_VAL': 0.4},
        'Late Night': {'ENERGY_VAL': 0.5, 'DANCE_VAL': 0.5, 'ACOUSTIC_VAL': 0.6, 'VALANCE_VAL': 0.4, 'SADNESS_VAL': 0.6, 'NIGHTTIME_VAL': 0.7}
    }

    for playlist_name, mood_criteria in playlist_mood_criteria.items():
            playlist_id = get_playlist_id(cursor, playlist_name)
            
            songs = get_songs(cursor, mood_criteria)

            genre_count = {}
            for song in songs:
                song_id = song[0]
                song_genres = get_song_genres(cursor, song_id)
                for genre in song_genres:
                    if genre in genre_count:
                        genre_count[genre] += 1
                    else:
                        genre_count[genre] = 1

            topic_count = {}
            for song in songs:
                song_id = song[0]
                song_topics = get_song_topics(cursor, song_id)
                for topic in song_topics:
                    if topic in topic_count:
                        topic_count[topic] += 1
                    else:
                        topic_count[topic] = 1
            
            default_genre = "Unspecified"
            if genre_count:
                most_popular_genre = max(genre_count, key=genre_count.get)
            else:
                most_popular_genre = default_genre

            default_topic = "Unspecified"
            if topic_count:
                most_popular_topic = max(topic_count, key=topic_count.get)
            else:
                most_popular_topic = default_topic

            insert_playlist_with_genre(cursor, connection, playlist_id, most_popular_genre)

            insert_playlist_with_topic(cursor, connection, playlist_id, most_popular_topic)

            insert_songs_into_playlist(cursor, connection, playlist_id, songs)

    cursor.close()
    connection.close()

if __name__ == "__main__":
    main()
