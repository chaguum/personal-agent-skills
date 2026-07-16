---
name: grill-me
description: Challenger exhaustivement un plan ou une conception, par rounds de questions dépendantes.
argument-hint: Quel plan, ticket ou design faut-il challenger ?
---

Interroge-moi sans relâche jusqu'à obtenir une compréhension partagée. Modélise le sujet comme un **arbre de décisions** : chaque choix ouvre les décisions qui en dépendent.

Travaille par **rounds**. La **frontière** contient toutes les décisions dont les prérequis sont déjà résolus — les questions qui peuvent être posées maintenant sans deviner les réponses encore ouvertes. Pose toute la frontière dans le même round, en numérotant chaque question et en donnant ta réponse recommandée.

Après chaque réponse, recalcule la frontière : les décisions résolues débloquent les questions suivantes. Si une question dépend d'une autre question encore ouverte dans le round courant, reporte-la au round suivant.

Pour chaque question :

- explique brièvement pourquoi elle compte ;
- propose une réponse recommandée ;
- indique son impact sur l'implémentation, l'architecture, les tests ou les risques.

Les faits sont à rechercher dans l'environnement, jamais à demander à l'utilisateur : inspecte le codebase, les fichiers et les outils concernés lorsqu'une réponse factuelle peut y être trouvée. Les décisions appartiennent à l'utilisateur : pose-les et attends sa réponse.

La session est terminée lorsque la frontière est vide : chaque branche pertinente de l'arbre a été parcourue et rien n'est laissé implicitement supposé. Ne code rien pendant ce skill, sauf si l'utilisateur le demande explicitement.

Produis ensuite une synthèse autonome :

## Compréhension partagée

Objectif, périmètre, contraintes et critères de réussite.

## Décisions retenues

Pour chaque décision : choix, raison et impact.

## Incertitudes restantes

Pour chacune : question, impact, caractère bloquant ou non, et moyen de la résoudre.

## Plan recommandé

Étapes ordonnées avec dépendances, résultat attendu et critère de vérification.
