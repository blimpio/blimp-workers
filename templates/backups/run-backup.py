import os
import urlparse
import subprocess
import smtplib
import getpass
import re
from email.mime.text import MIMEText

import pyrax


env_file = '/home/ubuntu/blimp.env'


def run():
    print('---> Getting latest backup of {}...'.format(heroku_app_name))
    latest_backup_url = subprocess.check_output(
        ['heroku', 'pgbackups:url', '-a', heroku_app_name])
    file_name = os.path.basename(urlparse.urlparse(latest_backup_url).path)
    backup_path = '{}/{}'.format(backups_directory, file_name)

    pyrax.settings.set('identity_type', 'rackspace')
    pyrax.set_credentials(rackspace_username, rackspace_api_key)
    cf = pyrax.cloudfiles

    cont_name = '{}-backups'.format(heroku_app_name)
    cont = cf.create_container(cont_name)

    try:
        print('---> Checking if {} already exists...'.format(file_name))
        cont.get_object(file_name)
        print('---> {} is already backed up...'.format(file_name))
    except pyrax.exceptions.NoSuchObject:
        print('---> Downloading {}...'.format(file_name))
        subprocess.call(['curl', '-o', backup_path, latest_backup_url])

        try:
            print('---> Verifying {}...'.format(file_name))
            subprocess.call([
                'pg_restore', '--clean', '--no-acl', '--no-owner',
                '--username', db_username,
                '--dbname', db_name,
                '--schema', 'public',
                backup_path
            ])

            print('---> Uploading {}...'.format(file_name))
            cf.upload_file(cont, open(backup_path), obj_name=file_name)

            msg = 'Just verified and backed up {}'.format(file_name)
            print('---> {}...'.format(msg))
        except Exception as e:
            send_email('Backup failed', str(e))

        print('---> Deleting local backup file {}...'.format(file_name))
        subprocess.call(['rm', backup_path])

    print('---> Done!')


def send_email(subject, error_message):
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(email, password)

    msg = MIMEText(error_message)
    msg['From'] = email
    msg['To'] = recipient_email
    msg['Subject'] = subject

    server.sendmail(email, [msg['To']], msg.as_string())

    server.quit()


def set_env():
    try:
        with open(env_file) as f:
            content = f.read()
    except IOError:
        content = ''

    for line in content.splitlines():
        m1 = re.match(r'\Aexport ([A-Za-z_0-9]+)=(.*)\Z', line)
        if m1:
            key, val = m1.group(1), m1.group(2)
            m2 = re.match(r"\A'(.*)'\Z", val)
            if m2:
                val = m2.group(1)
            m3 = re.match(r'\A"(.*)"\Z', val)
            if m3:
                val = re.sub(r'\\(.)', r'\1', m3.group(1))
            os.environ.setdefault(key, val)


if __name__ == '__main__':
    set_env()

    heroku_app_name = os.environ['HEROKU_APP_NAME']
    rackspace_username = os.environ['RACKSPACE_USERNAME']
    rackspace_api_key = os.environ['RACKSPACE_API_KEY']
    backups_directory = os.path.dirname(os.path.realpath(__file__))

    email = os.environ['BACKUP_EMAIL']
    password = os.environ['BACKUP_EMAIL_PASSWORD']
    recipient_email = os.environ['BACKUP_RECIPIENT_EMAIL']

    db_username = getpass.getuser()
    db_name = db_username

    run()
