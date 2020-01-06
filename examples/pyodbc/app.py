import pyodbc

db_host = "mssql.example.com"
db_user = "johndoe"
db_pass = "ExamplePassword123"
db_name = "testdb"

conn = pyodbc.connect('DRIVER={SQL Server};' + f'SERVER={db_host};DATABASE={db_name};UID={db_user};PWD={db_pass}')

cursor = conn.cursor()
cursor.execute(
    'SELECT * FROM AppUsers WHERE Id = ?',
    123
)

row = cursor.fetchone()

print(f"User ID: {row[0]}")
print(f"User Name: {row.Name}")
print(f"User Email: {row[2]}")

