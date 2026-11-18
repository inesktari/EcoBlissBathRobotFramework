# EcoBlissBath — Automatisation des tests UI & API

Projet d'automatisation des tests d'une application e-commerce de produits de beauté écoresponsables, réalisée dans le cadre d'un projet pédagogique OpenClassrooms.

Ce dépôt présente mon travail avec **Robot Framework**, **SeleniumLibrary** et **RequestsLibrary**, dans une démarche qualité s'appuyant sur les principes ISTQB.

**Objectif :** automatiser les parcours critiques, vérifier les règles métier, détecter les régressions et documenter les anomalies.

## Technologies

**Robot Framework** · **Python** · **SeleniumLibrary** · **RequestsLibrary** · **Docker** · **Git / GitHub**

## Couverture des tests

### Tests UI
- Affichage des éléments essentiels : accueil, connexion et fiches produits.
- Authentification et déconnexion.
- Ajout, suppression et modification des quantités dans le panier.
- Vérification des prix et des totaux.
- Validation des commandes et des formulaires.
- Scénarios négatifs : quantités invalides, stocks et codes postaux.

### Tests API
- Authentification et inscription.
- Produits, utilisateurs, commandes et avis.
- Vérification des codes HTTP et des réponses JSON.
- Tests négatifs, valeurs limites et accès non authentifiés.
- Vérifications ciblées du traitement des contenus HTML et XSS.

Les tests utilisent des **keywords réutilisables**, des **locators centralisés** et des mécanismes **Setup/Teardown**.

## Exécution des tests

### Prérequis

Python, Docker, Git et un navigateur compatible Selenium.

L'application doit être démarrée :
```bash
docker compose up --build
```

Installer les bibliothèques Python :
```bash
python -m pip install robotframework robotframework-seleniumlibrary robotframework-requests
```

**Application :** http://localhost:8080/  
**Documentation API :** http://localhost:8081/api/doc/

### Smoke tests

```bash
python -m robot --include smoke --exclude known_issue tests/
```

### Régression UI & API

```bash
python -m robot --exclude known_issue --exclude pending_stock_isolation tests/
```

### Tests UI uniquement

```bash
python -m robot --exclude known_issue --exclude pending_stock_isolation tests/ui/
```

### Tests API uniquement

```bash
python -m robot --exclude known_issue tests/api/
```

Les rapports `report.html`, `log.html` et `output.xml` sont générés automatiquement par Robot Framework.

## Résultats et anomalies

**Smoke tests : 4 PASS / 4**

Les tests ont permis d'identifier et de documenter **7 anomalies**, notamment :
- Acceptation de codes postaux alphabétiques.
- Gestion incorrecte des stocks et des quantités.
- Erreurs HTTP 500 lors d'accès API non authentifiés.

Les tests associés aux anomalies connues sont conservés avec les tags `known_issue` et `issue_N`.

**[Consulter les anomalies sur GitHub](https://github.com/inesktari/EcoBlissBathRobotFramework/issues)**

## Démarche QA

Ce projet met en pratique plusieurs compétences liées à ma certification **ISTQB Foundation Level** :

- Conception de scénarios positifs et négatifs.
- Analyse des valeurs limites.
- Exécution et analyse des tests.
- Gestion et suivi des anomalies.
- Automatisation des tests de non-régression.

## Auteur

**Ines KAMMOUN KTARI**  
*Testeuse QA certifiée ISTQB — Tests fonctionnels et automatisation*

Contact : ineskammoun24@hotmail.fr