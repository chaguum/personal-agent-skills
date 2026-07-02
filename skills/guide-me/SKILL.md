---
name: guide-me
description: Utiliser lorsqu’un doute technique local, une hésitation entre plusieurs solutions ou une hypothèse bloque une tâche de conception ou de développement en cours.
---

Tranche un doute technique local sans rouvrir inutilement le plan complet. Recommande une solution unique, puis avance lorsqu’aucune validation utilisateur n’est nécessaire.

## 1. Établir le contexte

1. Lis `PROGRESS.md` dans le dépôt courant s’il existe, sinon cherche-le dans les dossiers parents proches.
2. Inspecte les fichiers, tests, logs et documents nécessaires pour vérifier les hypothèses.
3. Si le doute vise une partie précise du code, inspecte-la avant de répondre.
4. Ne demande pas une information qui peut être trouvée localement.

Cette étape est terminée lorsque le plan actuel, le doute à trancher et les faits qui contraignent la décision peuvent être résumés clairement.

## 2. Trancher

1. Reformule le doute en une phrase.
2. Résume brièvement ce que le plan actuel établit déjà.
3. Identifie uniquement les options qui changent réellement l’implémentation, l’architecture, les tests ou le risque.
4. Évalue-les selon :
   - la correction fonctionnelle ;
   - la simplicité ;
   - la cohérence avec le code existant ;
   - le risque de régression ;
   - le coût de test et de maintenance ;
   - l’impact sur le plan courant.
5. Recommande une solution unique et justifie-la. Explique pourquoi les alternatives sont moins bonnes seulement si cela éclaire la décision.
6. Si deux options restent proches, choisis celle qui minimise le changement et respecte le mieux les patterns existants.

Cette étape est terminée lorsque la recommandation, ses preuves et son impact sur le plan sont explicites.

## 3. Décider s’il faut agir

Demande une validation avant d’implémenter si :

- la solution change significativement le plan ;
- plusieurs options restent raisonnables avec des compromis produit, architecture ou UX ;
- le changement est large ou difficile à annuler ;
- la décision dépend d’une intention utilisateur introuvable dans le dépôt ;
- l’utilisateur demande explicitement une validation.

Si une seule information utilisateur bloque la décision, pose uniquement cette question.

Sinon, implémente directement lorsque la solution est claire après inspection, locale, réversible et cohérente avec le plan. Cela inclut la correction d’une erreur manifeste et l’application d’une décision déjà documentée.

Si une validation est nécessaire, présente puis arrête-toi :

## Décision recommandée
## Pourquoi cette solution
## Pourquoi pas les alternatives
## Impact sur le plan actuel
## Changement proposé
## Mise à jour de PROGRESS.md proposée, si applicable

Ne code rien et ne modifie pas `PROGRESS.md` avant l’accord utilisateur.

Si aucune validation n’est nécessaire ou si elle a déjà été donnée :

1. implémente la solution ;
2. vérifie-la avec les tests, commandes ou contrôles pertinents ;
3. poursuis seulement lorsque ces vérifications sont terminées ou que leurs limites sont explicitement établies.

## 4. Persister la décision

Après une implémentation, mets à jour le `PROGRESS.md` existant lorsque la décision modifie, précise ou remplace le plan courant. La mise à jour doit rester concise :

- décision retenue et raison ;
- changement appliqué ;
- vérification effectuée ;
- impact sur les prochaines étapes ;
- risque restant, si pertinent.

Ne le modifie pas pour un changement mécanique, une correction locale sans impact sur le plan, une vérification sans conséquence ou une décision déjà correctement documentée.

Termine avec :

## Décision retenue
## Changement effectué
## Vérification
## Mise à jour de PROGRESS.md
## Risque restant

## Limites

- Préserve le plan existant par défaut.
- Si le plan complet doit être remis en cause, utilise plutôt `grill-me`.
- Si le problème principal est un bug observé ou un test en échec, utilise plutôt un workflow de debugging systématique.
- Si la meilleure décision est de ne rien changer, dis-le explicitement.
