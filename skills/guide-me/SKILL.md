---
name: guide-me
description: Aider a trancher un doute technique pendant une tache de conception ou de developpement, en tenant compte du plan existant, souvent dans PROGRESS.md, puis recommander une solution, demander validation si le choix change le cap, ou implementer directement si la solution est evidente. Utiliser quand l'utilisateur expose une hypothese, une hesitation entre plusieurs solutions, un doute sur le plan courant, ou demande a Codex de choisir la meilleure voie sans relancer un plan complet.
---

Aide-moi a trancher un doute technique dans le contexte du travail en cours.

Objectif : comprendre le plan existant, arbitrer le doute, recommander une solution concrete, puis avancer sans rouvrir inutilement toute la conception.

## Contexte a lire

Avant de trancher, cherche le contexte local pertinent :

1. Lis `PROGRESS.md` dans le repo courant si present.
2. Si absent, cherche un `PROGRESS.md` dans les dossiers parents proches.
3. Lis les fichiers, tests, logs ou docs locales necessaires pour verifier les hypotheses.
4. Si le doute porte sur une partie precise du code, inspecte cette partie avant de repondre.

Ne demande pas a l'utilisateur une information qui peut etre trouvee dans le repo.

## Workflow

1. Reformule le doute a trancher en une phrase.
2. Resume brievement ce que le plan actuel semble deja etablir.
3. Identifie les options realistes qui changent concretement l'implementation, l'architecture, les tests ou le risque.
4. Evalue les options selon :
   - correction fonctionnelle ;
   - simplicite ;
   - coherence avec le code existant ;
   - risque de regression ;
   - cout de test et de maintenance ;
   - impact sur le plan courant.
5. Recommande une solution unique.
6. Explique pourquoi cette solution est preferable.
7. Explique pourquoi les autres options sont moins bonnes, seulement si cela aide la decision.
8. Decide s'il faut demander validation avant implementation.
9. Implemente la solution choisie si la validation n'est pas necessaire ou si l'utilisateur a donne son accord.
10. Verifie avec les tests, commandes ou checks pertinents.
11. Mets a jour `PROGRESS.md` si la decision prise doit rester dans le contexte durable du projet.

## Validation utilisateur

Demande validation avant d'implementer si :
- la solution modifie le plan existant de maniere significative ;
- plusieurs options restent raisonnables avec des compromis produit, architecture ou UX ;
- le changement a un impact large ou difficile a annuler ;
- la decision depend d'une intention utilisateur qui ne peut pas etre deduite du code ;
- l'utilisateur demande explicitement de valider avant changement.

Ne demande pas validation si :
- la solution est evidente apres inspection ;
- le changement est local, reversible et coherent avec le plan ;
- il s'agit de corriger une erreur manifeste ;
- il s'agit d'appliquer une decision deja presente dans `PROGRESS.md` ;
- attendre une validation ralentirait seulement une decision technique claire.

## Format si validation necessaire

Presente :

## Decision recommandee
## Pourquoi cette solution
## Pourquoi pas les alternatives
## Impact sur le plan actuel
## Changement propose
## Mise a jour PROGRESS.md proposee, si applicable

Puis attends l'accord utilisateur avant d'implementer.

## Format si validation non necessaire

Implemente directement, puis termine avec :

## Decision retenue
## Changement effectue
## Verification
## Mise a jour PROGRESS.md
## Risque restant

## Mise a jour du contexte

Si un `PROGRESS.md` existe et que la decision prise modifie, precise ou remplace une partie du plan courant, mets-le a jour apres implementation.

La mise a jour doit rester concise :
- decision retenue ;
- raison courte ;
- changement applique ;
- verification effectuee ;
- impact sur les prochaines etapes, si pertinent.

Ne mets pas a jour `PROGRESS.md` pour :
- un changement purement mecanique ;
- une correction locale sans impact sur le plan ;
- une verification sans consequence ;
- une decision deja documentee correctement.

Si une validation utilisateur etait necessaire, propose d'abord la mise a jour `PROGRESS.md` avec le changement recommande. Ne modifie `PROGRESS.md` qu'apres accord.

## Regles de decision

- Preserve le plan existant par defaut.
- Ne transforme pas le doute en nouveau plan complet sauf si le plan actuel est manifestement invalide.
- Tranche clairement : ne liste pas seulement des possibilites.
- Si une option est clairement meilleure, choisis-la.
- Si deux options sont proches, choisis celle qui minimise le changement et respecte le mieux les patterns existants.
- Si la bonne decision est de ne rien changer, dis-le explicitement.
- Si une hypothese est verifiable localement, verifie-la avant de recommander.
- Si une seule question utilisateur bloque vraiment la decision, pose uniquement cette question.
- Si l'utilisateur propose une solution fragile ou incoherente avec le code, dis-le clairement et recommande une meilleure voie.
- Ne code rien si la decision exige une validation utilisateur qui n'a pas encore ete donnee.

## Relation avec les autres skills

Utilise `guide-me` pour debloquer une decision locale pendant une tache en cours.

Utilise plutot `grill-me` quand l'utilisateur veut challenger un plan complet, explorer les branches de decision, ou obtenir un plan recommande avant implementation.

Utilise plutot un workflow de debugging quand le probleme principal est une erreur observee, un test qui echoue, ou un comportement inattendu a diagnostiquer systematiquement.
