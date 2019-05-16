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

La commande cd permet de ce deplacer dans les differents dossiers de votre raspberry dans le terminal, tapez la commande ci-dessous pour vous retrouvez dans le dossier 'Maison' de votre raspberry:
```bash
cd ~
```

Ensuite telecharger les outils nescessaire a l'installation de viabird avec la commande ci-dessous:
```bash
sudo apt update && sudo apt install git -y
```

La ligne suivante permet de telecharger le dossier viabird dans le dossier courant, tapez cette ligne puis appuyer sur Entree.
```bash
&& git clone https://github.com/DunZzzz/viabird.git
```

Rendez vous ensuite dans le dossier nouvellement telecharger a l'aide de la commande cd
```bash
cd viabird
```

Pour finir lancer la commande suivante pour installer viabird sur votre raspberry
```bash
sudo ./installer.sh
```

Une foit installer viabird ce mettra a jour automatiquement si une connection internet est disponible et se lancera automatiquement au demarage.

## Informations relative au serveurRaspberry Pi 3 b+
