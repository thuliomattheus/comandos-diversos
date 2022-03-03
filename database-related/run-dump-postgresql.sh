#/usr/bin
sudo -u postgres psql postgres --command="drop database meu_banco;"
sudo -u postgres psql postgres --command="create database meu_banco;"
sudo -u postgres psql postgres -d meu_banco -a -f dump.sql
