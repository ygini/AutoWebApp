#!/usr/bin/env python

import os
import sys
import argparse
import subprocess
import ConfigParser
import json
import urllib2
import tempfile
import tarfile

class WebApp:
    package_path=""
    ini_settings_relative_path=""
    ini_settings_path=""
    installation_path=""
    exchange_file=""
    arg_key=""
    arg_value=""
    parser=argparse.ArgumentParser(description='Install the package.')
    commands=dict()

    def __init__(self, package_path, ini_settings_relative_path="settings.ini"):
        self.package_path = package_path
        self.ini_settings_relative_path = ini_settings_relative_path
        self.parser.add_argument('-p','--path', help='Deployment path', required=True)
        self.parser.add_argument('-c','--command', help='Command (install, remove, set, get)', required=True)
        self.parser.add_argument('-k','--key', help='The key to work with (commands: get, set)', required=False)
        self.parser.add_argument('-s','--set', help='The value to set (command: set)', required=False)
        self.parser.add_argument('-f','--file', help='Temp file path used for file content exchange with autowebapp', required=False)

        self.sendCommandTo("install", WebApp.do_install)
        self.sendCommandTo("remove", WebApp.do_remove)
        self.sendCommandTo("get", WebApp.do_get)
        self.sendCommandTo("set", WebApp.do_set)
        self.sendCommandTo("unset", WebApp.do_unset)
        self.sendCommandTo("httpd24", WebApp.do_httpd24)
        self.sendCommandTo("httpd22", WebApp.do_httpd24)
        self.sendCommandTo("webapp", WebApp.do_webapp)

    def run(self):
        args = vars(self.parser.parse_args())

        self.installation_path = args['path']
        self.ini_settings_path = os.path.join(self.installation_path, self.ini_settings_relative_path)
        self.arg_key = args['key']
        self.arg_value = args['set']
        self.exchange_file = args['file']

        command = args['command']
        if self.commands.has_key(command):
            self.commands.get(command)(self)
        else:
            print "Unsupported command "+command


    def sendCommandTo(self, command, function):
        self.commands[command] = function

    def do_remove(self):
        for root, dirs, files in os.walk(self.installation_path, topdown=False):
            for name in files:
                path = os.path.join(root, name)
                if os.path.islink(path):
                    os.unlink(path)
                else:
                    os.remove(path)
            for name in dirs:
                path = os.path.join(root, name)
                if os.path.islink(path):
                    os.unlink(path)
                else:
                    os.rmdir(path)

    def do_install(self):
        src_path = os.path.join(self.package_path,'scripts')
        folder_content = os.listdir(src_path)
        folder_content.sort()
        for script in folder_content:
            script_path = os.path.join(src_path, script)
            if os.access(script_path, os.X_OK):
                self.do_run_script(script_path)

    def do_run_script(self, script_path):
        print "Subscript "+os.path.basename(script_path)
        process_args = [script_path, self.installation_path]
        process = subprocess.Popen(process_args, env=dict(os.environ, PYTHONPATH=':'.join(sys.path)))
        process.wait()
        if not process.returncode == 0:
            print "Error when running subscript "+script_path
            sys.exit(1)

    def do_set(self):
        config_path=self.ini_settings_path
        settings = ConfigParser.SafeConfigParser()
        settings.read(config_path)

        if self.arg_key and self.arg_value:
            parts = self.arg_key.split('.')
            partsCount = len(parts)
            if partsCount == 2:
                if not settings.has_section(parts[0]):
                    settings.add_section(parts[0])
                settings.set(parts[0], parts[1], self.arg_value)
                print settings.get(parts[0], parts[1])
                f = open(config_path, 'w')
                settings.write(f)
                f.close()
            else:
                print "Invalid key format"
        else:
            print "You must specify a key (-k) and a value (-s) to set"

    def do_unset(self):
        config_path=self.ini_settings_path
        settings = ConfigParser.SafeConfigParser()
        settings.read(config_path)

        if self.arg_key:
            parts = self.arg_key.split('.')
            partsCount = len(parts)
            if partsCount == 1:
                settings.remove_section(parts[0])
            elif partsCount == 2:
                settings.remove_option(parts[0], parts[1])
            else:
                print "Invalid key format"
        else:
            print "You must specify a key"

        f = open(config_path, 'w')
        settings.write(f)
        f.close()

    def do_get(self):
        config_path=self.ini_settings_path
        settings = ConfigParser.SafeConfigParser()
        settings.read(config_path)

        if self.arg_key:
            parts = self.arg_key.split('.')
            partsCount = len(parts)
            if partsCount == 1:
                for variable in settings.options(parts[0]):
                    print "{} {}".format((parts[0] + "." + variable).ljust(40),settings.get(parts[0], variable).ljust(40))
            elif partsCount == 2:
                if settings.has_option(parts[0], parts[1]):
                    print settings.get(parts[0], parts[1])
            else:
                print "Invalid key format"
        else:
            for section in settings.sections(self):
                for variable in settings.options(section):
                    print "{} {}".format((section + "." + variable).ljust(40),settings.get(section, variable).ljust(40))


    def do_httpd24(self):
        if self.exchange_file:
            httpd_src = os.path.join(self.package_path, 'files', 'httpd24.conf')
            with open(httpd_src) as f:
                httpd_conf = f.read()
            httpd_conf = httpd_conf.replace('%%INSTALLATION_ROOT%%', self.installation_path)
            with open(self.exchange_file, 'w') as f:
                f.write(httpd_conf)
        else:
            print "A writable file path must be specified with -f option."


    def do_httpd22(self):
        if self.exchange_file:
            httpd_src = os.path.join(self.package_path, 'files', 'httpd22.conf')
            with open(httpd_src) as f:
                httpd_conf = f.read()
            httpd_conf = httpd_conf.replace('%%INSTALLATION_ROOT%%', self.installation_path)
            with open(self.exchange_file, 'w') as f:
                f.write(httpd_conf)
        else:
            print "A writable file path must be specified with -f option."

    def do_webapp(self):
        if self.exchange_file:
            webapp_src = os.path.join(self.package_path, 'files', 'webapp.plist')
            with open(webapp_src) as f:
                webapp_conf = f.read()
            webapp_conf.replace('%%INSTALLATION_ROOT%%', self.installation_path)
            with open(self.exchange_file, 'w') as f:
                f.write(webapp_conf)
        else:
            print "A writable file path must be specified with -f option."

    def download_last_tarball_release_from(self, owner, project):
        target_url = "https://api.github.com/repos/"+owner+"/"+project+"/releases/latest"
        print "Getting info from", target_url
        data = json.load(urllib2.urlopen(target_url))
        url = data['tarball_url']
        print "Downloading last tarbal at", url
        try:
            dl = urllib2.urlopen(url)
            with tempfile.NamedTemporaryFile() as local_file:
                local_file.write(dl.read())
                archive = tarfile.open(local_file.name, 'r')
                print archive.getnames()
                print "Extrating archive"
                archive.extractall(os.path.join(self.installation_path, 'archive_content'))
        except urllib2.HTTPError, e:
            print "HTTP Error:", e.code, url
        except urllib2.URLError, e:
            print "URL Error:", e.reason, url
        except tarfile.TarError, e:
            print "Extraction error:", e.reason
        except:
            pass