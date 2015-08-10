import os
import site
import sys

INSTALLATION_PATH = os.path.dirname(os.path.realpath(__file__))

sys.path.insert(1, os.path.join(INSTALLATION_PATH))
sys.path.insert(2, os.path.join(INSTALLATION_PATH, 'munkiwebadmin'))
sys.path.insert(3, os.path.join(INSTALLATION_PATH, 'munkiwebadmin_env'))

virtual_env_lib_path = os.path.join(INSTALLATION_PATH, 'munkiwebadmin_env', 'lib')
for python_dir in os.listdir(virtual_env_lib_path):
    site_packages_dir = os.path.join(virtual_env_lib_path, python_dir, 'site-packages')
    if os.path.exists(site_packages_dir):
        site.addsitedir(os.path.abspath(site_packages_dir))

from django.core.handlers.wsgi import WSGIHandler
os.environ['DJANGO_SETTINGS_MODULE'] = 'settings'
application = WSGIHandler()