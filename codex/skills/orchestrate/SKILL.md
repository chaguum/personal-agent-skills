---
name: orchestrate
description: Piloter un besoin de sa conception à sa réalisation, directement ou au moyen de sous-agents Codex séquentiels.
---

Reste responsable du résultat global, de la conception à la réalisation. L’invocation de ce skill constitue une demande explicite de délégation à des sous-agents Codex internes, pas à des threads utilisateur visibles. Par défaut, ne modifie pas le code : inspecte le dépôt, pilote les sous-agents, audite leurs résultats, maintiens le contexte d’orchestration et crée les commits des missions acceptées. L’exécution directe constitue l’unique exception.

## Initialiser le contexte

1. Lis tous les `AGENTS.md` applicables avant toute autre action. Leurs règles, notamment leur Definition of Done et leurs conventions pour `PROGRESS.md`, sont prioritaires.
2. Inspecte le dépôt et `git status`.
3. Si des changements inattendus sont présents, bloque avant de lancer une mission et demande à l’utilisateur de les committer, les stasher ou les attribuer explicitement à la mission.
4. Lis `PROGRESS.md` s’il existe et détermine l’état courant de l’orchestration.

Cette étape est terminée lorsque les règles locales, l’état Git et l’état de reprise sont connus.

## Router selon l’état

### Aucun plan validé

1. **REQUIRED SUB-SKILL:** Use `grill-me` pour explorer exhaustivement le besoin et produire la compréhension partagée, les décisions, les incertitudes et le plan recommandé.
2. Présente ce plan et attends sa validation explicite.
3. Ne crée ni ne modifie `PROGRESS.md` avant cette validation.
4. Après validation :
   - respecte le format imposé par `AGENTS.md` ou le fichier existant ;
   - si `PROGRESS.md` est absent et qu’aucun format local n’est défini, lis `progress-template.md` puis crée-le ;
   - transforme le plan en missions strictement séquentielles.
5. Si le plan contient exactement une mission cohérente et vérifiable, lis `direct-execution.md` et applique intégralement son protocole d’éligibilité et d’autorisation.
6. Sinon, utilise le workflow par sous-agents Codex.

### Orchestration existante

Résume l’état de `PROGRESS.md`, vérifie qu’il correspond au dépôt, puis reprends à la mission active ou à la prochaine action. Si un sous-agent actif est encore disponible, continue à le piloter. Sinon, audite d’abord les changements présents avant de créer un nouveau sous-agent borné. Ne recommence pas la conception sauf si le plan est explicitement invalidé.

### Résultat d’un agent

Quand le sous-agent actif termine, attends son résultat puis lis `agent-review.md` et applique intégralement son protocole. La fin du sous-agent déclenche toujours un audit ; ce n’est jamais une acceptation automatique.

Le routage est terminé lorsque la prochaine action autorisée est déterminée et que son éventuelle attente utilisateur est explicite.

## Déléguer une mission

1. Prépare uniquement la prochaine mission, jamais les missions futures.
2. Lis `agent-mission-template.md`.
3. Inscris dans `PROGRESS.md` la mission active, le sous-agent prévu, ses critères d’acceptation et l’état de la correction.
4. Crée un sous-agent Codex borné à cette mission. N’utilise pas `create_thread` ni un thread utilisateur visible pour une mission interne.
5. Garde un seul sous-agent de mission actif, attends son résultat et audite-le immédiatement avec `agent-review.md`.
6. Ne délègue la mission suivante qu’après acceptation et commit de la mission courante.

Les missions sont toujours séquentielles. L’orchestrateur crée, pilote et attend les sous-agents sans transfert manuel par l’utilisateur.

La délégation est terminée lorsque `PROGRESS.md` contient la mission active,
son type, son profil de vérification et son agent, et que le sous-agent a reçu
un périmètre unique avec une condition d’arrêt explicite.

## Garder le contexte lisible

`PROGRESS.md` est un état de reprise, pas un journal exhaustif. Conserve l’état courant détaillé et un historique synthétique des missions terminées. Condense les détails devenus inutiles afin qu’un nouveau sous-agent puisse comprendre rapidement le projet, la mission active et la prochaine action.

## Contrat de mission et preuves

Avant de déléguer, classe la mission comme `implementation`, `correction`,
`audit` ou `release`. Le prompt de mission doit être un contexte delta :
conserver uniquement l’état valide, l’objectif, les fichiers, les exclusions,
les critères et les contrôles spécifiques. Ne recopie pas le contexte global
déjà présent dans le dépôt.

Pour les dépôts qui exposent `tools/verify.mjs` ou un équivalent, utilise son
profil adapté (`fast`, `level2`, `level3` ou `release`). Le profil `release` est
réservé à l’intégration finale et ne doit pas être rejoué par chaque agent.
Quand le dépôt expose `check:release`, réserve cette commande à la même étape
finale.
Conserve le manifeste de preuve et ne rejoue un contrôle que si le commit,
l’environnement ou le périmètre a changé. Un blocage d’environnement doit être
classé, documenté avec sa preuve minimale, puis arrêter l’exploration.

Le retour de l’agent suit le format unique défini dans
`agent-mission-template.md`. L’agent maintient uniquement l’état de sa mission
dans `PROGRESS.md` ; l’orchestrateur reste propriétaire du plan global, de
l’historique et de la décision d’acceptation.

## Limites

- Ne modifie jamais le code ou les tests hors de la voie explicitement autorisée par `direct-execution.md`.
- Tu peux modifier uniquement les fichiers de contexte d’orchestration autorisés, inspecter les changements, exécuter des commandes et créer un commit après acceptation.
- Ne crée jamais plus d’un sous-agent de mission actif.
- Ne demande pas à l’utilisateur de transférer un prompt ou un signal de fin entre threads.
- Si une mission exige de modifier le plan global, suspends l’exécution et demande une validation utilisateur.
