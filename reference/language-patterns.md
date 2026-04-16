# Language & Framework Patterns Reference

Common patterns found in AI-generated code, organized by language and framework. Each entry explains what the pattern is, when to use it, and what to watch out for.

## JavaScript / TypeScript

### React Patterns

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| `useState` hook | Function component state | Local UI state that changes over time |
| `useEffect` hook | Side effects in components | Data fetching, subscriptions, DOM manipulation |
| `useCallback` | Memoize functions | Pass callbacks to optimized child components |
| `useMemo` | Memoize computed values | Expensive calculations, object reference stability |
| `useContext` | Consume context values | Access global state without prop drilling |
| `useReducer` | Complex state logic | State with multiple sub-values or complex transitions |
| `useRef` | Mutable ref container | DOM refs, storing previous values, instance variables |
| Custom hooks | Extract component logic | Share stateful logic between components |
| Context API | Global state | Theme, auth, settings - truly global data |
| Compound components | Implicit state sharing | UI libraries, flexible component APIs |
| Render props | Share code via props | Cross-cutting concerns, flexible rendering |
| Higher-Order Components | Wrap components | Legacy pattern for code reuse (prefer hooks) |
| Suspense + lazy | Code splitting | Route-level or component-level lazy loading |
| Error boundaries | Catch render errors | Graceful fallback UI for component failures |

### Next.js Patterns

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| App Router | File-based routing | Modern Next.js (v13+) applications |
| Server Components | Server-rendered by default | Data fetching, heavy computation on server |
| Client Components | `"use client"` directive | Interactive UI, browser APIs, event handlers |
| Server Actions | `"use server"` functions | Form submissions, mutations from client |
| ISR (Incremental Static Regen) | Stale-while-revalidate | Content that changes periodically |
| Middleware | Edge request processing | Auth, redirects, rewrites at edge |
| Parallel routes | `@folder` convention | Dashboards, modals alongside content |

### Node.js Patterns

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Middleware | Request/response interceptor | Logging, auth, validation, CORS |
| Error-first callbacks | Node.js async convention | Legacy code, some npm packages |
| Promise chains | Async flow control | Sequential async operations |
| async/await | Syntactic sugar for promises | Modern async code (preferred) |
| Event emitter | Pub/sub pattern | Loose coupling, notifications |
| Streams | Chunked data processing | Large files, real-time data |
| Worker threads | CPU-bound parallelism | Heavy computation without blocking event loop |

### NestJS Patterns

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Modules | Feature encapsulation | Organize code by domain |
| Injectable services | Dependency injection | Business logic, shared services |
| Guards | Authorization checks | Route-level access control |
| Pipes | Input transformation/validation | DTO validation, type coercion |
| Interceptors | AOP-style cross-cutting | Logging, caching, response mapping |

## Python

### Django Patterns

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Class-based views | Object-oriented views | Reusable view logic, CRUD operations |
| Function-based views | Simple request handlers | Simple endpoints, one-off logic |
| ModelForms | Form from model | Standard CRUD forms |
| Middleware | Request/response processing | Auth, caching, logging |
| Signals | Decoupled events | When models change, trigger actions |
| Managers | Custom queryset methods | Reusable query logic |
| Mixins | Composable view behavior | LoginRequired, PermissionRequired |
| Template tags | Custom template logic | Reusable presentation logic |

### FastAPI Patterns

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Dependencies | Injection via function | Shared logic, auth, DB sessions |
| Pydantic models | Data validation | API request/response validation |
| Routers | Modular endpoints | Large APIs, team organization |
| Background tasks | Async post-response work | Email sending, logging |
| WebSocket endpoints | Real-time connections | Chat, live updates |
| Middleware | ASGI middleware | CORS, rate limiting, logging |

### Flask Patterns

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Blueprints | Modular application parts | Large apps, feature grouping |
| Application factory | Create app in function | Testing, multiple configurations |
| Decorators | Route + auth wrappers | Route definitions, access control |
| Context locals | Request-scoped globals | Access request/session anywhere |

## Go

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Functional options | Config via option funcs | APIs that need many optional settings |
| Error wrapping | `fmt.Errorf("%w", err)` | Add context to errors up the call stack |
| Interfaces | Implicit implementation | Testable code, polymorphism |
| Defer | Cleanup on scope exit | Resource cleanup, mutex unlock, logging |
| Goroutines + channels | CSP concurrency | I/O-bound concurrent tasks |
| Context | Cancellation/deadline/values | Request-scoped data, timeouts |
| Table-driven tests | Test with input/output tables | Exhaustive testing with minimal code |
| Middleware chains | HTTP handler wrapping | Logging, auth, rate limiting |
| Embedded structs | Composition over inheritance | Shared behavior between types |

## Rust

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Ownership/Borrowing | Memory safety without GC | All Rust code (core concept) |
| Result/Option | Explicit error handling | Fallible/nullable operations |
| Traits | Interface-like behavior | Polymorphism, generics constraints |
| Lifetimes | Reference validity | Complex references, data structures |
| `impl` blocks | Method definitions | Associated functions, methods |
| `?` operator | Error propagation | Clean error handling in functions |
| Builder pattern | Fluent construction | Complex object initialization |
| Iterators/closures | Functional processing | Collection transformations |
| `Arc<Mutex<T>>` | Shared mutable state | Thread-safe shared data |

## Java

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Spring DI | Constructor injection | Service wiring, testability |
| `@RestController` | HTTP endpoint handler | REST API endpoints |
| `@Service` / `@Repository` | Layer annotations | Business logic / data access |
| Streams API | Functional collection ops | Filter, map, reduce on collections |
| Optional | Nullable value wrapper | Return types that may be absent |
| Records | Immutable data carriers | DTOs, value objects (Java 16+) |
| CompletableFuture | Async computation | Non-blocking async operations |
| Lombok annotations | Boilerplate reduction | Getters, setters, builders |

## C# / .NET

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Dependency Injection | Constructor injection | ASP.NET Core services |
| async/await + Task | Async programming | I/O-bound operations |
| LINQ | Query expressions | Collection filtering/transformation |
| Extension methods | Add methods to types | Utility methods, fluent APIs |
| Records | Immutable reference types | DTOs, value equality |
| Pattern matching | `switch` expressions | Complex conditional logic |
| Middleware pipeline | Request processing | ASP.NET Core request handling |
| Entity Framework | ORM queries | Database access |

## Kotlin

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Data classes | Immutable value types | DTOs, models |
| Coroutines | Structured concurrency | Async operations |
| Extension functions | Add to existing types | Utility methods |
| Sealed classes | Restricted hierarchies | State machines, ADTs |
| Scope functions | `let`, `apply`, `run`, `also` | Object configuration, null checks |
| Flow | Reactive streams | Async data sequences |
| Companion objects | Static-like members | Factory methods, constants |

## Swift

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Protocols | Interface definitions | Abstraction, testability |
| Extensions | Add functionality to types | Organization, conformance |
| Closures | Inline functions | Callbacks, completion handlers |
| Optionals + guard | Safe null handling | Unwrapping optional values |
| Actors | Concurrency safety | Shared mutable state |
| Property wrappers | Custom property behavior | `@Published`, `@State`, `@Binding` |
| Result type | Explicit error handling | Async operations, parsing |

## Ruby / Rails

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Concerns | Shared module behavior | Cross-model/controller logic |
| Service objects | Business logic classes | Complex operations beyond CRUD |
| Decorators/Presenters | View logic objects | Complex view formatting |
| Callbacks | Lifecycle hooks | Before/after save, create, destroy |
| Scopes | Reusable query chains | Common query patterns |
| ActiveRecord patterns | Convention-based ORM | Database access in Rails |

## PHP / Laravel

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Service container | DI container | Dependency injection |
| Eloquent ORM | ActiveRecord pattern | Database queries |
| Middleware | Request filtering | Auth, CORS, logging |
| Facades | Static-like interface to services | Quick access to services |
| Artisan commands | CLI commands | Scheduled tasks, migrations |
| Blade templates | Templating engine | Server-rendered views |
| Jobs/Queues | Background processing | Email, notifications, heavy work |

## Vue.js

| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Composition API | `setup()` + composables | Complex component logic (Vue 3) |
| Options API | `data`, `methods`, `computed` | Simple components, Vue 2 compat |
| Composables | Reusable logic functions | Shared stateful logic |
| Pinia stores | State management | Global/shared state |
| Provide/Inject | Ancestor-descendant data | Theme, config, deeply nested data |
| Slots | Content distribution | Flexible, reusable components |

## Common Anti-Patterns (What NOT to Do)

| Anti-Pattern | Problem | Better Alternative |
|-------------|---------|-------------------|
| God object/component | One class does everything | Split into focused, single-responsibility units |
| Prop drilling | Passing props through many layers | Context/state management or composition |
| Premature optimization | Optimizing before measuring | Profile first, optimize bottlenecks |
| Magic numbers/strings | Unexplained literal values | Named constants with clear intent |
| Callback hell | Deeply nested async callbacks | async/await or Promise chains |
| Copy-paste code | Duplicated logic | Extract shared functions or hooks |
| Over-engineering | Abstractions for one use case | YAGNI — build what you need now |
| Ignoring errors | Empty catch blocks | Handle or propagate errors meaningfully |
| Tight coupling | Direct dependencies everywhere | Dependency injection, interfaces |
| N+1 queries | Query per item in a loop | Eager loading, batch queries |

## Design Patterns

### Creational

| Pattern | Purpose | Example |
|---------|---------|---------|
| Factory | Create objects without specifying class | `createConnection(config)` |
| Builder | Complex object construction | `UserBuilder().name().email().build()` |
| Singleton | One instance only | Database connection pool |
| Prototype | Clone existing objects | Copying configurations |

### Structural

| Pattern | Purpose | Example |
|---------|---------|---------|
| Adapter | Bridge incompatible interfaces | Wrapper around legacy code |
| Decorator | Add behavior dynamically | Logging, caching layers |
| Proxy | Controlled access | Auth checks, lazy loading |
| Facade | Simplified interface | Library wrappers |
| Composite | Tree structure | File system, UI component trees |

### Behavioral

| Pattern | Purpose | Example |
|---------|---------|---------|
| Observer | Event notification | Event handling, pub/sub |
| Strategy | Interchangeable algorithms | Payment processing, sorting |
| Command | Encapsulate operations | Undo/redo, task queues |
| Iterator | Traverse collections | Custom iteration logic |
| State | Object behavior changes with state | UI states, workflows |
| Template Method | Algorithm skeleton with steps | Framework hooks |

## Resources

- [Refactoring Guru](https://refactoring.guru/design-patterns) - Design patterns explained visually
- [Patterns.dev](https://patterns.dev) - Web-specific patterns with examples
- [SourceMaking](https://sourcemaking.com/design_patterns) - Patterns with code examples
- [React Patterns](https://react.dev/learn) - Official React patterns guide
