---
name: orchestrate
description: Piloter un besoin de sa conception à sa réalisation, directement ou au moyen de sous-sessions séquentielles.
---

Reste responsable du résultat global, de la conception à la réalisation. Par défaut, ne modifie pas le code : inspecte le dépôt, lance des commandes de vérification, maintiens le contexte d’orchestration et crée les commits des missions acceptées. L’exécution directe constitue l’unique exception.

## Initialiser le contexte

1. Lis tous les `AGENTS.md` applicables avant toute autre action. Leurs règles, notamment leur Definition of Done et leurs conventions pour `PROGRESS.md`, sont prioritaires.
2. Inspecte le dépôt et `git status`.
3. Si des changements inattendus sont présents, bloque avant de lancer une mission et demande à l’utilisateur de les committer, les stasher ou les attribuer explicitement à la mission.
4. Lis `PROGRESS.md` s’il existe et détermine l’état courant de l’orchestration.

Cette étape est terminée lorsque les règles locales, l’état Git et l’état de reprise sont connus.

## Router selon l’état

### Aucun plan validé

1. **REQUIRED SUB-SKILL:** Use `grill-me` pour explorer exhaustivement le besoin et produire la compréhension partagée, les décisions, les incertitudes et le plan recommandé.
2. Présente ce plan et attends sa validation explicite.
3. Ne crée ni ne modifie `PROGRESS.md` avant cette validation.
4. Après validation :
   - respecte le format imposé par `AGENTS.md` ou le fichier existant ;
   - si `PROGRESS.md` est absent et qu’aucun format local n’est défini, lis `progress-template.md` puis crée-le ;
   - transforme le plan en missions strictement séquentielles.
5. Si le plan contient exactement une mission cohérente et vérifiable, propose de l’exécuter dans la session actuelle. Après confirmation explicite de l’utilisateur, lis `direct-execution.md` et applique-le intégralement.
6. Sinon, utilise le workflow par sous-sessions.

### Orchestration existante

Résume l’état de `PROGRESS.md`, vérifie qu’il correspond au dépôt, puis reprends à la mission active ou à la prochaine action. Ne recommence pas la conception sauf si le plan est explicitement invalidé.

### Signal `session done`

Lis `session-review.md` et applique intégralement son protocole. `session done` déclenche toujours un audit ; ce n’est jamais une acceptation automatique.

## Générer une mission

1. Génère uniquement le prochain prompt, jamais les prompts des missions futures.
2. Lis `session-prompt-template.md`.
3. Inscris dans `PROGRESS.md` la mission active, son prompt, ses critères d’acceptation et l’état de la correction.
4. Donne le prompt à copier-coller dans une nouvelle sous-session, puis attends `session done`.

Les missions sont toujours séquentielles et lancées manuellement par l’utilisateur.

## Garder le contexte lisible

`PROGRESS.md` est un état de reprise, pas un journal exhaustif. Conserve l’état courant détaillé et un historique synthétique des missions terminées. Condense les détails devenus inutiles afin qu’un nouvel agent puisse comprendre rapidement le projet, la mission active et la prochaine action.

## Limites

- Ne modifie jamais le code ou les tests hors de la voie explicitement autorisée par `direct-execution.md`.
- Tu peux modifier uniquement les fichiers de contexte d’orchestration autorisés, inspecter les changements, exécuter des commandes et créer un commit après acceptation.
- Ne lance pas toi-même les sous-sessions.
- Ne génère jamais plus d’une mission active.
- Si une mission exige de modifier le plan global, suspends l’exécution et demande une validation utilisateur.
