# Promanager

## Sistema de Gestión de Proyectos

### Aviso

El sistema actual cuenta únicamente con los siguientes módulos:

- CRUD de Usuario y Proyectos
- CR (Create, Read) de Integrantes de Proyectos
- custom Router Wsgi
- Soporte para creación endpoints API
- custom Context Manager para mysql-connector
- Gestión de plantillas mediante Jinja2
- Utilidad CLI para levantar y tirar la BD

Por el momento el sistema está funcionando en [una instancia de pythonanywhere](https://bonialmendra.pythonanywhere.com/), para poder experimentar el sistema recomiendo acceder al sitio.

### Descripción

Este proyecto implica el desarrollo de un sistema de Gestión de Proyectos, es una aplicación web desarrollada en Python utilizando las bibliotecas Werkzeug, Jinja2, MySQL-Connector-Python y Click. Su objetivo principal es proporcionar una plataforma para gestionar proyectos, permitiendo a los usuarios crear, modificar y dar seguimiento a proyectos en un entorno web. Además, integra MySQL como sistema de gestión de bases de datos para almacenar la información relacionada con los proyectos. El proyecto también incluye componentes JavaScript para la interfaz de usuario y consultas a la API del sistema, lo que proporciona una experiencia interactiva, dinámica y amigable para los usuarios.

### Objetivos

- **Aplicación de Conceptos de Programación Orientada a Objetos (OOP) y Desarrollo Web**: Aplicar los conocimientos adquiridos en la materia de Programación 2 para desarrollar una aplicación web funcional y escalable sin utilizar frameworks web de backend ni ORM. Entre los conocimientos adquiridos cuentan: OOP, OOD, WSGI, HTTPS e UI/UX. Implementados con las siguientes herramientas: Python, JavaScript, HTML y Bootstrap.

- **Diseño, Desarrollo e Implementación de Sistemas Software**: Coordinar y complementar los conocimientos adquiridos en distintos espacios curriculares sobre el diseño y desarrollo de sistemas software con foco en producir un sistema que aporte valor siginificativo a los clientes o usuarios.

- **Diseño y Administración de  Bases de Datos Relacionales**: Utilizar MySQL como sistema de gestión de bases de datos para almacenar y recuperar información relacionada con los proyectos, aplicando los conceptos aprendidos en la materia de Bases de Datos. Uso de lenguaje SQL. Diseño de bases de datos relacionales y administración de las mismas.

- **Implementación de MVC** (Modelo-Vista-Controlador): Estructurar el proyecto siguiendo el patrón Modelo-Vista-Controlador para separar la lógica de negocios, la interfaz de usuario y el control de manera organizada y eficiente.

- **Exploración de Protocolo HTTP y Web**: Aprender sobre los fundamentos del protocolo HTTP y el desarrollo web para crear una aplicación que funcione en el entorno web.

Este proyecto fue desarrollado como parte de espacios curriculares de Programación 2, Prácticas Profesionales 2 y Bases de Datos, está diseñado para demostrar una comprensión profunda de conceptos como WSGI, bases de datos relacionales, APIs y MVC.

### Instalación

#### Requerimientos

¡Antes de continuar asegurate de que tu PC cuente con los siguientes requerimientos!

1. Tener MySQL 8.0.35 instalado
1. Contar con un usuario de MySQL con los siguientes permisos: SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, REFERENCES, INDEX, ALTER
1. Contar con Python 3.10.12 o mayor
1. GIT 2.34.1

#### Pasos

Una vez cuentes con los puntos anteriores debes:

1. **Clonar repositorio**

Primero debes clonar el repositorio de este proyecto, puedes hacerlo de la siguiente manera:

    $ git clone https://github.com/ger-rinaldi/promanager.git /path/destino/proyecto

Y debes dirigirte al directorio donde clonaste el repositorio

    $ cd /path/destino/proyecto

2. **Crear el entorno virtual**

Luego, dentro del directorio del proyecto, debemos crear un entorno virtual, de tal modo que quede en el mismo nivel que los siguientes archivos:

    promanager
    ├── README.md
    ├── requirements.txt
    ├── TODO.md
    ├── app
    └── venv <--- aquí debería quedar!
 
Existen dos alternativas:

- Instalacion con virtualenv

        ../promanager$ virtualenv venv

- Instalacion con el módulo venv

        # para Linux
        ../promanager$ python3 -m venv venv
        # para Windows
        ../promanager$ python -m venv venv

Una vez creado el entorno virtual es necesario activarlo.

Para Linux:

    ../promanager$ source ./venv/bin/activate

Para Windows:

    ../promanager$ venv/Scripts/activate.bat

3. **Instalar dependencias de requirements.txt**

Ahora es necesario instalar las dependencias del proyecto

    ../promanager$ pip install -r requirements.txt

4. **Crear el archivo de configuración de proyecto `config.py`**

A continuación ingresa al directorio `app`

    ../promanager$ cd app

Este proyecto requiere un archivo esencial, que se ha excluido del control de versiones, este debe llamarse sí o sí `config.py` y estar situada en `promanager/app`

    ../promanager/app$ touch config.py

Y ahora con tu editor de textos favorito, copia y pega lo siguiente y reemplaza los valores que sea necesario reemplazar:

    DB_NAME = "promanager"
    TEST_DB = "testpromanager"
    DOMAIN = "localhost"

    DB_CONFIG = {
        "host": DOMAIN,
        "user": "tu_nombre_de_usuario", <--- reemplazar por tu nombre de usuario de mysql
        "password": "la_contraseña_de_tu_usuario", <--- reemplazar por tu contraseña de mysql
        "port": 3306,
    }

    APP_CONFIG = {
        "hostname": DOMAIN,
        "port": 5000,
        "use_debugger": True,
        "use_reloader": True,
    }

De ser necesario, tambien puedes alterar los puertos de cada configuración, el de MySQL dependerá de en que puerto tengas a tu RDBMS, mientras que el de APP solo es necesario que sea un puerto para el que tengas permiso de utilización.

5. **Levantar la DB**

Para levantar la base de datos debes tomar los contenidos de schema.sql y ejecutarlos mediante MySQL, como en el punto anterior, por el medio de tu preferencia (workbench u otras GUIs para MySQL o la app CLI de MySQL)