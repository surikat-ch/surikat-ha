#Dockerfile
# Décrit l’image Docker de ton add-on.
# Contient les instructions pour installer toutes les dépendances, copier les fichiers nécessaires, et lancer ton script principal.
# Home Assistant construit l’add-on à partir de ce Dockerfile.

ARG BUILD_FROM
FROM $BUILD_FROM

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]