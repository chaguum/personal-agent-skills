# Prompt correctif de sous-session

Produis un prompt autonome destiné à la même sous-session. Il doit contenir :

1. **Contexte de revue**
   - Rappeler la mission active, son objectif et son périmètre autorisé.
   - Rappeler le numéro de correction en cours.
   - Rappeler les critères d’acceptation et les vérifications qui restent la source de vérité.
2. **Écarts prouvés**
   - Lister uniquement les écarts prouvés par l’audit.
   - Associer chaque écart à une preuve concrète : diff, fichier, commande ou sortie de test.
3. **Corrections attendues**
   - Décrire uniquement les corrections à apporter pour fermer ces écarts prouvés.
   - Interdire tout changement sans lien direct avec ces écarts.
4. **Vérifications à rejouer**
   - Lister uniquement les commandes ou contrôles à rejouer après correction.
   - Préciser les résultats attendus quand ils sont observables.
5. **Règles d’exécution**
   - Corriger ces écarts prouvés sans élargir le périmètre.
   - Préserver les changements étrangers.
   - Ne créer aucun commit : l’orchestratrice commit après audit.
   - Mettre à jour `PROGRESS.md` avec un état de reprise synthétique : résultat courant, vérifications relancées, risque restant et prochaine action.
   - Si un nouvel écart impose de changer le plan global ou révèle un arbitrage utilisateur, documenter la découverte dans `PROGRESS.md`, passer la mission à `attente-utilisateur`, puis s’arrêter sans improviser une nouvelle mission.
6. **Clôture**
   - Résumer les corrections appliquées et les preuves de vérification.
   - Demander à l’utilisateur de revenir dans la session orchestratrice avec `session done`.

Le prompt est terminé lorsqu’une sous-session peut corriger uniquement les écarts prouvés sans redemander le contexte déjà présent dans le dépôt.
