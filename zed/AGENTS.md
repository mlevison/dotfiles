## 18-typescript-types

# TypeScript Type Best Practices

## Rule
**Use discriminated unions to model data that can be in one of a few different shapes and prevent impossible states.**

## Problem
Generic object types with optional properties can lead to impossible states and runtime errors.

## Solution
```typescript
// Use discriminated unions
type FetchingState<TData> =
  | { status: "idle" }
  | { status: "loading" }
  | { status: "success"; data: TData }
  | { status: "error"; error: Error };
```

## Use Cases
- API response states
- Event handling
- Form validation states
- Authentication states
- Data loading states

## Why This Matters
Discriminated unions prevent impossible states at compile time and make switch statements exhaustive and type-safe.

## Examples and Use Cases

### Use Discriminated Unions for Events
Proactively use discriminated unions to model data that can be in one of a few different shapes:

```typescript
type UserCreatedEvent = {
  type: "user.created";
  data: { id: string; email: string };
};

type UserDeletedEvent = {
  type: "user.deleted";
  data: { id: string };
};

type Event = UserCreatedEvent | UserDeletedEvent;
```

Use switch statements to handle the results:

```typescript
const handleEvent = (event: Event) => {
  switch (event.type) {
    case "user.created":
      console.log(event.data.email); // TypeScript knows email exists
      break;
    case "user.deleted":
      console.log(event.data.id); // TypeScript knows only id exists
      break;
  }
};
```

### Prevent Impossible States
Use discriminated unions to prevent the 'bag of optionals' problem:

```typescript
// BAD - allows impossible states
type FetchingState<TData> = {
  status: "idle" | "loading" | "success" | "error";
  data?: TData;
  error?: Error;
};

// This allows impossible states like:
// { status: "success", error: Error } 
// { status: "error", data: someData }

// GOOD - prevents impossible states
type FetchingState<TData> =
  | { status: "idle" }
  | { status: "loading" }
  | { status: "success"; data: TData }
  | { status: "error"; error: Error };
```

### Prefer Interfaces for Inheritance
ALWAYS prefer interfaces when modelling inheritance. The `&` operator has terrible performance:

```typescript
// BAD - Intersection types are slow
type A = {
  a: string;
};

type B = {
  b: string;
};

type C = A & B;

// GOOD - Interface extension is fast
interface A {
  a: string;
}

interface B {
  b: string;
}

interface C extends A, B {
  // Additional properties can be added here
}
```

### Use Readonly Properties
Use `readonly` properties for object types by default to prevent accidental mutation:

```typescript
// BAD - Mutable properties
type User = {
  id: string;
  name: string;
  email: string;
};

// GOOD - Readonly properties
type User = {
  readonly id: string;
  readonly name: string;
  readonly email: string;
};

// Or use Readonly utility type
type User = Readonly<{
  id: string;
  name: string;
  email: string;
}>;
```

### Avoid Optional Properties
Use optional properties sparingly. Prefer explicit `| undefined`:

```typescript
// BAD - Unclear intent
type AuthOptions = {
  userId?: string;
  apiKey?: string;
};

// GOOD - Explicit undefined
type AuthOptions = {
  userId: string | undefined;
  apiKey: string | undefined;
};

// Even better - Use discriminated union
type AuthOptions = 
  | { type: "user"; userId: string }
  | { type: "api"; apiKey: string }
  | { type: "anonymous" };
```

### Form Validation States
```typescript
type FormFieldState<T> =
  | { status: "pristine" }
  | { status: "validating" }
  | { status: "valid"; value: T }
  | { status: "invalid"; error: string; value: T };

type LoginFormState = {
  email: FormFieldState<string>;
  password: FormFieldState<string>;
};
```

### API Response Types
```typescript
type ApiResponse<T> =
  | { success: true; data: T }
  | { success: false; error: string; code: number };

// Usage
async function fetchUser(id: string): Promise<ApiResponse<User>> {
  try {
    const user = await api.getUser(id);
    return { success: true, data: user };
  } catch (error) {
    return { 
      success: false, 
      error: "Failed to fetch user", 
      code: 500 
    };
  }
}

// Type-safe handling
const result = await fetchUser("123");
if (result.success) {
  console.log(result.data.name); // TypeScript knows data exists
} else {
  console.error(result.error); // TypeScript knows error exists
}
```

### Authentication States
```typescript
type AuthState = 
  | { status: "checking" }
  | { status: "authenticated"; user: User; token: string }
  | { status: "unauthenticated" }
  | { status: "expired"; previousUser: User };

const handleAuthState = (auth: AuthState) => {
  switch (auth.status) {
    case "checking":
      return <LoadingSpinner />;
    case "authenticated":
      return <Dashboard user={auth.user} />; // user is guaranteed to exist
    case "unauthenticated":
      return <LoginForm />;
    case "expired":
      return <ReloginForm previousUser={auth.previousUser} />;
  }
};
```

### Network Request States
```typescript
type NetworkState<T> =
  | { state: "idle" }
  | { state: "pending"; startTime: Date }
  | { state: "success"; data: T; duration: number }
  | { state: "error"; error: Error; retryCount: number };
```

## Benefits
- **Type Safety** - Prevents impossible states at compile time
- **Exhaustive Checking** - Switch statements must handle all cases
- **Better IntelliSense** - TypeScript provides accurate autocomplete
- **Self-Documenting** - The types clearly show what states are possible
- **Easier Refactoring** - Changes to types are caught at compile time

## Best Practices
1. **Use discriminated unions over optional properties**
2. **Prefer interfaces for object inheritance**
3. **Make properties readonly by default**
4. **Use explicit `| undefined` instead of optional properties**
5. **Model all possible states explicitly**
6. **Use exhaustive switch statements with discriminated unions**

## 19-enums-constants

# Enums and Constants

## Rule
**Do not introduce new enums into the codebase. Use `as const` objects instead for enum-like behavior.**

## Problem
TypeScript enums have confusing behavior, especially numeric enums that create reverse mappings and can lead to runtime bugs.

## Solution
```typescript
// Use as const objects instead of enums
const backendToFrontendEnum = {
  xs: "EXTRA_SMALL",
  sm: "SMALL",
  md: "MEDIUM",
} as const;

type LowerCaseEnum = keyof typeof backendToFrontendEnum; // "xs" | "sm" | "md"
type UpperCaseEnum = (typeof backendToFrontendEnum)[LowerCaseEnum]; // "EXTRA_SMALL" | "SMALL" | "MEDIUM"
```

## Use Cases
- API response mappings
- Configuration constants
- Status codes
- Color schemes
- Size variants

## Why This Matters
`as const` objects provide type safety without the runtime overhead and confusing behavior of enums.

## Examples and Use Cases

### Enum-like Behavior with as const
Instead of creating enums, use `as const` objects:

```typescript
// BAD - Don't create new enums
enum Size {
  SMALL = "sm",
  MEDIUM = "md", 
  LARGE = "lg"
}

// GOOD - Use as const objects
const Size = {
  SMALL: "sm",
  MEDIUM: "md",
  LARGE: "lg",
} as const;

type SizeKeys = keyof typeof Size; // "SMALL" | "MEDIUM" | "LARGE"
type SizeValues = (typeof Size)[SizeKeys]; // "sm" | "md" | "lg"
```

### Backend to Frontend Mapping
```typescript
const statusMapping = {
  pending: "PENDING_APPROVAL",
  approved: "APPROVED_STATUS", 
  rejected: "REJECTED_STATUS",
  cancelled: "CANCELLED_STATUS",
} as const;

type FrontendStatus = keyof typeof statusMapping;
type BackendStatus = (typeof statusMapping)[FrontendStatus];

// Usage
function mapToBackendStatus(frontendStatus: FrontendStatus): BackendStatus {
  return statusMapping[frontendStatus];
}
```

### Color Constants
```typescript
const Colors = {
  PRIMARY: "#007bff",
  SECONDARY: "#6c757d", 
  SUCCESS: "#28a745",
  DANGER: "#dc3545",
  WARNING: "#ffc107",
  INFO: "#17a2b8",
} as const;

type ColorName = keyof typeof Colors;
type ColorValue = (typeof Colors)[ColorName];

// Usage
function getColor(name: ColorName): ColorValue {
  return Colors[name];
}
```

### API Endpoints
```typescript
const ApiEndpoints = {
  USERS: "/api/users",
  POSTS: "/api/posts",
  COMMENTS: "/api/comments",
  AUTH: "/api/auth",
} as const;

type EndpointName = keyof typeof ApiEndpoints;
type EndpointPath = (typeof ApiEndpoints)[EndpointName];
```

### HTTP Status Codes
```typescript
const HttpStatus = {
  OK: 200,
  CREATED: 201,
  BAD_REQUEST: 400,
  UNAUTHORIZED: 401,
  FORBIDDEN: 403,
  NOT_FOUND: 404,
  INTERNAL_SERVER_ERROR: 500,
} as const;

type StatusName = keyof typeof HttpStatus;
type StatusCode = (typeof HttpStatus)[StatusName];
```

### Numeric Enum Gotcha
Remember that numeric enums behave differently to string enums. Numeric enums produce a reverse mapping:

```typescript
// BAD - Numeric enum creates reverse mapping
enum Direction {
  Up,    // 0
  Down,  // 1
  Left,  // 2
  Right, // 3
}

const direction = Direction.Up; // 0
const directionName = Direction[0]; // "Up" - reverse lookup!

Object.keys(Direction).length; // 8 (not 4!) because of reverse mapping
// ["0", "1", "2", "3", "Up", "Down", "Left", "Right"]

// GOOD - Use as const to avoid confusion
const Direction = {
  UP: "up",
  DOWN: "down", 
  LEFT: "left",
  RIGHT: "right",
} as const;

Object.keys(Direction).length; // 4 as expected
// ["UP", "DOWN", "LEFT", "RIGHT"]
```

### Configuration Constants
```typescript
const Config = {
  MAX_FILE_SIZE: 5 * 1024 * 1024, // 5MB
  MAX_USERNAME_LENGTH: 50,
  MIN_PASSWORD_LENGTH: 8,
  SESSION_TIMEOUT: 30 * 60 * 1000, // 30 minutes
  API_TIMEOUT: 10000, // 10 seconds
} as const;

type ConfigKey = keyof typeof Config;
type ConfigValue = (typeof Config)[ConfigKey];
```

### Theme Constants
```typescript
const Theme = {
  SPACING: {
    XS: "0.25rem",
    SM: "0.5rem", 
    MD: "1rem",
    LG: "1.5rem",
    XL: "2rem",
  },
  BORDER_RADIUS: {
    SMALL: "4px",
    MEDIUM: "8px",
    LARGE: "12px",
  },
  BREAKPOINTS: {
    MOBILE: "480px",
    TABLET: "768px", 
    DESKTOP: "1024px",
  },
} as const;

type SpacingSize = keyof typeof Theme.SPACING;
type SpacingValue = (typeof Theme.SPACING)[SpacingSize];
```

### Event Types
```typescript
const EventTypes = {
  USER_LOGIN: "user:login",
  USER_LOGOUT: "user:logout",
  POST_CREATED: "post:created",
  POST_UPDATED: "post:updated",
  POST_DELETED: "post:deleted",
} as const;

type EventType = (typeof EventTypes)[keyof typeof EventTypes];

// Usage with discriminated unions
type UserEvent = {
  type: typeof EventTypes.USER_LOGIN | typeof EventTypes.USER_LOGOUT;
  userId: string;
  timestamp: Date;
};

type PostEvent = {
  type: typeof EventTypes.POST_CREATED | typeof EventTypes.POST_UPDATED | typeof EventTypes.POST_DELETED;
  postId: string;
  authorId: string;
  timestamp: Date;
};
```

## Benefits
- **No reverse mapping confusion** like numeric enums
- **Tree-shakeable** - unused constants can be removed
- **Explicit values** - you can see exactly what the runtime values are
- **Type safety** - still get full TypeScript checking
- **Better performance** - no enum runtime overhead
- **Clearer intent** - more obvious what the values will be at runtime

## Migration from Existing Enums
If you need to work with existing enums, you can gradually migrate:

```typescript
// Existing enum (keep for now)
enum OldStatus {
  PENDING = "pending",
  COMPLETED = "completed",
}

// New as const version
const Status = {
  PENDING: "pending" as const,
  COMPLETED: "completed" as const,
} as const;

// Gradually replace usage
function handleStatus(status: (typeof Status)[keyof typeof Status]) {
  // Implementation
}
```

## Best Practices
1. **Use `as const` objects instead of creating new enums**
2. **Retain existing enums to avoid breaking changes**
3. **Use descriptive constant names in ALL_CAPS**
4. **Group related constants in objects**
5. **Export types for keys and values separately**
6. **Prefer string values over numbers for clarity**

## 20-imports-exports

# Import and Export Conventions

## Rule
**Avoid default exports unless explicitly required by the framework. Use named exports and proper import type syntax.**

## Problem
Default exports make refactoring harder, reduce discoverability, and can lead to inconsistent naming across files.

## Solution
```typescript
// Use named exports
export function myFunction() {
  return <div>Hello</div>;
}

// Use import type for types
import type { User } from "./user";
```

## Use Cases
- Component exports
- Utility function exports
- Type definitions
- API functions
- Configuration objects

## Why This Matters
Named exports provide better IDE support, easier refactoring, and more consistent codebase organization.

## Examples and Use Cases

### No Default Exports
Unless explicitly required by the framework, do not use default exports:

```typescript
// BAD - Default export
export default function myFunction() {
  return <div>Hello</div>;
}

// Also BAD - Mixed default and named
export default function MyComponent() {
  return <div>Hello</div>;
}
export const utils = {};

// GOOD - Named exports only
export function myFunction() {
  return <div>Hello</div>;
}

export const utils = {};
```

### Import Types Properly
Use import type whenever you are importing a type. Prefer top-level `import type`:

```typescript
// BAD - Inline type import
import { type User, type Role } from "./user";

// GOOD - Top-level import type
import type { User, Role } from "./user";

// Mixed imports (when you need both types and values)
import { getUserById } from "./user";
import type { User } from "./user";
```

### Component Exports
```typescript
// components/Button.tsx
export function Button({ children, onClick }: ButtonProps) {
  return <button onClick={onClick}>{children}</button>;
}

export function PrimaryButton(props: ButtonProps) {
  return <Button {...props} className="btn-primary" />;
}

export function SecondaryButton(props: ButtonProps) {
  return <Button {...props} className="btn-secondary" />;
}

// Export types
export type { ButtonProps };
```

### Utility Functions
```typescript
// utils/string.ts
export function capitalize(str: string): string {
  return str.charAt(0).toUpperCase() + str.slice(1);
}

export function slugify(str: string): string {
  return str.toLowerCase().replace(/\s+/g, '-');
}

export function truncate(str: string, length: number): string {
  return str.length > length ? str.substring(0, length) + '...' : str;
}

// Export types if needed
export type StringProcessor = (str: string) => string;
```

### API Functions
```typescript
// api/users.ts
export async function getUser(id: string): Promise<User> {
  const response = await fetch(`/api/users/${id}`);
  return response.json();
}

export async function createUser(userData: CreateUserData): Promise<User> {
  const response = await fetch('/api/users', {
    method: 'POST',
    body: JSON.stringify(userData),
  });
  return response.json();
}

export async function updateUser(id: string, updates: Partial<User>): Promise<User> {
  const response = await fetch(`/api/users/${id}`, {
    method: 'PATCH',
    body: JSON.stringify(updates),
  });
  return response.json();
}

// Export types
export type { User, CreateUserData };
```

### Configuration Objects
```typescript
// config/database.ts
export const databaseConfig = {
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432'),
  database: process.env.DB_NAME || 'myapp',
};

export const redisConfig = {
  host: process.env.REDIS_HOST || 'localhost',
  port: parseInt(process.env.REDIS_PORT || '6379'),
};

// Export types
export type DatabaseConfig = typeof databaseConfig;
export type RedisConfig = typeof redisConfig;
```

### Constants and Enums
```typescript
// constants/http.ts
export const HttpStatusCodes = {
  OK: 200,
  CREATED: 201,
  BAD_REQUEST: 400,
  UNAUTHORIZED: 401,
  NOT_FOUND: 404,
  INTERNAL_SERVER_ERROR: 500,
} as const;

export const HttpMethods = {
  GET: 'GET',
  POST: 'POST',
  PUT: 'PUT',
  DELETE: 'DELETE',
  PATCH: 'PATCH',
} as const;

// Export types
export type HttpStatusCode = (typeof HttpStatusCodes)[keyof typeof HttpStatusCodes];
export type HttpMethod = (typeof HttpMethods)[keyof typeof HttpMethods];
```

### Hooks (React)
```typescript
// hooks/useLocalStorage.ts
export function useLocalStorage<T>(key: string, initialValue: T) {
  // Implementation
  return [value, setValue] as const;
}

export function useDebounce<T>(value: T, delay: number): T {
  // Implementation
  return debouncedValue;
}

export function useFetch<T>(url: string) {
  // Implementation
  return { data, loading, error };
}

// Export types
export type UseLocalStorageReturn<T> = readonly [T, (value: T) => void];
export type UseFetchReturn<T> = {
  data: T | null;
  loading: boolean;
  error: Error | null;
};
```

### Package Manager Installation
When installing libraries, use scripts to install the latest version:

```bash
# pnpm (preferred)
pnpm add -D @typescript-eslint/eslint-plugin
pnpm add react-query

# yarn
yarn add -D @typescript-eslint/eslint-plugin
yarn add react-query

# npm
npm install --save-dev @typescript-eslint/eslint-plugin
npm install react-query
```

### Index Files for Re-exports
```typescript
// components/index.ts
export { Button, PrimaryButton, SecondaryButton } from './Button';
export { Input, TextArea, Select } from './Form';
export { Modal, Dialog } from './Modal';

// Export types
export type { ButtonProps } from './Button';
export type { InputProps, TextAreaProps, SelectProps } from './Form';
export type { ModalProps, DialogProps } from './Modal';
```

### Barrel Exports Pattern
```typescript
// features/auth/index.ts
export { AuthProvider, useAuth } from './AuthContext';
export { LoginForm, SignupForm } from './components';
export { authApi } from './api';
export { authReducer } from './store';

// Export types
export type { AuthState, AuthUser } from './types';
```

## Exceptions for Default Exports
Some frameworks require default exports:

```typescript
// Next.js pages require default exports
// pages/index.tsx
function HomePage() {
  return <div>Home Page</div>;
}

export default HomePage; // Required by Next.js

// But still prefer named exports when possible
export { HomePage }; // Also export as named for testing
```

## Benefits
- **Better refactoring support** - IDEs can rename across files
- **Clearer imports** - You can see exactly what's being imported
- **Tree shaking** - Bundlers can eliminate unused exports more effectively
- **Consistent naming** - Prevents different names for the same import
- **Better IDE autocomplete** - More discoverable exports
- **Easier testing** - Named exports are easier to mock and test

## Best Practices
1. **Always use named exports unless framework requires default**
2. **Use `import type` for type-only imports**
3. **Group related exports in the same file**
4. **Use index files for barrel exports when appropriate**
5. **Keep import and export statements at the top of files**
6. **Use consistent naming across imports and exports**

## 21-naming-conventions

# Naming Conventions

## Rule
**Use consistent naming conventions: kebab-case for files, camelCase for variables/functions, PascalCase for types/classes, and prefix generics with 'T'.**

## Problem
Inconsistent naming makes code harder to read, understand, and maintain across team members.

## Solution
```typescript
// Files: kebab-case
// my-component.ts, user-service.ts, api-client.ts

// Variables and functions: camelCase
const userName = "john";
function getUserData() { }

// Types and classes: PascalCase
type UserProfile = { };
class AuthService { }

// Generics: prefix with T
type RecordOfArrays<TItem> = Record<string, TItem[]>;
```

## Use Cases
- File naming
- Variable and function naming
- Type and interface definitions
- Class declarations
- Generic type parameters

## Why This Matters
Consistent naming conventions improve code readability, reduce cognitive load, and make the codebase more professional and maintainable.

## Examples and Use Cases

### File and Variable Naming

**Files: kebab-case**
```typescript
// ✅ GOOD - File names
my-component.ts
user-profile-service.ts
api-client.config.ts
auth-helper-utils.ts
shopping-cart-item.tsx
```

**Variables and Functions: camelCase**
```typescript
// ✅ GOOD - Variables
const userName = "john";
const isAuthenticated = true;
const totalOrderAmount = 99.99;
const currentUserProfile = {};

// ✅ GOOD - Functions
function getUserData() {
  return userData;
}

function calculateTotalPrice(items: CartItem[]) {
  return items.reduce((sum, item) => sum + item.price, 0);
}

async function fetchUserProfile(userId: string) {
  return await api.get(`/users/${userId}`);
}
```

**Types and Classes: PascalCase (UpperCamelCase)**
```typescript
// ✅ GOOD - Types and Interfaces
type UserProfile = {
  id: string;
  name: string;
  email: string;
};

interface AuthenticationState {
  isLoggedIn: boolean;
  user: UserProfile | null;
}

// ✅ GOOD - Classes
class AuthenticationService {
  private apiClient: ApiClient;
  
  constructor(apiClient: ApiClient) {
    this.apiClient = apiClient;
  }
}

class ShoppingCartManager {
  private items: CartItem[] = [];
}
```

**Constants: ALL_CAPS**
```typescript
// ✅ GOOD - Constants
const MAX_RETRY_ATTEMPTS = 3;
const DEFAULT_TIMEOUT = 5000;
const API_BASE_URL = "https://api.example.com";

// ✅ GOOD - Enum-like objects
const HttpStatusCode = {
  OK: 200,
  BAD_REQUEST: 400,
  UNAUTHORIZED: 401,
  NOT_FOUND: 404,
} as const;
```

### Generic Type Parameters
Inside generic types, functions or classes, prefix type parameters with `T`:

```typescript
// ✅ GOOD - Generic types
type RecordOfArrays<TItem> = Record<string, TItem[]>;

type ApiResponse<TData> = {
  data: TData;
  status: number;
  message: string;
};

type FetchState<TData, TError = Error> = 
  | { status: "loading" }
  | { status: "success"; data: TData }
  | { status: "error"; error: TError };

// ✅ GOOD - Generic functions
function createRepository<TEntity>(
  entityName: string
): Repository<TEntity> {
  return new Repository(entityName);
}

function mapArray<TInput, TOutput>(
  items: TInput[],
  mapper: (item: TInput) => TOutput
): TOutput[] {
  return items.map(mapper);
}

// ✅ GOOD - Generic classes
class GenericService<TModel, TCreateData = Partial<TModel>> {
  async create(data: TCreateData): Promise<TModel> {
    // Implementation
  }
  
  async update<TUpdateData = Partial<TModel>>(
    id: string, 
    data: TUpdateData
  ): Promise<TModel> {
    // Implementation
  }
}
```

### Component Naming (React)
```typescript
// ✅ GOOD - Component files and names
// File: user-profile-card.tsx
export function UserProfileCard({ user }: UserProfileCardProps) {
  return (
    <div className="user-profile-card">
      <h3>{user.name}</h3>
      <p>{user.email}</p>
    </div>
  );
}

// File: shopping-cart-item.tsx
export function ShoppingCartItem({ item, onRemove }: ShoppingCartItemProps) {
  return (
    <div className="shopping-cart-item">
      <span>{item.name}</span>
      <button onClick={() => onRemove(item.id)}>Remove</button>
    </div>
  );
}
```

### Hook Naming (React)
```typescript
// ✅ GOOD - Hook files and names
// File: use-local-storage.ts
export function useLocalStorage<TValue>(key: string, initialValue: TValue) {
  // Implementation
}

// File: use-api-data.ts
export function useApiData<TData>(url: string) {
  // Implementation
}

// File: use-shopping-cart.ts
export function useShoppingCart() {
  // Implementation
}
```

### Service and Utility Naming
```typescript
// ✅ GOOD - Service files and classes
// File: authentication-service.ts
export class AuthenticationService {
  async login(credentials: LoginCredentials): Promise<AuthResult> {
    // Implementation
  }
}

// File: user-api-client.ts
export class UserApiClient {
  async getUser(id: string): Promise<User> {
    // Implementation
  }
}

// ✅ GOOD - Utility files and functions
// File: string-utils.ts
export function capitalizeString(str: string): string {
  return str.charAt(0).toUpperCase() + str.slice(1);
}

export function formatUserName(firstName: string, lastName: string): string {
  return `${firstName} ${lastName}`;
}

// File: date-helpers.ts
export function formatDateForDisplay(date: Date): string {
  return date.toLocaleDateString();
}
```

### Database and API Naming
```typescript
// ✅ GOOD - Database models
// File: user-model.ts
export type UserModel = {
  id: string;
  email: string;
  createdAt: Date;
  updatedAt: Date;
};

// ✅ GOOD - API types
// File: api-types.ts
export type CreateUserRequest = {
  email: string;
  password: string;
};

export type UpdateUserRequest = {
  email?: string;
  name?: string;
};

export type UserApiResponse = {
  user: UserModel;
  token: string;
};
```

### Configuration and Constants
```typescript
// ✅ GOOD - Configuration files
// File: app-config.ts
export const appConfig = {
  apiBaseUrl: process.env.API_BASE_URL || "http://localhost:3000",
  maxFileSize: 5 * 1024 * 1024, // 5MB
  supportEmail: "support@example.com",
};

// File: theme-constants.ts
export const THEME_COLORS = {
  PRIMARY: "#007bff",
  SECONDARY: "#6c757d",
  SUCCESS: "#28a745",
  DANGER: "#dc3545",
} as const;

export const BREAKPOINTS = {
  MOBILE: "480px",
  TABLET: "768px",
  DESKTOP: "1024px",
} as const;
```

### Test File Naming
```typescript
// ✅ GOOD - Test files
// user-service.test.ts
// authentication-helper.spec.ts  
// shopping-cart-component.test.tsx
```

## Common Mistakes to Avoid

```typescript
// ❌ BAD - Inconsistent naming
const user_name = "john";        // snake_case for variables
function GetUserData() { }       // PascalCase for functions
type userProfile = { };          // camelCase for types
const max_count = 100;          // snake_case for constants

// ❌ BAD - Unclear generic names
type GenericType<T, U, V> = { }; // Non-descriptive single letters
type ApiResponse<Data> = { };    // Missing T prefix

// ❌ BAD - Inconsistent file names
MyComponent.tsx                  // PascalCase for files
user_service.ts                  // snake_case for files
apiClient.ts                     // camelCase for files
```

## Benefits
- **Consistent codebase** - All team members follow the same conventions
- **Better readability** - Clear patterns make code easier to scan
- **Improved tooling** - IDEs can provide better autocomplete and navigation
- **Professional appearance** - Consistent naming looks more polished
- **Easier onboarding** - New team members can quickly understand patterns
- **Reduced cognitive load** - No mental overhead deciding how to name things

## Best Practices
1. **Be consistent across the entire codebase**
2. **Use descriptive names that explain purpose**
3. **Follow language and framework conventions**
4. **Use prefixes/suffixes consistently (like 'T' for generics)**
5. **Avoid abbreviations unless they're widely understood**
6. **Use positive boolean names (isVisible vs isHidden)**
7. **Include units in numeric variable names when relevant (timeoutMs)**

## 22-error-handling

# Error Handling

## Rule
**Think carefully before implementing code that throws errors. For code that requires manual try-catch, consider using a result type.**

## Problem
Thrown errors can crash applications and require manual try-catch blocks that are easy to forget, leading to unhandled exceptions.

## Solution
```typescript
// Use Result type instead of throwing
type Result<T, E extends Error> =
  | { ok: true; value: T }
  | { ok: false; error: E };

const parseJson = (input: string): Result<unknown, Error> => {
  try {
    return { ok: true, value: JSON.parse(input) };
  } catch (error) {
    return { ok: false, error: error as Error };
  }
};
```

## Use Cases
- JSON parsing
- API calls
- File operations
- Data validation
- Type conversions

## Why This Matters
Result types make error handling explicit and force consumers to handle both success and error cases, preventing unhandled exceptions.

## Examples and Use Cases

### Basic Result Type Pattern
```typescript
type Result<T, E extends Error> =
  | { ok: true; value: T }
  | { ok: false; error: E };

// Example implementation
const parseJson = (input: string): Result<unknown, Error> => {
  try {
    return { ok: true, value: JSON.parse(input) };
  } catch (error) {
    return { ok: false, error: error as Error };
  }
};

// Usage
const result = parseJson('{"name": "John"}');

if (result.ok) {
  console.log(result.value); // TypeScript knows this is the parsed value
} else {
  console.error(result.error); // TypeScript knows this is an Error
}
```

### API Request with Result Type
```typescript
type ApiError = Error & { status?: number };

async function fetchUser(id: string): Promise<Result<User, ApiError>> {
  try {
    const response = await fetch(`/api/users/${id}`);
    
    if (!response.ok) {
      const error = new Error(`Failed to fetch user: ${response.statusText}`) as ApiError;
      error.status = response.status;
      return { ok: false, error };
    }
    
    const user = await response.json();
    return { ok: true, value: user };
  } catch (error) {
    return { ok: false, error: error as ApiError };
  }
}

// Usage
const userResult = await fetchUser("123");

if (userResult.ok) {
  // Handle success
  console.log(`User: ${userResult.value.name}`);
} else {
  // Handle error
  if (userResult.error.status === 404) {
    console.log("User not found");
  } else {
    console.error("Failed to fetch user:", userResult.error.message);
  }
}
```

### File Operations
```typescript
import { readFile } from 'fs/promises';

async function readConfigFile(path: string): Promise<Result<Config, Error>> {
  try {
    const content = await readFile(path, 'utf-8');
    const config = JSON.parse(content);
    return { ok: true, value: config };
  } catch (error) {
    return { ok: false, error: error as Error };
  }
}

// Usage
const configResult = await readConfigFile('./config.json');

if (configResult.ok) {
  console.log("Config loaded:", configResult.value);
} else {
  console.error("Failed to load config:", configResult.error.message);
  // Use default config or exit gracefully
}
```

### Data Validation
```typescript
type ValidationError = Error & { field?: string };

function validateEmail(email: string): Result<string, ValidationError> {
  if (!email) {
    const error = new Error("Email is required") as ValidationError;
    error.field = "email";
    return { ok: false, error };
  }
  
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email)) {
    const error = new Error("Invalid email format") as ValidationError;
    error.field = "email";
    return { ok: false, error };
  }
  
  return { ok: true, value: email };
}

function validateUserData(data: unknown): Result<User, ValidationError> {
  // Type guard
  if (!data || typeof data !== 'object') {
    return { ok: false, error: new Error("Invalid user data") as ValidationError };
  }
  
  const obj = data as Record<string, unknown>;
  
  // Validate email
  if (typeof obj.email !== 'string') {
    const error = new Error("Email must be a string") as ValidationError;
    error.field = "email";
    return { ok: false, error };
  }
  
  const emailResult = validateEmail(obj.email);
  if (!emailResult.ok) {
    return emailResult;
  }
  
  // Validate name
  if (typeof obj.name !== 'string' || obj.name.length < 2) {
    const error = new Error("Name must be at least 2 characters") as ValidationError;
    error.field = "name";
    return { ok: false, error };
  }
  
  return {
    ok: true,
    value: {
      email: emailResult.value,
      name: obj.name,
    } as User
  };
}
```

### Database Operations
```typescript
type DatabaseError = Error & { code?: string };

async function createUser(userData: CreateUserData): Promise<Result<User, DatabaseError>> {
  try {
    const user = await db.user.create({
      data: userData
    });
    return { ok: true, value: user };
  } catch (error) {
    const dbError = error as any;
    
    // Handle specific database errors
    if (dbError.code === 'P2002') {
      const duplicateError = new Error("User already exists") as DatabaseError;
      duplicateError.code = 'DUPLICATE_USER';
      return { ok: false, error: duplicateError };
    }
    
    return { ok: false, error: error as DatabaseError };
  }
}

// Usage
const createResult = await createUser(newUserData);

if (createResult.ok) {
  console.log("User created:", createResult.value.id);
} else {
  if (createResult.error.code === 'DUPLICATE_USER') {
    console.log("User already exists");
  } else {
    console.error("Failed to create user:", createResult.error.message);
  }
}
```

### Type Conversion
```typescript
function parseNumber(value: string): Result<number, Error> {
  const parsed = Number(value);
  
  if (isNaN(parsed)) {
    return { ok: false, error: new Error(`Cannot parse "${value}" as number`) };
  }
  
  return { ok: true, value: parsed };
}

function parseInteger(value: string): Result<number, Error> {
  const numberResult = parseNumber(value);
  
  if (!numberResult.ok) {
    return numberResult;
  }
  
  if (!Number.isInteger(numberResult.value)) {
    return { ok: false, error: new Error(`"${value}" is not an integer`) };
  }
  
  return { ok: true, value: numberResult.value };
}

// Usage
const ageResult = parseInteger("25");
if (ageResult.ok) {
  console.log("Age:", ageResult.value);
} else {
  console.error("Invalid age:", ageResult.error.message);
}
```

### Chaining Results
```typescript
// Helper function for chaining operations
function chain<T, U, E extends Error>(
  result: Result<T, E>,
  fn: (value: T) => Result<U, E>
): Result<U, E> {
  if (result.ok) {
    return fn(result.value);
  }
  return result;
}

// Example usage
function processUserData(input: string): Result<User, Error> {
  return chain(
    parseJson(input),
    (parsed) => validateUserData(parsed)
  );
}

// Or with async operations
async function createUserFromJson(input: string): Promise<Result<User, Error>> {
  const parseResult = parseJson(input);
  if (!parseResult.ok) {
    return parseResult;
  }
  
  const validateResult = validateUserData(parseResult.value);
  if (!validateResult.ok) {
    return validateResult;
  }
  
  return await createUser(validateResult.value);
}
```

### Result Utilities
```typescript
// Utility functions for working with Results
export const ResultUtils = {
  // Convert array of results to result of array
  all<T, E extends Error>(results: Result<T, E>[]): Result<T[], E> {
    const values: T[] = [];
    
    for (const result of results) {
      if (!result.ok) {
        return result;
      }
      values.push(result.value);
    }
    
    return { ok: true, value: values };
  },
  
  // Map over successful result
  map<T, U, E extends Error>(
    result: Result<T, E>,
    fn: (value: T) => U
  ): Result<U, E> {
    if (result.ok) {
      return { ok: true, value: fn(result.value) };
    }
    return result;
  },
  
  // Provide default value for failed result
  withDefault<T, E extends Error>(result: Result<T, E>, defaultValue: T): T {
    return result.ok ? result.value : defaultValue;
  }
};
```

## When to Still Use Exceptions
Some cases where throwing errors is still appropriate:

```typescript
// Programming errors (bugs) - should crash the program
function divide(a: number, b: number): number {
  if (b === 0) {
    throw new Error("Division by zero"); // This is a programming error
  }
  return a / b;
}

// Framework requirements
class CustomError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "CustomError";
  }
}

// When integrating with existing throwing APIs
async function wrappedFetch(url: string): Promise<Result<Response, Error>> {
  try {
    const response = await fetch(url); // fetch can throw
    return { ok: true, value: response };
  } catch (error) {
    return { ok: false, error: error as Error };
  }
}
```

## Benefits
- **Explicit error handling** - Forces consumers to handle both cases
- **Type safety** - TypeScript prevents accessing value when there's an error
- **No unhandled exceptions** - All errors are explicitly handled
- **Composable** - Results can be easily chained and combined
- **Better testing** - Easier to test both success and error paths
- **Self-documenting** - Function signatures show what errors are possible

## Best Practices
1. **Use Result types for recoverable errors**
2. **Still throw for programming errors (bugs)**
3. **Make error types specific and informative**
4. **Provide utility functions for common Result operations**
5. **Document when functions might return errors**
6. **Use discriminated unions for different error types**

## 23-generics-any

# Generics and Any Usage

## Rule
**When building generic functions, you may need to use `any` inside the function body for type assertions. Outside of generic functions, use `any` extremely sparingly.**

## Problem
TypeScript often cannot match runtime logic to the logic done inside complex generic types, requiring type assertions to make the code compile.

## Solution
```typescript
const youSayGoodbyeISayHello = <
  TInput extends "hello" | "goodbye",
>(
  input: TInput,
): TInput extends "hello" ? "goodbye" : "hello" => {
  if (input === "goodbye") {
    return "hello" as any;
  } else {
    return "goodbye" as any;
  }
};
```

## Use Cases
- Complex generic functions with conditional return types
- Type transformations
- Advanced utility types
- Framework/library development
- Runtime type checking with generics

## Why This Matters
Strategic use of `any` in generics enables powerful type-safe APIs while avoiding the complexity of satisfying TypeScript's type checker in runtime logic.

## Examples and Use Cases

### Conditional Return Types
When the return type depends on the input type in ways TypeScript can't infer:

```typescript
// Complex conditional type that needs runtime assertion
function processValue<T extends string | number>(
  value: T
): T extends string ? string[] : number[] => {
  if (typeof value === "string") {
    return value.split("") as any; // TypeScript can't prove this matches the conditional type
  } else {
    return [value, value * 2] as any; // Same here
  }
}

// Usage is type-safe
const stringResult = processValue("hello"); // Type: string[]
const numberResult = processValue(42);      // Type: number[]
```

### Object Key Transformation
```typescript
type Capitalize<S extends string> = S extends `${infer First}${infer Rest}`
  ? `${Uppercase<First>}${Rest}`
  : S;

type CapitalizeKeys<T> = {
  [K in keyof T as Capitalize<K & string>]: T[K];
};

function capitalizeKeys<T extends Record<string, any>>(
  obj: T
): CapitalizeKeys<T> => {
  const result = {} as any;
  
  for (const key in obj) {
    const capitalizedKey = key.charAt(0).toUpperCase() + key.slice(1);
    result[capitalizedKey] = obj[key];
  }
  
  return result as any; // TypeScript can't verify the transformation matches the type
}

// Usage
const input = { name: "John", age: 30 };
const output = capitalizeKeys(input); // Type: { Name: string; Age: number; }
```

### Array Transformation Utilities
```typescript
function groupBy<T, K extends keyof T>(
  array: T[],
  key: K
): Record<T[K] extends string | number | symbol ? T[K] : never, T[]> => {
  const result = {} as any;
  
  for (const item of array) {
    const groupKey = item[key];
    if (!result[groupKey]) {
      result[groupKey] = [];
    }
    result[groupKey].push(item);
  }
  
  return result as any; // Complex type relationship needs assertion
}

// Usage
const users = [
  { id: 1, department: "engineering" },
  { id: 2, department: "marketing" },
  { id: 3, department: "engineering" },
];

const grouped = groupBy(users, "department");
// Type: Record<"engineering" | "marketing", typeof users>
```

### Deep Object Updates
```typescript
type DeepPartial<T> = {
  [P in keyof T]?: T[P] extends object ? DeepPartial<T[P]> : T[P];
};

function deepMerge<T extends Record<string, any>>(
  original: T,
  updates: DeepPartial<T>
): T => {
  const result = { ...original } as any;
  
  for (const key in updates) {
    const updateValue = updates[key];
    
    if (updateValue && typeof updateValue === 'object' && !Array.isArray(updateValue)) {
      result[key] = deepMerge(result[key] || {}, updateValue);
    } else {
      result[key] = updateValue;
    }
  }
  
  return result as any; // Complex nested type logic needs assertion
}
```

### Type Guards with Generics
```typescript
function isOfType<T>(value: unknown, validator: (v: any) => v is T): value is T {
  return validator(value);
}

function assertType<T>(
  value: unknown,
  validator: (v: any) => v is T,
  errorMessage?: string
): T => {
  if (isOfType(value, validator)) {
    return value; // TypeScript knows this is T
  }
  throw new Error(errorMessage || "Type assertion failed");
}

// Custom validator functions
const isString = (value: any): value is string => typeof value === "string";
const isNumber = (value: any): value is number => typeof value === "number";

// Usage
const userInput: unknown = "hello";
const str = assertType(userInput, isString, "Expected string");
// str is now typed as string
```

### Generic Factory Functions
```typescript
interface EntityConfig<T> {
  name: string;
  validator: (data: any) => data is T;
  transform?: (data: T) => T;
}

function createEntityManager<T>(config: EntityConfig<T>) {
  return {
    create(data: unknown): T {
      if (!config.validator(data)) {
        throw new Error(`Invalid ${config.name} data`);
      }
      
      return config.transform ? config.transform(data) : (data as any);
      // Need 'as any' because TypeScript can't verify the validator guarantees T
    },
    
    validate(data: unknown): data is T {
      return config.validator(data);
    }
  };
}

// Usage
const userManager = createEntityManager({
  name: "User",
  validator: (data: any): data is User => 
    typeof data === "object" && 
    typeof data.id === "string" && 
    typeof data.email === "string",
  transform: (user: User) => ({ ...user, createdAt: new Date() })
});
```

### Utility Type Implementations
```typescript
// Pick implementation
function pick<T, K extends keyof T>(obj: T, keys: K[]): Pick<T, K> {
  const result = {} as any;
  
  for (const key of keys) {
    result[key] = obj[key];
  }
  
  return result as any; // TypeScript needs help with the Pick<T, K> type
}

// Omit implementation
function omit<T, K extends keyof T>(obj: T, keys: K[]): Omit<T, K> {
  const result = { ...obj } as any;
  
  for (const key of keys) {
    delete result[key];
  }
  
  return result as any; // TypeScript needs help with the Omit<T, K> type
}

// Usage
const user = { id: "1", name: "John", email: "john@example.com", password: "secret" };
const publicUser = omit(user, ["password"]); // Type: { id: string; name: string; email: string; }
const userSummary = pick(user, ["id", "name"]); // Type: { id: string; name: string; }
```

### When NOT to Use Any
```typescript
// ❌ BAD - Avoid any outside of generics
function processData(data: any): any {
  return data.someProperty; // No type safety
}

// ✅ GOOD - Use proper types
function processData(data: { someProperty: string }): string {
  return data.someProperty;
}

// ❌ BAD - Lazy any usage
const userResponse: any = await fetch("/api/user");

// ✅ GOOD - Proper typing
type UserResponse = {
  user: User;
  token: string;
};
const userResponse: UserResponse = await fetch("/api/user").then(r => r.json());
```

### Safe Any Alternatives
```typescript
// Use unknown instead of any when possible
function processUnknownData(data: unknown) {
  // Must check type before using
  if (typeof data === "string") {
    return data.toUpperCase(); // TypeScript knows data is string here
  }
  
  if (data && typeof data === "object" && "name" in data) {
    // Type guard for object properties
    return (data as { name: string }).name;
  }
  
  return "Unknown";
}

// Use specific union types
type ApiResponse = SuccessResponse | ErrorResponse;
// Instead of: type ApiResponse = any;

// Use generics with constraints
function processArray<T extends { id: string }>(items: T[]): T[] {
  return items.filter(item => item.id !== "");
}
// Instead of: function processArray(items: any[]): any[]
```

### Testing Generic Functions
```typescript
// Test that the types work correctly
const result1 = youSayGoodbyeISayHello("hello");   // Should be "goodbye"
const result2 = youSayGoodbyeISayHello("goodbye"); // Should be "hello"

// Type tests (these should compile without errors)
const _typeTest1: "goodbye" = result1;
const _typeTest2: "hello" = result2;
```

## When Any is Acceptable
1. **Inside generic function bodies** - When TypeScript can't prove type safety but you know it's correct
2. **Migrating JavaScript code** - Temporary any during gradual TypeScript adoption
3. **Interfacing with dynamic APIs** - When working with truly dynamic content
4. **Library boundaries** - Internal implementation details in library code
5. **Type assertion helpers** - Functions specifically designed for type conversion

## Best Practices
1. **Limit any to generic function implementations**
2. **Use type assertions (`as any`) sparingly and document why**
3. **Prefer `unknown` over `any` when accepting arbitrary input**
4. **Use specific union types instead of any when possible**
5. **Consider type guards before resorting to any**
6. **Document any usage with comments explaining the necessity**
7. **Regularly audit and try to remove any usage**

## Benefits of Strategic Any Usage
- **Enables powerful generic APIs** - Complex type transformations become possible
- **Maintains type safety at boundaries** - Function signatures remain type-safe
- **Reduces implementation complexity** - Avoids overly complex type gymnastics
- **Improves developer experience** - Allows creation of intuitive APIs
- **Enables gradual typing** - Smooth migration from JavaScript

## 24-function-declarations

# Function Declaration Rules

## Rule
**When declaring functions on the top-level of a module, declare their return types. Exception: No need to declare return types for React components.**

## Problem
Missing return types make code harder to understand and can hide type errors in function implementations.

## Solution
```typescript
// Declare return type for regular functions
const myFunc = (): string => {
  return "hello";
};

// Exception: React components don't need return type
const MyComponent = () => {
  return <div>Hello</div>;
};
```

## Use Cases
- Module-level utility functions
- API functions
- Service methods
- Helper functions
- Business logic functions

## Why This Matters
Explicit return types improve code documentation, catch implementation errors early, and provide better IDE support.

## Examples and Use Cases

### Regular Function Declarations
Always declare return types for top-level module functions:

```typescript
// ✅ GOOD - Explicit return types
const calculateTotal = (items: CartItem[]): number => {
  return items.reduce((sum, item) => sum + item.price, 0);
};

const formatUserName = (user: User): string => {
  return `${user.firstName} ${user.lastName}`;
};

const isValidEmail = (email: string): boolean => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

// ❌ BAD - Missing return types  
const calculateTotal = (items: CartItem[]) => {
  return items.reduce((sum, item) => sum + item.price, 0); // Could return wrong type
};

const formatUserName = (user: User) => {
  return `${user.firstName} ${user.lastName}`; // Type not explicit
};
```

### Async Function Declarations
```typescript
// ✅ GOOD - Explicit Promise return types
const fetchUser = async (id: string): Promise<User> => {
  const response = await fetch(`/api/users/${id}`);
  return response.json();
};

const saveUserData = async (user: User): Promise<void> => {
  await fetch('/api/users', {
    method: 'POST',
    body: JSON.stringify(user),
  });
};

const getUserList = async (): Promise<User[]> => {
  const response = await fetch('/api/users');
  return response.json();
};
```

### Complex Return Types
```typescript
// ✅ GOOD - Complex return types are explicit
const createApiClient = (baseUrl: string): ApiClient => {
  return {
    get: async <T>(endpoint: string): Promise<T> => {
      const response = await fetch(`${baseUrl}${endpoint}`);
      return response.json();
    },
    post: async <T>(endpoint: string, data: unknown): Promise<T> => {
      const response = await fetch(`${baseUrl}${endpoint}`, {
        method: 'POST',
        body: JSON.stringify(data),
      });
      return response.json();
    },
  };
};

const processUserData = (users: User[]): ProcessedUserData => {
  return {
    totalUsers: users.length,
    activeUsers: users.filter(u => u.isActive),
    usersByDepartment: groupByDepartment(users),
    averageAge: calculateAverageAge(users),
  };
};
```

### Higher-Order Functions
```typescript
// ✅ GOOD - HOF with explicit return types
const createValidator = <T>(
  validationRules: ValidationRule<T>[]
): ((data: T) => ValidationResult) => {
  return (data: T): ValidationResult => {
    const errors: string[] = [];
    
    for (const rule of validationRules) {
      if (!rule.validator(data)) {
        errors.push(rule.message);
      }
    }
    
    return {
      isValid: errors.length === 0,
      errors,
    };
  };
};

const memoize = <TArgs extends unknown[], TReturn>(
  fn: (...args: TArgs) => TReturn
): ((...args: TArgs) => TReturn) => {
  const cache = new Map<string, TReturn>();
  
  return (...args: TArgs): TReturn => {
    const key = JSON.stringify(args);
    
    if (cache.has(key)) {
      return cache.get(key)!;
    }
    
    const result = fn(...args);
    cache.set(key, result);
    return result;
  };
};
```

### React Components Exception
React components don't need explicit return types as they always return JSX:

```typescript
// ✅ GOOD - No return type needed for components
const UserProfile = ({ user }: { user: User }) => {
  return (
    <div className="user-profile">
      <h1>{user.name}</h1>
      <p>{user.email}</p>
    </div>
  );
};

const LoadingSpinner = () => {
  return <div className="spinner">Loading...</div>;
};

const ErrorBoundary = ({ children }: { children: React.ReactNode }) => {
  return (
    <div className="error-boundary">
      {children}
    </div>
  );
};

// Custom hooks DO need return types
const useUserData = (userId: string): {
  user: User | null;
  loading: boolean;
  error: Error | null;
} => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);
  
  // Implementation...
  
  return { user, loading, error };
};
```

### Service and Repository Functions
```typescript
// ✅ GOOD - Service methods with explicit return types
class UserService {
  createUser = async (userData: CreateUserData): Promise<User> => {
    const validation = validateUserData(userData);
    if (!validation.isValid) {
      throw new Error(validation.errors.join(', '));
    }
    
    return await this.userRepository.create(userData);
  };
  
  getUserById = async (id: string): Promise<User | null> => {
    return await this.userRepository.findById(id);
  };
  
  updateUser = async (id: string, updates: Partial<User>): Promise<User> => {
    const existingUser = await this.getUserById(id);
    if (!existingUser) {
      throw new Error('User not found');
    }
    
    return await this.userRepository.update(id, updates);
  };
}

// ✅ GOOD - Repository methods
const createUserRepository = (db: Database): UserRepository => {
  return {
    findById: async (id: string): Promise<User | null> => {
      return db.user.findUnique({ where: { id } });
    },
    
    create: async (userData: CreateUserData): Promise<User> => {
      return db.user.create({ data: userData });
    },
    
    findMany: async (filters: UserFilters): Promise<User[]> => {
      return db.user.findMany({ where: filters });
    },
  };
};
```

### Utility and Helper Functions
```typescript
// ✅ GOOD - Utility functions with explicit return types
const debounce = <T extends (...args: any[]) => any>(
  func: T,
  delay: number
): T => {
  let timeoutId: NodeJS.Timeout;
  
  return ((...args: Parameters<T>) => {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => func(...args), delay);
  }) as T;
};

const throttle = <T extends (...args: any[]) => any>(
  func: T,
  limit: number
): T => {
  let inThrottle: boolean;
  
  return ((...args: Parameters<T>) => {
    if (!inThrottle) {
      func(...args);
      inThrottle = true;
      setTimeout(() => inThrottle = false, limit);
    }
  }) as T;
};

const formatCurrency = (
  amount: number,
  currency: string = 'USD'
): string => {
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency,
  }).format(amount);
};
```

### Configuration and Factory Functions
```typescript
// ✅ GOOD - Configuration builders
const createDatabaseConfig = (env: string): DatabaseConfig => {
  const baseConfig = {
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '5432'),
    database: process.env.DB_NAME || 'myapp',
  };
  
  if (env === 'production') {
    return {
      ...baseConfig,
      ssl: true,
      connectionLimit: 20,
    };
  }
  
  return {
    ...baseConfig,
    ssl: false,
    connectionLimit: 5,
  };
};

const createLogger = (level: LogLevel): Logger => {
  return {
    debug: (message: string, meta?: object): void => {
      if (level >= LogLevel.DEBUG) {
        console.debug(message, meta);
      }
    },
    info: (message: string, meta?: object): void => {
      if (level >= LogLevel.INFO) {
        console.info(message, meta);
      }
    },
    error: (message: string, error?: Error): void => {
      console.error(message, error);
    },
  };
};
```

### When Return Types Help Catch Errors
```typescript
// Return type catches implementation errors
const calculateDiscount = (price: number, percentage: number): number => {
  // This would be caught by TypeScript if we return string accidentally
  return price * (percentage / 100); // Correct: returns number
  // return `${price * (percentage / 100)}`; // Error: Type 'string' is not assignable to type 'number'
};

const getUser = async (id: string): Promise<User> => {
  const response = await fetch(`/api/users/${id}`);
  // Return type ensures we return User, not Response
  return response.json(); // Must return User
  // return response; // Error: Type 'Response' is not assignable to type 'User'
};
```

## Benefits
- **Better documentation** - Return types serve as inline documentation
- **Error prevention** - Catches implementation errors early
- **IDE support** - Better autocomplete and IntelliSense
- **Refactoring safety** - Changes to return types are caught everywhere they're used
- **API clarity** - Clear contracts for function consumers
- **Type inference** - Helps TypeScript infer types in calling code

## Best Practices
1. **Always declare return types for top-level module functions**
2. **Skip return types only for React components**
3. **Use specific types rather than generic ones (string vs any)**
4. **Include Promise wrapper for async functions**
5. **Use union types when functions can return multiple types**
6. **Consider using Result types for functions that can fail**
7. **Keep return types as narrow/specific as possible**

## 25-jsdoc-comments

# JSDoc Comments

## Rule
**Use JSDoc comments to annotate functions and types. Be concise and only provide JSDoc comments if the function's behavior is not self-evident.**

## Problem
Over-commenting obvious code creates noise, while under-commenting complex logic leaves developers confused about behavior and edge cases.

## Solution
```typescript
/**
 * Subtracts two numbers
 */
const subtract = (a: number, b: number) => a - b;

/**
 * Does the opposite to {@link subtract}
 */
const add = (a: number, b: number) => a + b;
```

## Use Cases
- Complex algorithms
- Functions with side effects
- Non-obvious business logic
- Public API functions
- Functions with special behavior or edge cases

## Why This Matters
Good JSDoc provides context that code alone cannot convey, improves IDE experience, and helps with API documentation generation.

## Examples and Use Cases

### Basic JSDoc Structure
```typescript
/**
 * Calculates the compound interest for an investment
 * @param principal - The initial amount invested
 * @param rate - Annual interest rate (as decimal, e.g., 0.05 for 5%)
 * @param time - Time period in years
 * @param compoundingFrequency - Number of times interest is compounded per year
 * @returns The final amount after compound interest
 */
const calculateCompoundInterest = (
  principal: number,
  rate: number,
  time: number,
  compoundingFrequency: number = 1
): number => {
  return principal * Math.pow(1 + rate / compoundingFrequency, compoundingFrequency * time);
};
```

### Self-Evident Functions (No JSDoc Needed)
```typescript
// ❌ BAD - Over-commenting obvious functions
/**
 * Gets the user name
 * @param user - The user object
 * @returns The user's name
 */
const getUserName = (user: User): string => user.name;

/**
 * Checks if user is active
 * @param user - The user to check
 * @returns True if user is active
 */
const isUserActive = (user: User): boolean => user.isActive;

// ✅ GOOD - No comments needed for obvious functions
const getUserName = (user: User): string => user.name;
const isUserActive = (user: User): boolean => user.isActive;
```

### Functions That Need JSDoc
```typescript
/**
 * Debounces a function call, preventing it from being called more than once
 * within the specified delay period
 * 
 * @param func - The function to debounce
 * @param delay - Delay in milliseconds
 * @returns A debounced version of the function
 */
const debounce = <T extends (...args: any[]) => any>(
  func: T,
  delay: number
): T => {
  let timeoutId: NodeJS.Timeout;
  
  return ((...args: Parameters<T>) => {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => func(...args), delay);
  }) as T;
};

/**
 * Performs a deep merge of two objects, with the second object's properties
 * taking precedence over the first. Arrays are replaced, not merged.
 * 
 * @param target - The target object to merge into
 * @param source - The source object to merge from
 * @returns A new object with merged properties
 */
const deepMerge = <T extends Record<string, any>>(
  target: T,
  source: Partial<T>
): T => {
  // Implementation...
};
```

### Using @link for Internal References
```typescript
/**
 * Validates user input data
 * @param data - Raw user data to validate
 * @returns Validation result with errors if any
 */
const validateUserInput = (data: unknown): ValidationResult => {
  // Implementation...
};

/**
 * Creates a new user account after validation
 * Uses {@link validateUserInput} to ensure data integrity
 * 
 * @param userData - User registration data
 * @throws {ValidationError} When user data is invalid
 * @throws {DuplicateUserError} When user already exists
 * @returns Promise resolving to the created user
 */
const createUserAccount = async (userData: CreateUserData): Promise<User> => {
  const validation = validateUserInput(userData);
  
  if (!validation.isValid) {
    throw new ValidationError(validation.errors.join(', '));
  }
  
  // Check for existing user
  const existingUser = await findUserByEmail(userData.email);
  if (existingUser) {
    throw new DuplicateUserError('User with this email already exists');
  }
  
  return await userRepository.create(userData);
};

/**
 * Alternative to {@link createUserAccount} that returns a Result instead of throwing
 * 
 * @param userData - User registration data
 * @returns Promise resolving to Result with either user or error
 */
const createUserAccountSafe = async (
  userData: CreateUserData
): Promise<Result<User, Error>> => {
  try {
    const user = await createUserAccount(userData);
    return { ok: true, value: user };
  } catch (error) {
    return { ok: false, error: error as Error };
  }
};
```

### Complex Business Logic
```typescript
/**
 * Calculates shipping cost based on complex business rules:
 * - Free shipping for orders over $100
 * - Express shipping adds 50% to base cost
 * - International shipping doubles the cost
 * - Fragile items add $5 flat fee
 * 
 * @param order - The order to calculate shipping for
 * @param shippingMethod - Selected shipping method
 * @returns Object containing cost breakdown and total
 */
const calculateShippingCost = (
  order: Order,
  shippingMethod: ShippingMethod
): ShippingCostBreakdown => {
  const baseCost = getBaseCostByWeight(order.totalWeight);
  let finalCost = baseCost;
  const breakdown: string[] = [];
  
  // Free shipping threshold
  if (order.subtotal >= 100) {
    return {
      total: 0,
      breakdown: ['Free shipping for orders over $100'],
    };
  }
  
  // Express shipping multiplier
  if (shippingMethod === 'express') {
    finalCost *= 1.5;
    breakdown.push('Express shipping (+50%)');
  }
  
  // International shipping
  if (order.isInternational) {
    finalCost *= 2;
    breakdown.push('International shipping (×2)');
  }
  
  // Fragile items fee
  if (order.hasFragileItems) {
    finalCost += 5;
    breakdown.push('Fragile items handling (+$5)');
  }
  
  return {
    total: Math.round(finalCost * 100) / 100,
    breakdown,
  };
};
```

### API Functions with Side Effects
```typescript
/**
 * Sends a password reset email to the user
 * 
 * Side effects:
 * - Creates a password reset token in the database
 * - Sends an email via the email service
 * - Logs the action for security audit
 * 
 * @param email - User's email address
 * @throws {UserNotFoundError} When email doesn't match any user
 * @throws {EmailServiceError} When email sending fails
 * @returns Promise resolving to the reset token (for testing purposes)
 */
const sendPasswordResetEmail = async (email: string): Promise<string> => {
  const user = await findUserByEmail(email);
  if (!user) {
    throw new UserNotFoundError('No user found with this email');
  }
  
  const resetToken = generateSecureToken();
  
  // Store token in database with expiration
  await savePasswordResetToken(user.id, resetToken, new Date(Date.now() + 3600000)); // 1 hour
  
  // Send email
  await emailService.send({
    to: email,
    subject: 'Password Reset Request',
    template: 'password-reset',
    data: { resetToken, userName: user.name },
  });
  
  // Log for security audit
  await auditLogger.log('password_reset_requested', {
    userId: user.id,
    email,
    timestamp: new Date(),
  });
  
  return resetToken;
};
```

### Utility Functions with Edge Cases
```typescript
/**
 * Formats a file size in bytes to human-readable format
 * 
 * Handles edge cases:
 * - Negative numbers return "0 B"
 * - Numbers >= 1024^5 are capped at "999.9 PB"
 * - Decimals are rounded to 1 decimal place
 * 
 * @param bytes - Size in bytes
 * @param binary - Use binary (1024) vs decimal (1000) units
 * @returns Formatted string with appropriate unit
 * 
 * @example
 * ```typescript
 * formatFileSize(1024) // "1.0 KB"
 * formatFileSize(1500, false) // "1.5 kB" (decimal)
 * formatFileSize(-100) // "0 B"
 * ```
 */
const formatFileSize = (bytes: number, binary: boolean = true): string => {
  if (bytes < 0) return "0 B";
  
  const unit = binary ? 1024 : 1000;
  const units = binary 
    ? ['B', 'KB', 'MB', 'GB', 'TB', 'PB']
    : ['B', 'kB', 'MB', 'GB', 'TB', 'PB'];
  
  if (bytes < unit) return `${bytes} B`;
  
  let size = bytes;
  let unitIndex = 0;
  
  while (size >= unit && unitIndex < units.length - 1) {
    size /= unit;
    unitIndex++;
  }
  
  return `${Math.round(size * 10) / 10} ${units[unitIndex]}`;
};
```

### Type Definitions with Context
```typescript
/**
 * Represents the state of a data fetching operation
 * 
 * This discriminated union prevents impossible states like having both
 * data and error present simultaneously.
 * 
 * @template TData - The type of data being fetched
 * @template TError - The type of error that can occur (defaults to Error)
 */
type FetchState<TData, TError = Error> =
  | { status: "idle" }
  | { status: "loading" }
  | { status: "success"; data: TData }
  | { status: "error"; error: TError };

/**
 * Configuration for API retry behavior
 * 
 * The exponential backoff formula is: delay * (backoffMultiplier ^ attemptNumber)
 * 
 * @example
 * ```typescript
 * const config: RetryConfig = {
 *   maxAttempts: 3,
 *   initialDelay: 1000,     // 1 second
 *   backoffMultiplier: 2,   // Double each time
 *   maxDelay: 10000         // Cap at 10 seconds
 * };
 * // Retry delays: 1s, 2s, 4s (but capped at maxDelay if needed)
 * ```
 */
type RetryConfig = {
  /** Maximum number of retry attempts (not including initial attempt) */
  maxAttempts: number;
  /** Initial delay in milliseconds before first retry */
  initialDelay: number;
  /** Multiplier for exponential backoff (e.g., 2 for doubling) */
  backoffMultiplier: number;
  /** Maximum delay between retries in milliseconds */
  maxDelay: number;
};
```

### React Hooks Documentation
```typescript
/**
 * Hook for managing user authentication state
 * 
 * Automatically refreshes the token when it's close to expiring and
 * redirects to login page when authentication fails.
 * 
 * @returns Object containing current auth state and auth actions
 * 
 * @example
 * ```tsx
 * function Dashboard() {
 *   const { user, isLoading, login, logout } = useAuth();
 *   
 *   if (isLoading) return <LoadingSpinner />;
 *   if (!user) return <LoginForm onLogin={login} />;
 *   
 *   return <div>Welcome, {user.name}!</div>;
 * }
 * ```
 */
const useAuth = (): AuthHookReturn => {
  // Implementation...
};

/**
 * Hook for managing form state with validation
 * 
 * Provides debounced validation and optimistic UI updates.
 * Validation runs 300ms after user stops typing.
 * 
 * @param initialValues - Initial form field values
 * @param validationSchema - Schema for validating form fields
 * @returns Form state and helper functions
 */
const useForm = <T extends Record<string, any>>(
  initialValues: T,
  validationSchema: ValidationSchema<T>
): FormHookReturn<T> => {
  // Implementation...
};
```

## When NOT to Use JSDoc
```typescript
// ❌ DON'T document obvious getters/setters
/**
 * Gets the user ID
 */
const getUserId = (user: User): string => user.id;

// ❌ DON'T document simple type conversions  
/**
 * Converts string to number
 */
const stringToNumber = (str: string): number => Number(str);

// ❌ DON'T document obvious React components
/**
 * Renders a button
 */
const Button = ({ children, onClick }: ButtonProps) => (
  <button onClick={onClick}>{children}</button>
);
```

## Benefits
- **Better IDE experience** - Hover tooltips show documentation
- **API documentation** - Tools can generate docs from JSDoc
- **Team communication** - Explains intent and edge cases
- **Self-documenting code** - Reduces need for separate documentation
- **Onboarding** - New developers understand complex functions faster

## Best Practices
1. **Only document non-obvious behavior**
2. **Use `@link` to reference related functions**
3. **Include `@example` for complex functions**
4. **Document side effects clearly**
5. **Mention edge cases and error conditions**
6. **Keep descriptions concise but complete**
7. **Update JSDoc when function behavior changes**
8. **Use `@param` and `@returns` for clarity**

## Cognitive Load

You are an engineer who writes code for **human brains, not machines**. You favour code that is simple to undertand and maintain. Remember at all times that the code you will be processed by human brain. The brain has a very limited capacity. People can only hold ~4 chunks in their working memory at once. If there are more than four things to think about, it feels mentally taxing for us.

Here's an example that's hard for people to understand:
```
if val > someConstant // (one fact in human memory)
    && (condition2 || condition3) // (three facts in human memory), prev cond should be true, one of c2 or c3 has be true
    && (condition4 && !condition5) { // (human memory overload), we are messed up by this point
    ...
}
```

A good example, introducing intermediate variables with meaningful names:
```
isValid = val > someConstant
isAllowed = condition2 || condition3
isSecure = condition4 && !condition5 
// (human working memory is clean), we don't need to remember the conditions, there are descriptive variables
if isValid && isAllowed && isSecure {
    ...
}
```

- Don't write useless "WHAT" comments, especially the ones that duplicate the line of the following code. "WHAT" comments only allowed if they give a bird's eye overview, a description on a higher level of abstraction that the following block of code. Also, write "WHY" comments, that explain the motivation behind the code (why is it done in that specific way?), explain an especially complex or tricky part of the code.
- Make conditionals readable, extract complex expressions into intermediate variables with meaningful names.
- Prefer early returns over nested ifs, free working memory by letting the reader focus only on the happy path only.
- Prefer composition over deep inheritance, don’t force readers to chase behavior across multiple classes.
- Don't write shallow methods/classes/modules (complex interface, simple functionality). An example of shallow class: `MetricsProviderFactoryFactory`. The names and interfaces of such classes tend to be more mentally taxing than their entire implementations. Having too many shallow modules can make it difficult to understand the project. Not only do we have to keep in mind each module responsibilities, but also all their interactions.
- Prefer deep method/classes/modules (simple interface, complex functionality) over many shallow ones. 
- Don’t overuse language featuress, stick to the minimal subset. Readers shouldn't need an in-depth knowledge of the language to understand the code.
- Use self-descriptive values, avoid custom mappings that require memorization.
- Don’t abuse DRY, a little duplication is better than unnecessary dependencies.
- Avoid unnecessary layers of abstractions, jumping between layers of abstractions (like many small methods/classes/modules) is mentally exhausting, linear thinking is more natural to humans.

## General rules

- "Prefer simple solutions",
- "Tell me something I need to know even if I don't want to hear it"
- Don't create methods or functions that take boolean parameters.
- When something is unclear, ask me a question before proceeding

## Markdown Files in Programming projects



## Typescript

- "Use TypeScript strict mode, all functions must have explicit return types"
- Simplify complex return types​ if a function returns more than one type. Handle the error conditions, by reporting the error​s and throwing an exception​. Then narrow the remaining type to a single type. Example:
	export function chatComplete(
    client: MistralCore,
    request: ChatCompletionRequest,
    options?: RequestOptions,
	): APIPromise<Result<ChatCompletionResponse, HTTPValidationError | MistralError | ResponseValidationError | ConnectionError | RequestAbortedError | RequestTimeoutError | InvalidRequestError | UnexpectedClientError | SDKValidationError>>
	
	Handle the error conditions with by reporting the error​s and throwing an exception​. Then narrow the remaining type to ChatCompletionResponse.
