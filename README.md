# djapp - Clean Django App Template
This project meant to be re-usable for starting Django projects.
Its goal is to provide infrastructure for environment separation (DEV, TEST, PROD)
and implement DevOps best practices and easy of deployment (such as Docker, Docker-Compose, Azure DevOps, etc.).

## How to run
Run the containerized infrastructure:<br>
```docker-compose up```<br><br>

If you are testing the web app locally, run:<br>
```python manage.py runserver```<br><br>

If you want to run just the web app container using Docker, build and run:<br>
```
docker build -t djapp .
docker run -p 8000:8000 djapp
```