#!/usr/bin/python
# -*- coding: UTF-8 -*-
#
# Copyright © 2013 by Adam Hellberg <adam.hellberg@sharparam.com>.
#

import io
import os
import re
import sys
import json
import fnmatch
import zipfile
from httplib import HTTPConnection
from mimetools import choose_boundary

SCRIPT = sys.argv[0]

if len(sys.argv) < 3:
    print '{0}: expected args: name, build number'.format(SCRIPT)
    sys.exit(1)

name = None
build = None

try:
    name = str(sys.argv[1])
    build = int(sys.argv[2])
except ValueError:
    print "{0}: expected build number argument of type integer".format(SCRIPT)
    sys.exit(1)

api_key = None

try:
    api_key = open('cfapikey').read()
except:
    print "{0}: failed to read API key from file".format(SCRIPT)
    sys.exit(1)

headers = {
    'User-Agent': 'Sharparam Uploader Script/1.0',
    'X-API-Key': api_key
}

print "{0}: Cleaning build directory".format(SCRIPT)
if os.path.isdir('build'):
    for f in os.listdir('build'):
        fp = os.path.join('build', f)
        try:
            if os.path.isfile(fp):
                os.unlink(fp)
        except Exception, e:
            print "{0}: EXCEPTION: Failed to delete {1}: {2}".format(SCRIPT, fp, e)
elif os.path.isfile('build'):
    os.unlink('build')
    os.makedirs('build')
else:
    os.makedirs('build')
print "{0}: Build directory cleanup completed!".format(SCRIPT)

ignored = ['/.*', SCRIPT]

try:
    for line in open('.gitignore').read().splitlines():
        ignored.append(line)
except Exception, e:
    print "{0}: failed to read .gitignore: {1}".format(SCRIPT, e)

def is_file_ignored(file):
    for pattern in ignored:
        if os.name == 'nt':
            pattern = pattern.replace('/', '\\')
        if re.search(fnmatch.translate(pattern), file):
            return True
    return False

def get_game_version(interface_version):
    interface_version = int(interface_version)
    print "{0}: querying CurseForge for info about interface version {1}".format(SCRIPT, interface_version)
    conn = HTTPConnection('wow.curseforge.com')
    conn.request('GET', '/game-versions.json')
    response = conn.getresponse()
    assert response.status == 200, "/game-versions.json returned invalid response code"
    assert response.getheader('Content-Type') == 'application/json', "/game-versions.json returned invalid content type"
    print "{0}: get_game_version: CurseForge responded with status code {1}".format(SCRIPT, response.status)
    data = json.load(response)
    for i in data:
        ver = data[i]
        internal_id = int(ver['internal_id'])
        print "{0}: reading game version {1} with internal id {2}".format(SCRIPT, i, internal_id)
        if internal_id == interface_version:
            return i, ver
    return None, None

def make_zip(src, dst):
    ignored.append(dst)
    print "{0}: Zipping {1} into {2}".format(SCRIPT, src, dst)
    zf = zipfile.ZipFile(dst, 'w')
    abs_src = os.path.abspath(src)
    for dirname, subdirs, files in os.walk(src):
        for filename in files:
            absname = os.path.abspath(os.path.join(dirname, filename))
            if not is_file_ignored(absname):
                arcname = os.path.join(name, absname[len(abs_src) + 1:])
                print "{0} -> {1}".format(os.path.join(dirname, filename), arcname)
                zf.write(absname, arcname)
    zf.close()
    print "{0}: DONE! Zip successfully created: {1}!".format(SCRIPT, dst)

def encode_multipart_formdata(fields, files):
    boundary = choose_boundary()
    L = []
    
    for key, value in fields:
        if value is None:
            value = ''
        elif value is False:
            continue
        L.append('--{0}'.format(boundary))
        L.append('Content-Disposition: form-data; name="{0}"'.format(key))
        L.append('')
        L.append(str(value))
    
    for key, filename in files:
        f = file(filename, 'rb')
        filedata = f.read()
        f.close()
        L.append('--{0}'.format(boundary))
        L.append('Content-Disposition: form-data; name="{0}"; filename="{1}"'.format(key, os.path.basename(filename)))
        L.append('Content-Type: application/zip')
        L.append('')
        L.append(filedata)
    L.append('--{0}--'.format(boundary))
    L.append('')
    body = '\r\n'.join(L)
    content_type = 'multipart/form-data; boundary={0}'.format(boundary)
    return content_type, body

def upload_zip(zip, ver_name, slug, game_ver_id, ver_type):
    print "{0}: Uploading {1} to CurseForge...".format(SCRIPT, zip)
    print "{0}: Version name: {1}; Slug: {2}; GameVersion: {3}; VersionType: {4}".format(SCRIPT, ver_name, slug, game_ver_id, ver_type)
    github_url = "https://github.com/Sharparam/{0}".format(name)
    zip_path = os.path.abspath(zip)
    assert len(api_key) == 40
    assert ver_type in ('r', 'b', 'a')
    assert os.path.exists(zip_path)
    params = []
    params.append(('name', ver_name))
    params.append(('game_versions', game_ver_id))
    params.append(('file_type', ver_type))
    params.append(('change_log', github_url))
    params.append(('change_markup_type', 'plain'))
    params.append(('known_caveats', "{0}/issues".format(github_url)))
    params.append(('caveats_markup_type', 'plain'))
    content_type, body = encode_multipart_formdata(params, [('file', zip_path)])
    upload_headers = {
        'User-Agent': headers['User-Agent'],
        'Content-Type': content_type,
        'X-API-Key': api_key
    }
    conn = HTTPConnection('wow.curseforge.com')
    conn.request('POST', "/addons/{0}/upload-file.json".format(slug), body, upload_headers)
    response = conn.getresponse()
    if response.status == 201:
        print "{0}: SUCCESS! {1} has been uploaded to CurseForge!".format(SCRIPT, zip)
    elif response.status == 422:
        assert response.getheader('Content-Type') == 'application/json'
        errors = json.load(response)
        print "{0}: ERROR: Form error while uploading:".format(SCRIPT)
        for key, items in errors.iteritems():
            for item in items:
                print "{0}:      {1}: {2}".format(SCRIPT, key, item)
    else:
        print "{0}: ERROR: Unknown error while uploading {1}: {2} ({3})".format(SCRIPT, zip, response.status, response.reason)

toc_regex = re.compile(r"^## ([\w\d\-]+): (.*)$", re.I)
a_regex = re.compile(r"^\d+\.\d+\.\d+\-alpha$")
b_regex = re.compile(r"^\d+\.\d+\.\d+\-beta")
r_regex = re.compile(r"^\d+\.\d+\.\d+$")

toc_file = name + '.toc'
toc_data = {}
toc_handle = open(toc_file, 'r')
interface = None
version = None

for line in toc_handle.readlines():
    match = toc_regex.match(line)
    if match:
        key = match.group(1)
        value = match.group(2)
        toc_data[key] = value
        if key == 'Interface':
            interface = value
        elif key == 'Version':
            version = value

game_version_id, game_version = get_game_version(interface)
assert game_version_id != None, "get_game_version returned None for id!"
assert game_version != None, "get_game_version returned None for version!"

ver_type = None


if a_regex.match(version) or game_version['is_development']:
    ver_type = 'a'
    if game_version['is_development']:
        version = version + '-PTR'
elif b_regex.match(version):
    ver_type = 'b'
elif r_regex.match(version):
    ver_type = 'r'
else:
    ver_type = 'a'
    version = version + '-DEV'

friendly_version_name = "v{0}-#{1}".format(version, build)

zipname = "build/{0}-{1}-{2}-WoW{3}.zip".format(name, version, build, game_version['name'])

make_zip('.', zipname)

slug = toc_data['X-Project-Slug']

upload_zip(zipname, friendly_version_name, slug, game_version_id, ver_type)
