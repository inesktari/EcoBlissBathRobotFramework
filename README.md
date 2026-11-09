# EcoBlissBath
EcoBlissBath est une application e-commerce de produits de beauté écoresponsables, développée dans le cadre d'un projet pédagogique OpenClassrooms.<br><br>

Ce dépôt présente l'automatisation des tests fonctionnels de l'application avec **Robot Framework** et **SeleniumLibrary**, selon une démarche qualité inspirée des bonnes pratiques ISTQB.<br><br>

**Objectifs :** valider les parcours utilisateurs, vérifier les règles métier et détecter les régressions.

## Couverture des tests
Les **tests UI automatisés** couvrent :<br>
- Affichage de la page d'accueil et authentification.<br>
- Ajout et suppression de produits dans le panier.<br>
- Augmentation et diminution des quantités.<br>
- Vérification de la quantité minimale autorisée.<br>
- Contrôle des montants exacts après modification des quantités.<br>
- Validation d'une commande.<br>

Les tests utilisent des keywords réutilisables, des locators centralisés et des mécanismes Setup/Teardown pour améliorer leur maintenabilité.

## Installation
### Prérequis :
Git, Docker, Python et un navigateur compatible Selenium.<br>

### Cloner le dépôt :
git clone https://github.com/inesktari/EcoBlissBathRobotFramework.git <br>
cd EcoBlissBathRobotFramework

### Démarrer l'application :
docker compose up --build

### Installer les dépendances Python :
python -m venv .venv<br>
python -m pip install robotframework robotframework-seleniumlibrary

### Application :
http://localhost:8080

### Documentation API :
http://localhost:8081/api/doc/

## Exécution des tests
Pour exécuter les scénarios nécessitant une authentification, utiliser le compte de démonstration suivant :<br>
**Identifiant :** test2@test.fr<br>
**Mot de passe :** testtest<br>

Lancer tous les tests UI :
python -m robot --outputdir results tests/ui/

Lancer uniquement les tests du panier :
python -m robot --outputdir results tests/ui/cart.robot

Les rapports sont générés automatiquement dans results/ :<br>
- report.html : synthèse des résultats.<br>
- log.html : détail des exécutions.<br>
- output.xml : résultats structurés.<br>

## Améliorations prévues
- Compléter la couverture des tests fonctionnels avec des scénarios négatifs.<br>
- Automatiser les tests API avec Robot Framework.<br>
- Améliorer progressivement la robustesse et la maintenabilité des tests.<br>

## Historique des versions
- **v1.0.0 :** Tests fonctionnels manuels.<br>
- **v2.0.0 :** Automatisation des tests UI avec Robot Framework et SeleniumLibrary.<br>
## Auteur
Ines KAMMOUN KTARI<br>
ineskammoun24@hotmail.fr
