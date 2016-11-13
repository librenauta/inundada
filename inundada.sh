#!/usr/bin/env bash
# inundado - genera ficheros torrent a partir de los archivos
# de un directorio y un listado de MagnetLinks
#
# © 2016 Kaze <kaze@partidopirata.com.ar>
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.
#
# http://www.gnu.org/prep/maintain/html_node/License-Notices-for-Other-Files.htm

INPUTDIR="$1"


# Nombre de directorio donde se guardaran los .torrent
OUTPUTDIR=$(date +%d-%m-%y-$RANDOM)
# Comentario del torrent al crearse
COMENTARIO="Compartir es bueno"
# Lista de trackers, separadas por espacios, OPENTRACKETS :D
TRACKERS="http://9.rarbg.com:2710/announce
http://announce.torrentsmd.com:6969/announce
http://bt.careland.com.cn:6969/announce
http://explodie.org:6969/announce
http://mgtracker.org:2710/announce
http://tracker.best-torrents.net:6969/announce
http://tracker.tfile.me/announce
http://tracker.torrenty.org:6969/announce
http://tracker1.wasabii.com.tw:6969/announce
udp://9.rarbg.com:2710/announce
udp://9.rarbg.me:2710/announce
udp://coppersurfer.tk:6969/announce
udp://exodus.desync.com:6969/announce
udp://open.demonii.com:1337/announce
udp://tracker.btzoo.eu:80/announce
udp://tracker.istole.it:80/announce
udp://tracker.openbittorrent.com:80/announce
udp://tracker.prq.to/announce
udp://tracker.publicbt.com:80/announce"



#Cambio los principios de linea por "-t", quito los saltos de linea, y el pimer
# "-t" asi lo pongo en las opciones de transmission-create
TRACKERSLIST=$(echo "${TRACKERS}" | sed  -e "s/^/ -t /g" | tr "\n" " " | sed -e "s/\-t//")

mkdir ${OUTPUTDIR}
# Array con los directorios, quitamos el primer diectorio que es el base
DIRECTORIOS=("$(find $1 -maxdepth 1 -type d | sed 1d)")

MAGNETFILE="${OUTPUTDIR}/magnet.txt"
echo "AUTOR;MAGNETLINK" > ${MAGNETFILE}

for ruta in ${DIRECTORIOS[@]}; do
    echo "[!] Recorriendo  "$ruta", Autora: ${ruta##*/}"

    # Magia de bash para sacar el nombre del ultimo directorio
    FILENAME="${ruta##*/}"
    transmission-create -o "${OUTPUTDIR}/${FILENAME}.torrent" -t ${TRACKERSLIST}  -c "${COMENTARIO}" "${ruta}"

    # Agregamos el autor y el magnet en csv: AUTOR;MAGNET\n
    MAGNET=$(transmission-show --magnet ${OUTPUTDIR}/${FILENAME}.torrent)

    echo "${FILENAME};${MAGNET}" >> ${MAGNETFILE}
done
