---
name: create-thread
description: Create or continue visible user threads in Codex Desktop with the Codex App thread tools, an exact known project, and a project worktree. Use only when the user explicitly asks to create, parallelize, or continue Codex tasks in separate threads.
---

# Create Thread

Create visible Codex Desktop tasks in a project worktree, or send a correction to an existing thread. Treat the tool availability and exact API values below as hard contracts.

## Preconditions

- Use this skill only for user-visible threads requested by the user. Do not use it to delegate an internal orchestration subtask.
- Confirm that the current session exposes `codex_app__list_projects` and `codex_app__create_thread` before attempting creation. For continuation, confirm `codex_app__send_message_to_thread`.
- If a required tool is absent, stop and report that this session has no thread-creation API. No prompt, formatting, or fallback can bypass that missing capability.

## Create a Thread

1. Call `codex_app__list_projects({})` first. Find the requested project and copy its exact identifier; do not infer or normalize it. For the Courses & Recette project, the expected identifier is:

   `C:\Users\hugol\Documents\Courses & Recette`

2. Create the thread with `codex_app__create_thread`. Preserve these values exactly:

   ```javascript
   await codex_app__create_thread({
     model: "gpt-5.6-luna",
     thinking: "high",
     prompt: "Ton prompt détaillé ici",
     target: {
       type: "project",
       projectId: "C:\\Users\\hugol\\Documents\\Courses & Recette",
       environment: {
         type: "worktree",
         startingState: {
           type: "branch",
           branchName: "codex/ma-branche-de-base"
         }
       }
     }
   })
   ```

   Never substitute `gpt-5.6-luna` with a display label such as `5.6 Luna High`, and never substitute `thinking: "high"` with a human-readable label.

3. Read the returned `clientThreadId` exactly. After each successful creation, emit one directive on its own line in the final response:

   `::created-thread{clientThreadId="client-new-thread:..."}`

### Parallel tasks

For three parallel tasks, make three separate `codex_app__create_thread` calls. Give every call a distinct detailed `prompt` and a distinct `startingState.branchName`; keep the same exact `model`, `thinking`, project target, and worktree shape. Emit one `created-thread` directive for each returned client thread ID.

## Continue an Existing Thread

Use the exact existing thread identifier and call:

```javascript
await codex_app__send_message_to_thread({
  threadId: "...",
  prompt: "Correctif à appliquer..."
})
```

Do not emit `created-thread` for a continuation; emit it only after a new thread is successfully created.

## Completion Check

Before reporting success, verify that:

- the project was listed before creation;
- the exact project identifier was passed as `projectId`;
- every new thread uses `model: "gpt-5.6-luna"` and `thinking: "high"`;
- every new thread has a project worktree and its requested starting branch;
- every successful creation has its own exact `::created-thread{clientThreadId="..."}` directive.
