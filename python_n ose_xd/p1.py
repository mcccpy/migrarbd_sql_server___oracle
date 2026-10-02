import oracledb

# Conexión en modo Thin (no requiere cliente Oracle)
connection = oracledb.connect(
    user="dbeaver",
    password="clave",
    dsn="localhost/test"
)

cursor = connection.cursor()
cursor.execute("SELECT * FROM EDIFICIOS")
for row in cursor:
    print(row)

connection.close()
