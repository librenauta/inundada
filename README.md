Inundado
--------

Inundado es un script muy simple en bash que recibe una ruta como parametro y
crea un archivo torrent por cada directorioque cuentra y tambien un listado de
magnetlinks.

Ej:
tree /tmp/inundado
.
├── d1
│   ├── f1
│   ├── f2
│   ├── f3
│   └── f4
├── d2
│   ├── f5
│   ├── f6
│   └── f7
└── d3
    ├── f10
    ├── f11
    ├── f8
    └── f9

3 directories, 11 files

Uso:
	inundada.sh /tmp/inundado

[!] Recorriendo  /tmp/inundado/d3, Autora: d3
Creating torrent "12-11-16-31298/d3.torrent" .... done!
[!] Recorriendo  /tmp/inundado/d2, Autora: d2
Creating torrent "12-11-16-31298/d2.torrent" .... done!
[!] Recorriendo  /tmp/inundado/d1, Autora: d1
Creating torrent "12-11-16-31298/d1.torrent" .... done!

Creara una carpeta con la fecha del dia de hoy y un numero aleaterio al final:

tree  12-11-16-31298/
12-11-16-31298/
├── d1.torrent
├── d2.torrent
├── d3.torrent
└── magnet.txt

0 directories, 4 files


Vamos a crear un .torrent por cada carpeta
