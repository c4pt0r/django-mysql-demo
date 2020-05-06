#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
APP_DIR=${DIR}/app
MYSQL_DJANGO_PASSWORD=admin

log ()
{
        timestamp=$(date +"%Y-%m-%dT%H:%M:%S")
        echo "[${timestamp}] $1"
}

setup_application()
{
  pip install -r requirements.txt

  python manage.py migrate

  cat <<EOF | python manage.py shell
from django.contrib.auth.models import User

if not User.objects.filter(is_superuser=True):
  User.objects.create_superuser('admin', 'admin@example.com', '${MYSQL_DJANGO_PASSWORD}')

EOF

}

run_application()
{
  setup_application
  python manage.py runserver 0.0.0.0:8000
}

pushd ${APP_DIR} > /dev/null

run_application

popd > /dev/null
