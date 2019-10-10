import pytest
import re

def test_user_sjobs(host):
    assert host.user('sjobs')
    assert host.user('sjobs').uid == 2011
    assert host.user('sjobs').shell == '/usr/sbin/nologin'
    assert 'sudo' in host.user('sjobs').groups

def test_folder_etc_etera(host):
    assert host.file('/etc/etera').exists
    assert host.file('/etc/etera').is_directory
    assert host.file('/etc/etera').user == 'sjobs'
    assert oct(host.file('/etc/etera').mode) == '0o750'

def test_crontab_sjobs(host):
    assert host.file('/var/spool/cron/crontabs/sjobs').exists
    assert host.file('/var/spool/cron/crontabs/sjobs').contains('0 17 \* \* 2 /bin/thinkdifferent')

def test_01(host):
    host_vars = host.ansible.get_variables()
    if host_vars['inventory_hostname'] in ['node1', 'node2', 'node3']:
        expected = 'web'
    else:
        expected = 'controller'
    assert expected in host_vars['group_names']

def test_04(host):
    inventory_hostname = host.ansible.get_variables()['inventory_hostname']
    motd_string = "Bienvenue sur {}\n".format(str(inventory_hostname))
    assert host.file("/etc/motd").contains(motd_string)

def test_05(host):
    assert host.package("htop").is_installed

def test_06_1(host):
    assert host.package("apache2").is_installed

def test_06_2(host):
    index_html = host.file("/var/www/html/index.html")
    assert index_html.contains("<title>Ansible</title>")

def test_06_3(host):
    index_html = host.file("/var/www/html/index.html")
    assert index_html.user == "www-data"
    assert index_html.group == "www-data"

def test_06_4(host):
    service = host.service('apache2')
    assert service.is_running
    assert service.is_enabled

def test_07_1(host):
    inventory_hostname = host.ansible.get_variables()['inventory_hostname']
    if inventory_hostname == "node3":
        expected = "prod"
    else:
        expected = "dev"
    assert host.ansible.get_variables()['env'] == expected

def test_07_2(host):
    inventory_hostname = host.ansible.get_variables()['inventory_hostname']
    if inventory_hostname == "node2":
        expected = "mariadb"
    else:
        expected = "mysql"
    assert host.ansible.get_variables()['bdd_engine'] == expected

def test_07_3(host):
    inventory_hostname = host.ansible.get_variables()['inventory_hostname']
    if inventory_hostname == "node3":
        expected = "prod"
    else:
        expected = "dev"
    index_html = host.file("/etc/motd")
    assert index_html.contains(expected)

def test_08_1(host):
    expected = host.ansible.get_variables()['local_bdd']
    assert host.package("mysql-server").is_installed == expected

def test_09_1(host):
    assert host.user('user1')
    assert host.user('user1').uid == 2001

def test_09_2(host):
    assert host.user('user2')
    assert host.user('user2').uid == 2002

def test_09_3(host):
    assert host.user('user3')
    assert host.user('user3').uid == 2003

def test_10_1(host):
    assert host.socket("tcp://0.0.0.0:8080").is_listening
    assert host.service("apache2").is_running

def test_11_1(host):
    inventory_hostname = host.ansible.get_variables()['inventory_hostname']
    if inventory_hostname == "node1":
        color = "blue"
    elif inventory_hostname == "node2":
        color = "magenta"
    elif inventory_hostname == "node3":
        color = "cyan"
    file = host.file("/home/ansible/.bash_profile")
    expected_string = '${}'.format(color)
    assert file.exists
    assert file.contains(expected_string)

def test_12_1(host):
    assert host.package("mysql-server").is_installed
    service = host.service('apache2')
    assert service.is_running
    assert service.is_enabled

def test_12_2(host):
    cmd = host.run("mysql -u appuser -pnotsosecure -e ';'")
    assert cmd.rc == 0

def test_12_3(host):
    expected = "GRANT SELECT, INSERT, UPDATE, DELETE ON `app`.* TO 'appuser'@'localhost'"
    cmd = host.run("mysql -e 'SHOW GRANTS for appuser@localhost;'")
    assert expected in cmd.stdout
