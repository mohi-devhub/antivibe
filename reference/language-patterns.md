# Language & Framework Patterns Reference

This file documents common patterns found in AI-generated code and explains when/why to use them.

## JavaScript / TypeScript

### React Patterns

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| `useState` hook | Function component state | Local UI state that changes over time |
| `useEffect` hook | Side effects in components | Data fetching, subscriptions, DOM manipulation |
| `useCallback` | Memoize functions | Pass callbacks to optimized child components |
| `useMemo` | Memoize computed values | Expensive calculations, object reference stability |
| Custom hooks | Extract component logic | Share stateful logic between components |
| Context API | Global state | Theme, auth, settings - truly global data |
| Compound components | Implicit state sharing | UI libraries, flexible component APIs |

### Node.js Patterns

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Middleware | Request/response interceptor | Logging, auth, validation, CORS |
| Error-first callbacks | Node.js async convention | Legacy code, some npm packages |
| Promise chains | Async flow control | Sequential async operations |
| async/await | Syntactic sugar for promises | Modern async code |
| Event emitter | Pub/sub pattern | Loose coupling, notifications |

## Python

### Django Patterns

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Class-based views | Object-oriented views | Reusable view logic |
| ModelForms | Form from model | Standard CRUD forms |
| Middleware | Request/response processing | Auth, caching, logging |
| Signals | Decoupled events | When models change, trigger actions |
| Managers | Custom queryset methods | Reusable query logic |

### FastAPI Patterns

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Dependencies | Injection via function | Shared logic, auth, DB sessions |
| Pydantic models | Data validation | API request/response validation |
| Routers | Modular endpoints | Large APIs, team organization |

## Go

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Functional options | Config objects | APIs that need many options |
| Error wrapping | Context-rich errors | Production code, debugging |
| Interfaces | Polymorphism | Testable code, abstractions |
| Defer | Cleanup on scope exit | Resource cleanup, logging |
| Goroutines | Concurrent execution | I/O-bound concurrent tasks |

## Rust

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Ownership/Borrowing | Memory safety without GC | Systems programming, performance |
| Result/Option | Explicit error handling | Fallible operations |
| Traits | Interface-like patterns | Polymorphism, generics |
| Lifetimes | Reference validity | Complex references, data structures |

## Common Design Patterns

### Creational

| Pattern | Purpose | Example |
|---------|---------|---------|
| Factory | Create objects without specifying class | `createConnection(config)` |
| Builder | Complex object construction | `UserBuilder().name().email().build()` |
| Singleton | One instance only | Database connection |
| Prototype | Clone existing objects | Copying configurations |

### Structural

| Pattern | Purpose | Example |
|---------|---------|---------|
| Adapter | Bridge incompatible interfaces | Wrapper around legacy code |
| Decorator | Add behavior dynamically | Logging, caching layers |
| Proxy | Controlled access | Auth checks, lazy loading |
| Facade | Simplified interface | Library wrappers |

### Behavioral

| Pattern | Purpose | Example |
|---------|---------|---------|
| Observer | Event notification | Event handling, pub/sub |
| Strategy | Interchangeable algorithms | Payment processing |
| Command | Encapsulate operations | Undo/redo, queues |
| Iterator | Traverse collections | Looping patterns |

## Resources

- [Refactoring Guru](https://refactoring.guru/design-patterns) - Design patterns explained
- [Patterns.dev](https://patterns.dev) - Web-specific patterns
- [SourceMaking](https://sourcemaking.com/design_patterns) - Patterns with examples