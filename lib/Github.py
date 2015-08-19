__author__ = 'yoanngini'

import json
import urllib2
import tempfile
import tarfile

def download_last_tarball_release_from(owner, project):
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
            archive.extractall()
            print archive.list()
    except urllib2.HTTPError, e:
        print "HTTP Error:", e.code, url
    except urllib2.URLError, e:
        print "URL Error:", e.reason, url
    except tarfile.TarError, e:
        print "Extraction error:", e.reason