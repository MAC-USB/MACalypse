#!/bin/bash

## Script para la intro ##
echo ""
echo -e "Los archivos no solo sirven para almacenar información en la memoria, no.

¡Los archivos tienen una chispa de vida!

Son capaces de vivir en sociedad, comunicarse entre ellos y su deber sagrado es memorizar todo lo
necesario por si alguien necesita dicha información luego.

Pero poco sabían los pacíficos e inocentes archivos de esta computadora, que iban a ser atacados.

Poco a poco, archivos empezaron a aparecer y reaparecer archivos diferentes, como corrompidos, con
la memoria de su contenido alterada. Esto desató el pánico entre todos y llamaron a una reunión de
emergencia.

Tenemos que descubrir qué está pasando, quiénes son los archivos corrompidos y quienes son fieles
al bienestar de la computadora.

Solo tú puedes arreglarlo.

¿Lo lograrás? ¿O se desatará el..." | pv -qL50

echo ""
cat $ASCII_DIR/macalypse.ascii | pv -qL 5000

## FIN DE LA INTRO ##
press_enter
