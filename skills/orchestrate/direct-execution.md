# Exécution directe

Charger ce protocole uniquement après validation du plan.

## Vérifier l’éligibilité

L’exécution directe est autorisée seulement si toutes les conditions sont réunies :

- le plan validé contient une seule mission ;
- aucun découpage, dépendance intermédiaire ou transfert de contexte n’est nécessaire ;
- le changement forme un ensemble cohérent et borné ;
- ses critères d’acceptation et ses vérifications peuvent être exécutés dans la session actuelle ;
- le dépôt ne contient aucun changement inattendu.

Si une condition manque, revenir au workflow par sous-sessions.

## Obtenir l’autorisation

Présenter brièvement pourquoi la mission est éligible et demander une confirmation explicite pour l’exécuter dans la session orchestratrice. Ne modifier aucun code avant cette confirmation.

Si l’utilisateur refuse ou préfère une sous-session, générer uniquement le prochain prompt avec `session-prompt-template.md`.

## Exécuter

Après confirmation explicite :

1. inscrire dans `PROGRESS.md` que la mission unique passe en exécution directe ;
2. inspecter les fichiers concernés et appliquer les règles des `AGENTS.md` ;
3. implémenter uniquement le plan validé ;
4. exécuter les vérifications pertinentes et la Definition of Done applicable ;
5. inspecter le diff complet et corriger tout écart avant de poursuivre ;
6. si le périmètre doit s’élargir ou si le plan devient invalide, arrêter l’exécution et demander une nouvelle validation ;
7. mettre à jour `PROGRESS.md` avec le résultat, les vérifications et les risques restants ;
8. sélectionner uniquement les changements attendus et `PROGRESS.md` ;
9. créer un commit ciblé `mission 1: <résultat>`.

L’exécution est terminée uniquement lorsque les critères du plan et la Definition of Done sont satisfaits. Aucun signal `session done` n’est requis pour cette voie.
