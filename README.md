# djapp - Clean Django App Template
This project meant to be re-usable for starting Django projects.
Its goal is to provide infrastructure for environment separation (DEV, TEST, PROD)
and implement DevOps best practices and easy of deployment (such as Docker, Docker-Compose, Azure DevOps, etc.).

## How to run
Run the containerized infrastructure (entrypoint.sh needs to be executable):<br>
```
chmod +x entrypoint.sh
docker-compose up
```

If you are testing the web app locally, run:<br>
```python manage.py runserver```<br><br>
If you want to run just the web app container using Docker, build and run:<br>
```
docker build -t djapp .
docker run -p 8000:8000 djapp
```

## Environments
### DEV
DEV environment is meant to represent a local developer programming and testing
on their own machine. Simply running `python manage.py runserver` will start
the web app on local interface and will be accessible on http://localhost:8000/.
If you need to migrate the database (typically after models changes), run:
```
python manage.py makemigrations
python manage.py migrate
```
Django settings are coming from base.py and dev.py in the settings folder. 
The database is a local flat file stored in the data folder (dev.sqlite3).


### TEST
TEST environment is meant to be deployed to a test container and running in a 
commonly-accessible location such as AWS ECS (Elastic Container Service) while 
Docker image is stored in an image repository such as AWS ECR (Elastic Container Registry)

TEST settings are base.py and test.py in the settings folder. Database is still a
flat file but web service is meant to be accessible wherever firewall allows, not
limited by Django network control (ALLOWED_HOSTS = ['*']).

If you would like to run the Docker container locally, build and run like this,
additional settings could be passed in - specifying TEST settings:
```
docker build --build-arg DJANGO_SETTINGS_MODULE_ARG=djapp.settings.test -t djapp . 
docker run -p 8000:8000 djapp
```


### PROD
PROD environment meant to represent closest architecture to actual production.
The PROD settings are base.py + prod.py with specified remote database.
Database connection variables are supplied via ```--build-arg``` which become 
environmental variables inside Docker.

Other Django configurations are changed to fit into the production model.
Deployment goes to AWS ECR and ECS with production Postgresql database manually configured.


## DevSecOps
The whole Azure DevOps build and deployment is specified in azure-pipelines.yml YAML file.
Variables are stored in Azure DevOps variables library. At least the following variables are stored under ```AWS_ECR_Credentials``` 
variable group:
```
AWS_ACCESS_KEY_ID, AWS_ACCOUNT_ID, AWS_REGION, AWS_SECRET_ACCESS_KEY, DB_HOST, DB_NAME, 
DB_PASSWORD, DB_PORT, DB_USER, ECR_REPOSITORY, ECS_CLUSTER, ECS_SERVICE, ECS_TASK
```
