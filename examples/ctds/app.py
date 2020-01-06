import ctds

db_host = "mssql.example.com"
db_user = "johndoe"
db_pass = "ExamplePassword123"

connection = ctds.connect(
    db_host,
    user=db_user,
    password=db_pass
)

with connection:
    with connection.cursor() as cursor:
        cursor.execute(
            'SELECT * FROM AppUsers WHERE Id = :0',
            (123,)
        )
        row = cursor.fetchone()

# Columns can be accessed by index, name, or attribute.
print(f"User ID: {row[0]}")
print(f"User Name: {row.Name}")
print(f"User Email: {row['Email']}")

