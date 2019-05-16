# Viabird

Viabird est un projet visant à collecter des données ornithologiques à travers une mangeoire connectée possédant une caméra et un capteur de mouvement qui va, dès qu'un oiseau se pose sur elle,
le prendre en photo et la stocker à l'intérieur de la mangeoire.

Une foit installé la mangeoire offre aux utilisateurs une page web sur laquelle ils peuvent visionner les photos des oiseaux venant se déposer à l'intérieur de celle-ci.

Le projet Viabird a été créé en 2018 durant le Hackathon EuropeRemix pour se poursuivre à travers le LabFab de Rennes et 3 étudiants Epitech.

## Prerequis Raspberry

 - Avoir une raspberry pi avec raspbian installé
 - Avoir une Caméra Raspberry Pi (vérifier la compatibilité a l'aide de la commande 'raspistill -o image.jpg').
 - Un détécteur de mouvement (Référer vous au schema contenu dans le pdf d'installation pour les branchements)

## Installation Sur la raspberry

Ci-dessous est la liste des commandes que vous devrez taper à la suite dans un terminal.
```bash
sudo apt update && sudo apt install git -y
cd ~ && rm -rf viabird && git clone https://github.com/DunZzzz/viabird.git
sudo ./viabird/installer.sh
```

Une foit installé viabird se mettra à jour automatiquement si une connexion internet est disponible et se lancera automatiquement au démarrage.

## Acces Web

Pour accéder à la plateforme web vous devez récupérer l'ip de votre raspberry pi, lancer la commande suivante:
```
hostname -i
```
cette commande vous donnera une ip similaire à '192.168.0.10'

pour accéder à la plateforme web munissez-vous d'un ordinateur connecte au même réseau internet et tapez l'URL suivante dans votre navigateur : http://VOTRE_IP/ ou VOTRE_IP correspond à l'ip donnez à l'étape précédente.

Si tout se déroule comme prévu vous devriez être sur une page vous demandant vos identifiants de connexion, par défaut ceux-ci sont:
 - nom d'utilisateur: viabird
 - mot de passe: viabird
