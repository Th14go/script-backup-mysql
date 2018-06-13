#!/bin/sh
#Backup Databases MySQL C/ LOGS -- Criado por: Th14go
#GITHUB- https://github.com/Th14go/script-bck-mysql

DATA=`date +%Y-%m-%d-%H.%M`

#Local onde o arquivo de log sera armazenado.
SYNC_LOG=/var/log/bckmysql/bckmysql$DATA.log

#Variáveis para SQL dos BCK
BASEI="/mnt/backup/MySQL/BASEI-$DATA.sql"
BASEII="/mnt/backup/MySQL/BASEII-$DATA.sql"
BASEIII="/mnt/backup/MySQL/BASEIII-$DATA.sql"
BASEIV="/mnt/backup/MySQL/BASEIV-$DATA.sql"
BASEV="/mnt/backup/MySQL/BASEV-$DATA.sql"

#Variáveis do MySQL#
HOST="localhost"
USER="root"
PASSWORD="suasenha"

#DATABASES#
DATABASEI="BASEI"
DATABASEII="BASEII"
DATABASEIII="BASEIII"
DATABASEIV="BASEIV"
DATABASEV="BASEV"

#EXECUTANDO BACKUP DE DATABASEI#
echo "******************************" >> $SYNC_LOG
echo "Inicio do Backup Database BASEI" >> $SYNC_LOG
date >> $SYNC_LOG
mysqldump --routines --triggers -h $HOST -u $USER -p$PASSWORD $DATABASEI > $BASEI
echo "Fim do Backup da  Database BASEI" >> $SYNC_LOG
date >> $SYNC_LOG
echo "******************************" >> $SYNC_LOG
echo "Inicio do Backup Database BASEII" >> $SYNC_LOG
date >> $SYNC_LOG
#EXECUTANDO BACKUP DE DATABASEII#
mysqldump --routines --triggers -h $HOST -u $USER -p$PASSWORD $DATABASEII > $BASEII
echo "Fim do Backup da  Database BASEII" >> $SYNC_LOG
date >> $SYNC_LOG
echo "******************************" >> $SYNC_LOG
echo "Inicio do Backup Database BASEIII" >> $SYNC_LOG
date >> $SYNC_LOG
#EXECUTANDO BACKUP DE DATABASEIII#
mysqldump --routines --triggers -h $HOST -u $USER -p$PASSWORD $DATABASE3 > $OFICIO
echo "Fim do Backup da  Database Oficio" >> $SYNC_LOG
date >> $SYNC_LOG
echo "******************************" >> $SYNC_LOG
echo "Inicio do Backup Database OpenFire" >> $SYNC_LOG
date >> $SYNC_LOG
#EXECUTANDO BACKUP DE DATABASE OPENFIRE#
mysqldump --routines --triggers -h $HOST -u $USER -p$PASSWORD $DATABASE4 > $OPENFIRE
echo "Fim do Backup da  Database OpenFire" >> $SYNC_LOG
date >> $SYNC_LOG
echo "******************************" >> $SYNC_LOG
echo "Inicio do Backup Database Zabbix" >> $SYNC_LOG
date >> $SYNC_LOG
#EXECUTANDO BACKUP DE DATABASE ZABBIX#
mysqldump --routines --triggers -h $HOST -u $USER -p$PASSWORD $DATABASE5 > $ZABBIX
echo "Fim do Backup da  Database Zabbix" >> $SYNC_LOG
date >> $SYNC_LOG
echo "******************************" >> $SYNC_LOG

#Compacta Databases Mysql#
echo "******************************" >> $SYNC_LOG
echo "Inicio da compactacao do Backup Brcom" >> $SYNC_LOG
date >> $SYNC_LOG
echo "******************************" >> $SYNC_LOG
cd /mnt/backup/MySQL/
tar -cvzf DATABASES-$DATA.tar.gz *sql 
echo "******************************" >> $SYNC_LOG
echo "Fim da compactacao Brcom" >> $SYNC_LOG
date >> $SYNC_LOG
echo "******************************" >> $SYNC_LOG

#Deleta Arquivos SQL  Databases#

rm  -rvf /mnt/backup/MySQL/*.sql

#Sincroniza com diretorio do servidor em diretorio remoto os LOGS#
rsync -Cravp /var/log/bckmysql /mnt/backup/LOG/

#Apagando-Backup-com+de10dias
echo "***********INICIO REMOÇÃO REMOTA***************">>$SYNC_LOG
date >> $SYNC_LOG
find /mnt/backup/MySQL -mtime +10 -fprint /mnt/backup/LOG/logdelete`date +%F`.txt  -exec rm -rf {} \; >>$SYNC_LOG
date >> $SYNC_LOG
echo "**********FIM REMOÇÃO REMOTA*******************">>$SYNC_LOG
