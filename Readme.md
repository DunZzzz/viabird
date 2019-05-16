# Viabird

Viabird est un projet visant a collecter des donnees ornithologique a travers une mangeoire connectee possédant une caméra et un capteur de mouvement qui va, dès qu'un oiseau se pose sur elle, 
le prendre en photo et la stocker a l'interieur de la mangeoire.

Une foit installer la mangeoire offre aux utilisateurs une page web sur laquelle il peuvent visionner les photos des oiseaux venant se deposer a l'interieur de celle-ci.

Le projet Viabird à été crée en 2018 durant le Hackathon EuropeRemix pour ce poursuivre a travers le LabFab de Rennes et 3 étudiants Epitech.

## Prerequis Raspberry

 - Avoir une raspberry pi avec raspbian installe
 - Avoir une Caméra Rasp berry Pi (verifier la compatibilite a l'aide de la commande 'raspistill -o image.jpg').
 - Un detecteur de mouvement (Referer vous au schema contenu dans le pdf d'installation pour les branchements)

## Installation Sur la raspberry

Ci dessous est la liste des commandes que vous devrez tapez a la suite dans un terminal.

Tapez les lignes ci-dessous pour installer viabird dans le dossier 'Maison' de votre raspberry:
```bash
apt update && apt install git -y
cd ~ && rm -rf viabird && git clone https://github.com/DunZzzz/viabird.git
./viabird/installer.sh
```

Une foit installer viabird ce mettra a jour automatiquement si une connection internet est disponible et se lancera automatiquement au demarage.

## Informations relative au serveurRaspberry Pi 3 b+
