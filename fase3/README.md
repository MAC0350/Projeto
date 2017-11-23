# Project Management System

## Usage

### Virtualenv

1. Install the virtualenv package for Python 3:

        $ pip3 install virtualenv

2. Run the [pyenv](pyenv) script to configure a Python3 virtual environment and install [project dependencies](doc/requirements.txt).

        $ ./pyenv

3. Activate the virtual environment from the created `bin/` directory:

        $ source bin/activate


4. You can deactivate the virtual environment anytime with the following command:

        $ deactivate

### Postgresql & Django

Export the following environment variables:

- `DATABASE_NAME`: Name of your Postgresql database.
- `DATABASE_USER`: Your Postgresql database user.
- `DATABASE_PASSWORD`: Password for your Postgresql database user.
- `DATABASE_HOST`: Postgresql host name.
