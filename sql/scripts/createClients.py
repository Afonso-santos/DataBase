# Connect to MySQL server and create 5 new clients
import mysql.connector

# Establish connection to MySQL server
def connect():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="root",
        database="CDC"
    )

# Class to represent a client
class Cliente:
    def __init__(self, nome, telefone, email, morada):
        self.nome = nome
        self.telefone = telefone
        self.email = email
        self.morada = morada

    def __str__(self):
        return f"{self.nome} {self.telefone} {self.email} {self.morada}"


# Generate a list of 5 clients to insert
def generateClients():

    clientes = []
    clientes.append(Cliente("João Carvalho",      "912345678", "joao@example.com",  None))
    clientes.append(Cliente("Consultoria Macedo", "912345679", "geral@macedo.com",  "Avenida da Liberdade, 456"))
    clientes.append(Cliente("Maria Silva",        "912345670", "maria@example.com", "Rua do Ouro, 123"))
    clientes.append(Cliente("José Santos",        "912345671", "jose@example.com",  "Avenida da Liberdade, 456"))
    clientes.append(Cliente("Joana Almeida",      "912345672", "joana@example.com", None))

    return clientes

# Insert generated clients into the database
def insertClients():
    try:
        con = connect()
        print("Connected to MySQL server\n")
    except:
        print("Couldn't connect to MySQL server\n")
        return

    # Create a cursor object to execute SQL queries
    try:
        cursor = con.cursor()
        print("Cursor object created\n")
    except:
        print("Couldn't create cursor\n")
        return

    try:
        clientes = generateClients()
        for cliente in clientes:
            query = "INSERT INTO Cliente (Nome, Telefone, Email, Morada) VALUES (%s, %s, %s, %s)"
            values = (cliente.nome, cliente.telefone, cliente.email, cliente.morada)
            cursor.execute(query, values)
            con.commit()
            print(f"Client \"{cliente.nome}\" inserted")
        print()
    except:
        print("Could not insert clients\n")
        return

    try:
        query = f"SELECT * FROM Cliente ORDER BY ID DESC LIMIT {len(clientes)}"
        cursor.execute(query)
        result = cursor.fetchall()
        print(f"Fetching last {len(clientes)} clients inserted:")
        for row in result:
            print(row)
        print()
    except:
        print("Could not fetch last clients\n")
        return

    try :
        cursor.close()
    except:
        print("Could not close cursor")
        return

    try:
        con.close()
        print("Connection and cursor closed")
    except:
        print("Could not close connection")
        return

if __name__ == "__main__":
    insertClients()
