import mysql.connector
from mysql.connector import Error
import random

def connect_to_mysql():
    try:
        return mysql.connector.connect(
            user="root",
            password="password",
            host="localhost",
            database="projectdb"
        )
    except Error as e:
        print("Error connecting to MySQL:", e)
        return None

def select_random_playlist(cursor):
    cursor.execute("SELECT PLAYLIST_ID FROM playlist")
    playlist_ids = [row[0] for row in cursor.fetchall()]
    return random.choice(playlist_ids)

def select_random_user(cursor):
    cursor.execute("SELECT USER_ID FROM user")
    user_ids = [row[0] for row in cursor.fetchall()]
    return random.choice(user_ids)

def insert_user_playlist(cursor, connection, user_id, playlist_id):
    insert_query = "INSERT INTO user_playlist (USER_ID, PLAYLIST_ID) VALUES (%s, %s)"
    cursor.execute(insert_query, (user_id, playlist_id))
    connection.commit()

def main():
    connection = connect_to_mysql()

    if connection:
        cursor = connection.cursor()

        playlist_id = select_random_playlist(cursor)

        user_id = select_random_user(cursor)

        insert_user_playlist(cursor, connection, user_id, playlist_id)
        print(f"User {user_id} has been assigned playlist {playlist_id}")

        cursor.close()
        connection.close()

if __name__ == "__main__":
    main()
