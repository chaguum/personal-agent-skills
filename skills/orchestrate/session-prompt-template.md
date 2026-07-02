# Prompt de sous-session

Produis un prompt autonome à copier-coller dans une nouvelle sous-session. Il doit contenir :

1. **Contexte**
   - Lire tous les `AGENTS.md` applicables.
   - Lire `PROGRESS.md`.
   - Inspecter le code concerné avant de modifier quoi que ce soit.
2. **Mission**
   - Un objectif unique.
   - Le périmètre autorisé et les exclusions.
   - Les dépendances déjà satisfaites.
3. **Résultat attendu**
   - Les critères d’acceptation observables.
   - Les vérifications et la Definition of Done applicables.
4. **Règles d’exécution**
   - Implémenter uniquement cette mission.
   - Préserver les changements étrangers.
   - Ne crée aucun commit : l’orchestratrice commit après audit.
   - Mettre à jour `PROGRESS.md` avec le travail effectué, les décisions, les fichiers modifiés, les vérifications, les résultats, les risques et la prochaine étape possible.
   - Si le plan global doit changer, ne pas élargir le périmètre : documenter la découverte, les options, la recommandation et l’impact dans `PROGRESS.md`, puis s’arrêter.
5. **Clôture**
   - Résumer les modifications et les preuves de vérification.
   - Demander à l’utilisateur de revenir dans la session orchestratrice avec `session done`.

Le prompt est terminé lorsqu’une sous-session sans autre contexte peut exécuter la mission sans redemander les informations déjà présentes dans le dépôt.
