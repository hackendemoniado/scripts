#/bin/bash
unahoramenos=`date +%R --date='-1 hours'`
horaactual=`date +%R`
lastb -s $unahoramenos -t $horaactual | grep root > /tmp/loginfailsroot.txt
cantfail=`wc -l /tmp/loginfailsroot.txt > /tmp/cantfailroot.txt`
contador=`awk '{print $1}' /tmp/cantfailroot.txt`
dia=`awk '{print $5}' /tmp/loginfailsroot.txt | head -n 1`
hora=`date +"%R"`
diahoy=`date +"%d"`
if [ $contador -ge 3 ] && [ $dia -eq $diahoy ]; then
	echo "Alguien esta intentando entrar demaciadas veces como root" | mutt -s "Intento de acceso a root" sergiosysforence@hotmail.com.ar
	fechahoy=$(date +"%d-%m-%Y-%H-%M")
	tar -zcvf backupsloginroot.$fechahoy.tar.gz /tmp/loginfailsroot.txt
	cp backupsloginroot.$fechahoy.tar.gz /media/veracrypt1/backupsscripts/backups_loginroot
	rm -rf backupsloginroot.$fechahoy.tar.gz
	rm -rf /tmp/loginfailsroot.txt
fi
