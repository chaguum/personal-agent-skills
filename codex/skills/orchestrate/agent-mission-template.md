# Mission d’agent Codex

Produis une mission autonome à transmettre directement à un agent Codex. Elle doit contenir :

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
   - Maintenir dans `PROGRESS.md` un état de reprise synthétique : résultat courant, décisions durables, vérifications, risques et prochaine action. Placer le détail des fichiers modifiés et des preuves dans le retour final à l’orchestrateur.
   - Si le plan global doit changer, ne pas élargir le périmètre : documenter la découverte, les options, la recommandation et l’impact dans `PROGRESS.md`, puis s’arrêter.
5. **Clôture**
   - Résumer les modifications et les preuves de vérification.
   - Retourner le résultat à l’orchestrateur sans demander d’action intermédiaire à l’utilisateur.

La mission est prête lorsqu’un agent sans autre contexte peut l’exécuter sans redemander les informations déjà présentes dans le dépôt.
