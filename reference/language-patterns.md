# Language & Framework Patterns Reference

This file documents common patterns found in AI-generated code and explains when/why to use them.

## JavaScript / TypeScript

### React Patterns

| Pattern | Explanation | When to Use | Prerequisites |
|---------|-------------|-------------|---------------|
| `useState` hook | Function component state | Local UI state that changes over time | JavaScript, React components, closures |
| `useEffect` hook | Side effects in components | Data fetching, subscriptions, DOM manipulation | `useState`, browser lifecycle, async JS |
| `useCallback` | Memoize functions | Pass callbacks to optimized child components | `useEffect`, referential equality, re-render triggers |
| `useMemo` | Memoize computed values | Expensive calculations, object reference stability | `useCallback`, memoization concept |
| Custom hooks | Extract component logic | Share stateful logic between components | `useState`, `useEffect`, JS modules |
| Context API | Global state | Theme, auth, settings - truly global data | React component tree, props drilling |
| Compound components | Implicit state sharing | UI libraries, flexible component APIs | Context API, component composition |

### Node.js Patterns

| Pattern | Explanation | When to Use | Prerequisites |
|---------|-------------|-------------|---------------|
| Middleware | Request/response interceptor | Logging, auth, validation, CORS | HTTP request/response cycle, functions |
| Error-first callbacks | Node.js async convention | Legacy code, some npm packages | Callbacks, async JS basics |
| Promise chains | Async flow control | Sequential async operations | Promises, async JS |
| async/await | Syntactic sugar for promises | Modern async code | Promises, try/catch |
| Event emitter | Pub/sub pattern | Loose coupling, notifications | Events, callbacks, observer pattern |

## Python

### Django Patterns

| Pattern | Explanation | When to Use | Prerequisites |
|---------|-------------|-------------|---------------|
| Class-based views | Object-oriented views | Reusable view logic | OOP, HTTP methods, Django routing |
| ModelForms | Form from model | Standard CRUD forms | Django models, HTML forms, validation |
| Middleware | Request/response processing | Auth, caching, logging | HTTP lifecycle, Django request object |
| Signals | Decoupled events | When models change, trigger actions | Observer pattern, Django ORM |
| Managers | Custom queryset methods | Reusable query logic | Django ORM, SQL basics |

### FastAPI Patterns

| Pattern | Explanation | When to Use | Prerequisites |
|---------|-------------|-------------|---------------|
| Dependencies | Injection via function | Shared logic, auth, DB sessions | Dependency injection concept, Python callables |
| Pydantic models | Data validation | API request/response validation | Python type hints, JSON, dataclasses |
| Routers | Modular endpoints | Large APIs, team organization | HTTP routing, Python modules |

## Go

| Pattern | Explanation | When to Use | Prerequisites |
|---------|-------------|-------------|---------------|
| Functional options | Config objects | APIs that need many options | Go functions, variadic args, structs |
| Error wrapping | Context-rich errors | Production code, debugging | Go error interface, `fmt.Errorf` |
| Interfaces | Polymorphism | Testable code, abstractions | Go types, methods, duck typing |
| Defer | Cleanup on scope exit | Resource cleanup, logging | Go function scope, LIFO execution |
| Goroutines | Concurrent execution | I/O-bound concurrent tasks | Concurrency vs parallelism, channels |

## Rust

| Pattern | Explanation | When to Use | Prerequisites |
|---------|-------------|-------------|---------------|
| Ownership/Borrowing | Memory safety without GC | Systems programming, performance | Stack vs heap, memory management basics |
| Result/Option | Explicit error handling | Fallible operations | Enums, pattern matching, error handling |
| Traits | Interface-like patterns | Polymorphism, generics | OOP concepts, Rust types |
| Lifetimes | Reference validity | Complex references, data structures | Ownership, borrowing, Rust compiler |

## Common Design Patterns

### Creational

| Pattern | Purpose | Example | Prerequisites |
|---------|---------|---------|---------------|
| Factory | Create objects without specifying class | `createConnection(config)` | OOP, interfaces/polymorphism |
| Builder | Complex object construction | `UserBuilder().name().email().build()` | Method chaining, OOP |
| Singleton | One instance only | Database connection | Static state, thread safety |
| Prototype | Clone existing objects | Copying configurations | Object copying, deep vs shallow clone |

### Structural

| Pattern | Purpose | Example | Prerequisites |
|---------|---------|---------|---------------|
| Adapter | Bridge incompatible interfaces | Wrapper around legacy code | Interfaces, OOP |
| Decorator | Add behavior dynamically | Logging, caching layers | Interfaces, composition over inheritance |
| Proxy | Controlled access | Auth checks, lazy loading | Interfaces, delegation |
| Facade | Simplified interface | Library wrappers | Module design, abstraction |

### Behavioral

| Pattern | Purpose | Example | Prerequisites |
|---------|---------|---------|---------------|
| Observer | Event notification | Event handling, pub/sub | Events, callbacks, loose coupling |
| Strategy | Interchangeable algorithms | Payment processing | Interfaces, OOP, polymorphism |
| Command | Encapsulate operations | Undo/redo, queues | OOP, first-class functions |
| Iterator | Traverse collections | Looping patterns | Data structures, sequences |

## Resources

- [Refactoring Guru](https://refactoring.guru/design-patterns) - Design patterns explained
- [Patterns.dev](https://patterns.dev) - Web-specific patterns
- [SourceMaking](https://sourcemaking.com/design_patterns) - Patterns with examples