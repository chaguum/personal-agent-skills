# Revue de session

Appliquer ce protocole après chaque signal `session done`.

## Auditer

1. Relire tous les `AGENTS.md` applicables et `PROGRESS.md`.
2. Inspecter `git status`, le diff complet et l’historique récent.
3. Vérifier qu’aucun commit n’a été créé par la sous-session et qu’aucun changement étranger à la mission n’est inclus.
4. Comparer le résultat aux critères d’acceptation, au plan validé et à la Definition of Done du dépôt.
5. Examiner les preuves fournies et lancer les commandes de contrôle nécessaires. Ne pas rejouer systématiquement toutes les vérifications locales si leurs preuves sont suffisantes.

## Si la mission est acceptée

1. Marquer la mission terminée dans `PROGRESS.md` et condenser son historique.
2. Si des missions restent :
   - préparer uniquement la suivante avec `session-prompt-template.md` ;
   - l’inscrire comme mission active dans `PROGRESS.md`.
3. Si c’était la dernière mission :
   - effectuer l’audit global selon la Definition of Done et les critères du plan ;
   - marquer l’orchestration terminée seulement si tous sont satisfaits.
4. Sélectionner uniquement les changements attendus et `PROGRESS.md`.
5. Créer un commit ciblé `mission <identifiant>: <résultat>`.
6. Fournir le prochain prompt s’il existe, sinon le rapport de clôture.

## Si la mission est refusée

- Si aucune correction n’a encore été tentée :
  1. marquer `correction-active` et `Nombre de corrections de la mission active : 1` dans `PROGRESS.md` ;
  2. produire un prompt correctif destiné à la même sous-session ;
  3. décrire uniquement les écarts prouvés, les corrections attendues et les vérifications à rejouer ;
  4. ne créer aucun commit.
- Si une correction a déjà été tentée, suspendre la mission. Présenter les écarts persistants et leurs preuves, puis demander à l’utilisateur d’arbitrer entre nouvelle correction, replanification ou abandon. Ne reprendre qu’après sa décision explicite.

Chaque correction incrémente `Nombre de corrections de la mission active` dans `PROGRESS.md`. Le signal suivant reste `session done` : cet état indique s’il s’agit de la première revue ou d’une revue corrective.
