# Test Assignment: Random User Fetcher

## Overview
This repository contains the implementation of a test assignment that fetches random users
from the RandomUser API along with additional metadata such as name, avatar, and contact details.

## Folder Structure
```
ruc-app/
├── apps/
│   └── ruc-app/
├── modules/
│   ├── ruc-app
    ├── ruc-core
│   └── ruc-ui
├── tools/
│   ├── swiftlint
│   └── swiftformat
```

## Tech Stack
- **Language:** Swift
- **Frameworks:** UIKit, SwiftUI / async-await
- **Networking:** RandomUser REST API
- **Package Management:** Swift Package Manager
- **Testing:** XCTest

No runtime third-party libraries; dev dependencies are only for code formatting and linting
(SwiftFormat, SwiftLint).

## Modules Overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                            ruc-app                                  │
│                                                                     │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │                          RUCApp                              │   │
│  │                     (composition root)                       │   │
│  └───────┬──────────────────┬──────────────┬────────────────────┘   │
│          │                  │              │                        │
│          ▼                  ▼              ▼                        │
│  ┌───────────────┐  ┌──────────────┐  ┌───────────────────────┐     │
│  │   UsersList   │  │  UserDetail  │  │    RandomUserData     │     │
│  │               │  │              │  │                       │     │
│  │ ┄ UserDetail  │  │              │  │ RandomUserRepository  │     │
│  │   Builder     │  │              │  │   Implementation      │     │
│  └───────┬───────┘  └──────┬───────┘  └───────────┬───────────┘     │
│             (protocol only)                       │                 │
│          └── ── ──┬── ─── ─┘                      │                 │
│                   ▼                               ▼                 │
│          ┌─────────────────────┐       ┌───────────────────────┐    │
│          │  RandomUserDomain   │       │       RUCCore         │    │
│          │                     │◄──────│     RUCNetwork        │    │
│          │ RandomUserRepository│       │                       │    │
│          │     Protocol        │       └───────────────────────┘    │
│          └─────────────────────┘                                    │
│                                                                     │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │  RUCUI  (shared by UsersList + UserDetail)                   │   │
│  └──────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘

── solid arrow  = concrete dependency
┄  dashed       = protocol-only boundary (known coupling, to revisit)
```

**Explanation:**
- **RUCCore** – Core utilities shared across all modules.
- **RUCNetwork** – Networking layer consumed by `RandomUserData`.
- **RandomUserDomain** – Domain models and `RandomUserRepositoryProtocol`. No dependencies.
- **RandomUserData** – Concrete `RandomUserRepositoryImplementation`. Only imported by `RUCApp`.
- **UsersList** – List feature module. Depends on `RandomUserDomain` and `UserDetailBuilder` protocol only.
- **UserDetail** – Detail feature module. Exposes `UserDetailBuilder` protocol consumed by `UsersList`.
- **RUCUI** – Shared design system consumed by `UsersList` and `UserDetail`.
- **RUCApp** – Composition root. Wires concrete implementations and owns all module dependencies.

## Notes / Challenges

- The `UsersList` → `UserDetail` dependency is a **known coupling** to be revisited; currently
  bridged via a protocol-only boundary as a pragmatic intermediate step.