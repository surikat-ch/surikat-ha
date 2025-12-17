#! Script principal qui est exécuté quand l’add-on démarre.
#! Peut :
#! Lancer des services
#! Préparer l’environnement
#! Appliquer des configurations spécifiques
#! Souvent le point d’entrée défini dans le Dockerfile.

#!/usr/bin/with-contenv bashio

echo "Hello world!"