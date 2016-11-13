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
TRACKERS="udp://tracker.opentrackr.org:1337/announce udp://glotorrents.pw:6969/announce"




TRACKERSLIST=$(echo "${TRACKERS}" | sed  -e "s/ / -t /")

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
