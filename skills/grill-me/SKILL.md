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

N’arrête l’interrogatoire que lorsque chaque branche de décision pertinente est résolue ou explicitement consignée dans les incertitudes restantes. Produis ensuite :

## Décisions retenues
## Incertitudes restantes
## Plan recommandé
## Découpage conseillé des sessions, si pertinent
## Prochaine action recommandée

Ne code rien pendant ce skill, sauf si l’utilisateur le demande explicitement.
