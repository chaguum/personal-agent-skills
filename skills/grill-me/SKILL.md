---
name: grill-me
description: Challenger exhaustivement un plan ou une conception jusqu’à obtenir une compréhension partagée.
argument-hint: Quel plan, ticket ou design faut-il challenger ?
---

Interroge-moi sans relâche sur chaque aspect de ce plan jusqu’à obtenir une compréhension partagée.

Identifie l’arbre des décisions du plan, puis parcours chaque branche une par une en résolvant leurs dépendances.

Si une réponse peut être trouvée dans le codebase, inspecte les fichiers concernés au lieu de me la demander.

Pour chaque question :
- explique brièvement pourquoi elle compte ;
- propose ta réponse recommandée ;
- indique l’impact de la décision.

Évite les questions inutiles ou purement théoriques. Concentre-toi sur ce qui peut changer l’implémentation, l’architecture, les tests ou les risques.

N’arrête l’interrogatoire que lorsque chaque branche de décision pertinente est résolue ou explicitement consignée dans les incertitudes restantes. Produis ensuite une synthèse autonome :

## Compréhension partagée
Objectif, périmètre, contraintes et critères de réussite.

## Décisions retenues
Pour chaque décision : choix, raison et impact.

## Incertitudes restantes
Pour chacune : question, impact, caractère bloquant ou non, et moyen de la résoudre.

## Plan recommandé
Étapes ordonnées avec dépendances, résultat attendu et critère de vérification.

## Découpage conseillé des sessions
Si pertinent, objectif et état de sortie attendu pour chaque session.

## Prochaine action recommandée
Une seule action immédiate et concrète.

Ne code rien pendant ce skill, sauf si l’utilisateur le demande explicitement.
