############################################
# Backup do banco Mysql
# Jorge Luiz Taioque
#
# Uso das váriaveis
#---------------------------
# usuario - usuario do banco de dados
# senha - senha do banco de dados
# copias - quantidade de copias que devem ser guardadas
# diretorio - diretorio que ficara salvo os bakcups
#
############################################

#VARIAVEIS DO AMBIENTE
usuario=root
senha=1234
copias=5
diretorio=/home/backup
 
find $diretorio -mtime +$copias > $diretorio/old_backups.txt
 
find $diretorio -mtime +$copias -type f -exec rm -rf {} \; 
 
mysql -u $usuario -p$senha -Bse 'show databases' > $diretorio/databases.txt;
 
mkdir $diretorio/backup_databases;
 
data=$( date +%d-%m-%Y)
 
for i in $(cat $diretorio/databases.txt); do
if [ "$i" != "information_schema" ]
then
 
    mysqldump -u $usuario -p$senha $i > $diretorio/backup_databases/$i-backup.sql;
 
fi
 
done
 
tar zcvf $diretorio/backup_mysql_$data.tar.gz $diretorio/backup_databases;
 
rm -r $diretorio/databases.txt;
rm -r $diretorio/backup_databases;
