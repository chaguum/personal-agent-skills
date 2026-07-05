---
name: tune-me
description: Use when the user explicitly requests a tight UX/UI adjustment loop for bounded visual or local interaction changes.
---

# Tune Me

Maintenir une boucle serrée : observer, ajuster, montrer, recueillir le retour.

## 1. Borner l’ajustement

1. Lire les `AGENTS.md` applicables et respecter leurs commandes.
2. Inspecter `git status` et les changements déjà présents. Préserver le travail
   étranger ; continuer sur un fichier modifié seulement si les intentions sont
   compatibles.
3. Classer le besoin :
   - **niveau 1** : texte, position, couleur, espacement, icône ou style local,
     sans changement de comportement ni de contrat accessible ;
   - **niveau 2 léger** : interaction, état ou accessibilité locale, sans impact
     métier, sécurité, données, architecture, dépendance ou parcours complet.
4. Hors de ces limites, arrêter avant modification et proposer le workflow
   normal ou une invocation explicite de `$orchestrate`.
   Ne déclenche jamais `$orchestrate` automatiquement.

## 2. Donner accès à l’application

1. Réutiliser le serveur du dépôt. Sinon, le lancer en arrière-plan avec la
   commande de `AGENTS.md`, vérifier son URL et mémoriser sa propriété.
2. Dès l’invocation, répondre avec l’URL locale comme lien cliquable et attendre que l’utilisateur ouvre l’application.

## 3. Ouvrir la boucle visuelle

**REQUIRED SUB-SKILL:** Use `browser:control-in-app-browser`.

1. Après confirmation de l’ouverture, inspecter la page, le viewport et la
   console dans le navigateur intégré.
2. Si son contrôle échoue, arrêter et le signaler : aucun fallback Playwright,
   navigateur externe ou simulation.

## 4. Itérer

Pour chaque instruction textuelle, annotations ou captures :

1. Réinspecter la page active ; ne pas déduire le DOM d’une ancienne capture.
2. Appliquer le plus petit changement sans plan, spec, maquette ou documentation
   durable.
3. Pour un niveau 2, suivre RED → GREEN avec le test comportemental ciblé.
   N’ajouter aucun test pour un niveau 1 sans contrat modifié.
4. Recharger et vérifier viewport, console et interaction touchée. Contrôler
   uniquement les breakpoints pertinents si le responsive change.
5. Montrer le résultat dans le navigateur intégré et attendre le prochain
   retour. Ne pas déclarer la boucle terminée à la place de l’utilisateur.

## 5. Clore

1. Exécuter les vérifications proportionnelles de `AGENTS.md` : diff et contrôle
   ciblé au niveau 1 ; test ciblé et contrôles affectés au niveau 2.
2. Inspecter le diff final et confirmer que les changements étrangers sont
   préservés.
3. Arrêter uniquement le serveur lancé par cette session.
4. Résumer les ajustements, les vérifications et tout risque restant.
5. Ne créer aucun commit sauf demande explicite.

## Garde-fous

| Situation | Action |
| --- | --- |
| Navigateur intégré indisponible | Arrêter sans fallback |
| Retour ambigu | Demander une seule précision visuelle |
| Changement structurel découvert | Arrêter et proposer une escalade explicite |
| Fichier déjà modifié | Préserver les deux intentions ou arrêter en cas de conflit |
| Validation complète non requise | Ne pas lancer de suite sans rapport |
