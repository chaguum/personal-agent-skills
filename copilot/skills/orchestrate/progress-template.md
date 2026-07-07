# Progress

Utiliser ce format uniquement si `PROGRESS.md` est absent et qu’`AGENTS.md` n’impose aucun format. Garder le fichier compact : état courant détaillé, historique terminé synthétique, aucun journal exhaustif.

## État de l’orchestration

- Statut : `planification | attente-validation | mission-active | correction-active | attente-utilisateur | bloqué | terminé`
- Mission active :
- Nombre de corrections de la mission active :
- Prochaine action :

## Objectif et critères de réussite

- Objectif :
- Périmètre :
- Hors périmètre :
- Contraintes :
- Critères de réussite :

## Plan validé

États autorisés pour la colonne `État` : `non-démarrée | mission-active | attente-audit | correction-active | attente-utilisateur | terminée | bloquée`

## Workflow de mission

- `non-démarrée -> mission-active`
  Utiliser quand l’orchestratrice prépare et lance la prochaine mission.
- `mission-active -> attente-audit`
  Utiliser quand la sous-session a fini son exécution et revient avec `session done`.
- `attente-audit -> terminée | correction-active | attente-utilisateur`
  `terminée` si la mission est acceptée.
  `correction-active` si une correction bornée est demandée à la même sous-session.
  `attente-utilisateur` si l’audit ou la mission révèle un arbitrage utilisateur nécessaire avant de poursuivre.
- `correction-active -> attente-audit | attente-utilisateur | bloquée`
  `attente-audit` après retour de la correction.
  `attente-utilisateur` si la correction révèle un choix produit, UX, architecture ou périmètre.
  `bloquée` si un obstacle externe ou technique empêche de poursuivre même avec un arbitrage clair.
- `attente-utilisateur -> mission-active | terminée | bloquée`
  `mission-active` après décision utilisateur et relance de la mission.
  `terminée` si la décision utilisateur clôt effectivement la mission.
  `bloquée` si la décision confirme qu’un blocage externe subsiste.
- `bloquée -> mission-active | attente-utilisateur`
  `mission-active` si le blocage est levé et que la mission peut reprendre.
  `attente-utilisateur` si une nouvelle décision utilisateur devient la prochaine action légitime.

| Mission | Objectif | Dépendances | Critères d’acceptation | État |
| --- | --- | --- | --- | --- |

## Mission active

- Identifiant :
- Objectif :
- Périmètre autorisé :
- Critères d’acceptation :
- Vérifications requises :
- Prompt transmis :
- Prompt correctif transmis :

## Missions terminées

Pour chaque mission, conserver uniquement : résultat, message du commit de checkpoint, vérifications et éventuel risque restant.

## Décisions

- Décision — raison — impact.

## Blocages et risques

- Blocage ou risque — impact — résolution attendue.
