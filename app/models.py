from bcrypt import gensalt, hashpw
from db import get_connection


class usuario:
    tablename = "usuario"
    fields = (
        "id",
        "nombre",
        "apellido",
        "email",
        "telefono_prefijo",
        "telefono_numero",
        "contraseña",
    )
    all_fields: str = ", ".join(fields)
    no_id_fields: str = ", ".join(fields[1:])
    no_pass_fields: str = ", ".join(fields[: len(fields) - 1])

    @classmethod
    def create(
        cls,
        nombre: str,
        apellido: str,
        mail: str,
        prefijo_tel: int,
        telefono: str,
        contraseña: str,
    ) -> None:
        "Crear nuevo registro de usuario en la base de datos"

        cnx = get_connection()
        cursor_create = cnx.cursor()

        sql = f"INSERT INTO {cls.tablename}({cls.no_id_fields})\
                VALUES  (%s, %s, %s, %s, %s, %s)"

        values = (
            nombre,
            apellido,
            mail,
            prefijo_tel,
            telefono,
            hashpw(password=contraseña.encode("utf8"), salt=gensalt()),
        )

        cursor_create.execute(sql, values)

        cnx.commit()
        cursor_create.close()
        cnx.close()

    @classmethod
    def load_user(cls, id: int) -> "usuario":
        sql = f"SELECT {cls.no_pass_fields} FROM {cls.tablename} WHERE id = %s"

        cnx = get_connection()
        cursor = cnx.cursor()

        loaded_user = usuario()
        cursor.execute(sql, (id,))

        (
            loaded_user.id,
            loaded_user.nombre,
            loaded_user.apellido,
            loaded_user.mail,
        ) = cursor.fetchone()

        return loaded_user

    def __init__(
        self,
        id: int = None,
        nombre: str = None,
        apellido: str = None,
        mail: str = None,
        telef_prefix: str = None,
        telef_num: str = None,
        contraseña: str = None,
    ) -> None:
        self.id = id
        self.nombre = nombre
        self.apellido = apellido
        self.mail = mail
        self._contraseña = contraseña
        self.prefijo_telefono = telef_prefix
        self.numero_telefono = telef_num

    def __tuple__(self) -> tuple:
        """Retornar atributos de usuario como tupla


        Returns:
            tuple: (id, nombre, apellido, mail)
        """
        return (self.id, self.nombre, self.apellido, self.mail)


class prefijos_telefonicos:
    """Clase encargada de obtener los prefijos telefonicos"""

    tablename = "prefijo_telefono"

    @classmethod
    def read_all(cls):
        """Obtener todos los paises y sus codigos sin ID"""

        cnx = get_connection()
        cursor_getall = cnx.cursor(dictionary=True)
        cursor_getall.execute(
            f"SELECT id, prefijo, pais FROM {prefijos_telefonicos.tablename}"
        )

        return cursor_getall.fetchall()

    @classmethod
    def get_prefix_of_id(self, id: int):
        """Obtener todos los paises y sus codigos sin ID"""

        cnx = get_connection()
        cursor_prefix = cnx.cursor()
        cursor_prefix.execute(
            f"SELECT prefijo FROM {prefijos_telefonicos.tablename} WHERE id = %s",
            (id,),
        )

        return cursor_prefix.fetchone()
