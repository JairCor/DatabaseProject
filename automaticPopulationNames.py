import csv
import mysql.connector
import uuid
import random
import string

taken_uuids = set()
user_map = {}

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

def insert_user(cursor, user_id, user_name, user_email, user_pw, role_id):
    sql = "INSERT INTO user (USER_ID, USERNAME, USER_EMAIL, USER_PW, ROLE_ID) VALUES (%s, %s, %s, %s, %s)"
    cursor.execute(sql, (user_id, user_name, user_email, user_pw, role_id))
    user_map[user_name] = user_id


def process_csv(filename):
    try:
        connection = connect_to_mysql()
        cursor = connection.cursor()

        with open(filename, 'r') as file:
            csv_reader = csv.reader(file)
            next(csv_reader)  
            for row in csv_reader:


                user_name = row[3]
                user_id = ""

                if user_name in user_map:
                    user_name = user_name + row[0] + ''.join(random.choice(string.digits) for _ in range(2))
                    user_id = generate_uuid("U", 14)
                else:
                    user_id = generate_uuid("U", 14)
               
                user_email = row[3] + row[4] + row[5] + "@gmail.com"
                
                characters = string.ascii_letters + string.digits
                user_pw = ''.join(random.choice(characters) for _ in range(8))
                role_id = "R1"

                insert_user(cursor, user_id, user_name, user_email, user_pw, role_id)

                print("User Data inserted for:", user_name)

        connection.commit()
        print("Data inserted successfully!")
    except mysql.connector.Error as error:
        print("Error inserting data into MySQL:", error)
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
            print("MySQL connection is closed.")

process_csv('./Dataset_Names.csv')
