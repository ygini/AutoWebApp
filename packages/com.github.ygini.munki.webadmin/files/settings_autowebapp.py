import ConfigParser
import os 

config_path=os.path.dirname(os.path.realpath(__file__))+"/settings.ini"
settings = ConfigParser.SafeConfigParser()
settings.read(config_path)

SECRET_KEY = settings.get('django','secret_key')

MUNKI_REPO_DIR = settings.get('munki','path')

TIME_ZONE = settings.get('munkiwebadmin','timezone')
WARRANTY_LOOKUP_ENABLED = settings.getboolean('munkiwebadmin','warranty')
MODEL_LOOKUP_ENABLED = settings.getboolean('munkiwebadmin','model')

PROXY_ADDRESS = settings.get('munkiwebadmin','proxy')
