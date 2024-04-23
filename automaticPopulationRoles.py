import mysql.connector
from mysql.connector import Error

def connect_to_mysql():
    return mysql.connector.connect(
        user="root",
        password="password",
        host="localhost",
        database="projectdb"
    )
 

def get_user_roles(cursor):
    cursor.execute("SELECT USER_ID, ROLE_ID FROM user")
    return cursor.fetchall()

def get_role_name(role_id):
    if role_id == 'R1':
        return 'User'
    elif role_id == 'R0':
        return 'Admin'
    else:
        return 'Unknown'

def insert_user_roles(cursor, connection, user_roles):
    insert_query = "INSERT INTO user_role (ROLE_ID, ROLE_NAME, USER_ID) VALUES (%s, %s, %s)"
    for user_id, role_id in user_roles:
        role_name = get_role_name(role_id)
        cursor.execute(insert_query, (role_id, role_name, user_id))
    connection.commit()

def main():
    connection = connect_to_mysql()

    if connection:
        cursor = connection.cursor()

        user_roles = get_user_roles(cursor)

        insert_user_roles(cursor, connection, user_roles)
        print("User roles inserted successfully.")

        cursor.close()
        connection.close()

if __name__ == "__main__":
    main()
