# ansible-jboss-domain
Ansible JBoss EAP 7.1 Domain Playbook

# Preparacion
```
yum install --nogpgcheck -y java-1.8.0-openjdk-devel
copiar ssh-keys desde maquina de control
```
## Limpieza
```
killall java; rm -rf /opt/jboss-eap/ /etc/jboss-as /etc/systemd/system/jboss-eap.service /var/log/jboss-eap/ /etc/default/jboss-eap.conf ; ps -fea |grep java	
```
