# todo-flutter-django
A To-do app made in Flutter with Riverpod state management and django backend using REST api.

## Steps to setup and run the project locally on your machine.

* Clone the Repository and cd into the project.
``` shell
git clone https://github.com/purveshxd/todo-flutter-django.git
cd todo-flutter-django
```

* Now, cd into the **backend** folder. **Install django** and set up the environment.
``` shell
cd .\backend_todo\
pip3 install pipenv
pipenv install django
pipenv shell
```

* Now, Run **'ipconfig'** to get your IPv4 address and copy it.

* Now, cd into the django app directory **'backend_todo'**. Open up **'settings.py'** file and look for **'ALLOWED_HOSTS = ['XXX.X.X.X','XXX.X.X.X']'**, **Paste** your IPv4 address in the ALLOWED_HOSTS. For eg: -
``` shell
ALLOWED_HOSTS = ['XXX.X.X.X', 'XXX.X.X.X', 'YOUR IPv4 Address comes here']
```

* Now, navigate back to the root directory.
``` shell 
cd ..
```

* cd into the App folder **'todo_with_django'**, then into **'lib'** folder and then into **'repo'** folder.
``` shell
cd todo_with_django
cd lib
cd repo
```

* Open **'todo_api.dart'** and in the **'String url'** add your IPv4 address.
``` shell
String url = "http://YOUR_IPv4_ADDRESS:8000/";
```

* Final step, Run the server
``` shell
cd ..
cd .\backend_todo\
py manage.py runserver 0.0.0.0:8000
```
