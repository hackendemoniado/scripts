#/bin/bash
unahoramenos=`date +%R --date='-1 hours'`
horaactual=`date +%R`
lastb -s $unahoramenos -t $horaactual | grep hackende > /tmp/loginfailshackende.txt
cantfail=`wc -l /tmp/loginfailshackende.txt > /tmp/cantfailhackende.txt`
contador=`awk '{print $1}' /tmp/cantfailhackende.txt`
dia=`awk '{print $5}' /tmp/loginfailshackende.txt | head -n 1`
hora=`date +"%R"`
diahoy=`date +"%d"`
if [ $contador -ge 3 ] && [ $dia -eq $diahoy ]; then
        echo "Alguien esta intentando entrar demaciadas veces como hackendemoniado" | mutt -s "Intento de acceso a hackendemoniado" sergiosysforence@hotmail.com.ar
	fechahoy=$(date +"%d-%m-%Y-%H-%M")
	tar -zcvf backupsloginhack.$fechahoy.tar.gz /tmp/loginfailshackende.txt
	cp backupsloginhack.$fechahoy.tar.gz /media/veracrypt1/backupsscripts/backups_loginhackendemoniado
	rm -rf backupsloginhack.$fechahoy.tar.gz
	rm -rf /tmp/loginfailshackende.txt
	rm -rf /tmp/cantfail*
fi
