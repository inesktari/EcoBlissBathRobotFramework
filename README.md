# EcoBlissBath
EcoBlissBath est une application e-commerce de produits de beauté écoresponsables, développée dans le cadre d'un projet pédagogique OpenClassrooms.

Ce dépôt présente l'automatisation des tests fonctionnels de l'application avec **Robot Framework** et **SeleniumLibrary**, selon une démarche qualité inspirée des bonnes pratiques ISTQB.

**Objectifs :** valider les parcours utilisateurs, vérifier les règles métier et détecter les régressions.

## Couverture des tests
Les **tests UI automatisés** couvrent :
- Affichage de la page d'accueil et authentification.
- Ajout et suppression de produits dans le panier.
- Augmentation et diminution des quantités.
- Vérification de la quantité minimale autorisée.
- Contrôle des montants exacts après modification des quantités.
- Validation d'une commande.

Les tests utilisent des keywords réutilisables, des locators centralisés et des mécanismes Setup/Teardown pour améliorer leur maintenabilité.

## Installation
### Prérequis :
Git, Docker, Python et un navigateur compatible Selenium.

### Cloner le dépôt :
git clone https://github.com/inesktari/EcoBlissBathRobotFramework.git
cd EcoBlissBathRobotFramework

### Démarrer l'application :
docker compose up --build

### Installer les dépendances Python :
python -m venv .venv
python -m pip install robotframework robotframework-seleniumlibrary

### Application :
http://localhost:8080

### Documentation API :
http://localhost:8081/api/doc/

## Exécution des tests
Pour exécuter les scénarios nécessitant une authentification, utiliser le compte de démonstration suivant :
**Identifiant :** test2@test.fr
**Mot de passe :** testtest

Lancer tous les tests UI :
python -m robot --outputdir results tests/ui/

Lancer uniquement les tests du panier :
python -m robot --outputdir results tests/ui/cart.robot

Les rapports sont générés automatiquement dans results/ :
- report.html : synthèse des résultats.
- log.html : détail des exécutions.
- output.xml : résultats structurés.

## Améliorations prévues
- Compléter la couverture des tests fonctionnels avec des scénarios négatifs.
- Automatiser les tests API avec Robot Framework.
- Améliorer progressivement la robustesse et la maintenabilité des tests.

## Historique des versions
- **v1.0.0 :** Tests fonctionnels manuels.
- **v2.0.0 :** Automatisation des tests UI avec Robot Framework et SeleniumLibrary.
## Auteur
Ines KAMMOUN KTARI
ineskammoun24@hotmail.fr
