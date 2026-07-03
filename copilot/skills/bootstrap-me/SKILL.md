---
name: bootstrap-me
description: Initialiser une idée de projet et son harness technique avant sa première orchestration.
---

Transforme une idée validée en dépôt fondé, documenté et vérifiable. Ne réalise pas le produit : construis le cadre dans lequel `orchestrate` pourra le réaliser.

## Cadrer la fondation

1. Inspecte le répertoire cible, ses parents, `git status` et les éventuels `AGENTS.md`.
2. Si le répertoire contient des changements inattendus, bloque avant toute modification.
3. **REQUIRED SUB-SKILL:** Use `grill-me` pour résoudre la vision, le périmètre initial, la stack, l’architecture, les contraintes, les risques et les critères de réussite.
4. Sépare les décisions de fondation nécessaires maintenant des fonctionnalités reportées à l’orchestration.
5. Présente la fondation proposée et attends sa validation explicite.

Cette phase est terminée lorsque chaque décision structurante est validée ou consignée comme risque non bloquant.

## Construire le socle

Après validation :

1. Initialise le dépôt, la structure technique minimale et la gestion des dépendances.
2. Ajoute un test de fumée et les commandes reproductibles pour installer, lancer, tester et vérifier le projet.
3. Crée uniquement les documents utiles :
   - `AGENTS.md` pour les règles, commandes, Definition of Done et conventions de maintenance ;
   - `architecture.md` pour les frontières et flux durables ;
   - `decisions.md` pour les décisions structurantes et leurs raisons.
4. Définis dans `AGENTS.md` le rôle de `PROGRESS.md` comme état compact du plan d’exécution. Ne crée pas de plan détaillé : il appartient à `orchestrate`.
5. Exécute toutes les vérifications définies, corrige les échecs, puis crée un commit de fondation.

Le socle est terminé lorsque le dépôt peut être repris sans contexte oral, que ses commandes réussissent et que le commit est propre.

## Passer le relais

Résume la fondation, les vérifications et les risques restants. Indique que l’utilisateur invoque explicitement `orchestrate`, dans cette session ou une nouvelle, pour concevoir et réaliser le premier besoin.

Ne lance pas `orchestrate` implicitement et ne commence aucune fonctionnalité produit.
