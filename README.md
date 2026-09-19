# E-Commerce App

A Flutter shopping application built around the [Fake Store API](https://fakestoreapi.com/). The app provides product discovery, category filtering, product details, cart interactions, secure session persistence, account navigation, and a responsive mobile-first interface.

> **Project status:** Core browsing and authentication flows are implemented. Cart checkout, account management, search, registration, and several data-driven interactions are currently UI foundations and are listed in the roadmap.


## Contents

- [Features](#features)
- [Application Screens](#application-screens)
- [Screenshots](#screenshots)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [API Integration](#api-integration)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Known Limitations](#known-limitations)
- [Roadmap](#roadmap)
- [Testing](#testing)

## Features

### Authentication

- Login with username and password validation.
- Loading, success, and error feedback through animated snackbars.
- Secure token persistence using `flutter_secure_storage`.
- Automatic startup routing based on the stored authentication token.
- Logout confirmation dialog, token removal, and navigation back to login.
- Registration screen UI with full name, username, password, and confirmation fields.

### Product Discovery

- Product catalog loaded from the Fake Store API.
- Horizontal category selector with an `All` option.
- Category-specific product requests.
- Product cards showing image, title, price, and rating.
- Cached network images for smoother browsing.
- Pull-to-refresh on the product grid.
- Staggered slide and fade animations for product cards.
- Shimmer placeholders while products are loading.
- Navigation from a product card to a detailed product view.

### Product Details

- Hero image transition from the product grid.
- Product image, title, description, price, and rating presentation.
- Add-to-cart action with loading and success/error feedback.
- Product data passed through the application router.

### Cart

- Cart retrieval from the API when the main screen opens.
- Add-to-cart requests for selected products.
- Cart item display with product IDs and quantities returned by the API.
- Loading and error states.
- Checkout call-to-action UI ready for future payment and order integration.

### Account and Addresses

- Account menu with entries for orders, personal details, address book, FAQ, and help center.
- Address book screen with reusable address item components.
- Logout action with confirmation flow.

### UI and Experience

- Responsive sizing with `flutter_screenutil`.
- Centralized colors, typography, themes, asset paths, spacing, buttons, text fields, loading widgets, and feedback components.
- Page transitions through `go_transitions`.
- Lottie loading animation and reusable shimmer loading components.
- Feature-oriented code organization for easier maintenance and extension.

## Application Screens

| Screen | Route | Current behavior |
| --- | --- | --- |
| Login | `/loginScreen` | Validates credentials, calls login, stores the token, and opens the main screen. |
| Register | `/registerScreen` | Presents the registration form UI; API registration is not connected yet. |
| Main | `/mainScreen` | Hosts the Home, Cart, and Account areas through bottom navigation. |
| Home | Main screen tab | Loads products and categories, refreshes the catalog, and opens product details. |
| Product details | `/productScreen` | Shows product information and sends an add-to-cart request. |
| Cart | Main screen tab | Loads the configured cart and displays item quantities and summary UI. |
| Account | Main screen tab | Displays account actions, address navigation, and logout. |
| Address book | `/addressScreen` | Displays the current static address entries. |

## Screenshots

Add screenshots to `docs/screenshots/` using the filenames below, or update the table when assets are available.

| Screen | Screenshot |
| --- | --- |
| Login | `docs/screenshots/login.png` |
| Home and product catalog | `docs/screenshots/home.png` |
| Product details | `docs/screenshots/product-details.png` |
| Cart | `docs/screenshots/cart.png` |
| Account | `docs/screenshots/account.png` |
| Address book | `docs/screenshots/address-book.png` |

Example Markdown once screenshots are added:

```md
![Home screen](docs/screenshots/home.png)
```

## Architecture

The application follows a feature-oriented layered structure:

```text
UI / Screen
	-> Cubit (state and user actions)
		-> Repository (feature data access)
			-> DioHelper (HTTP client)
				-> Fake Store API
```

Repositories return `Either<String, T>` from `dartz`, allowing Cubits to convert responses and failures into explicit UI states. Dependencies are registered centrally through `get_it` in `lib/core/utils/service_locator.dart`.

### Main Layers

- `core/`: routing, networking, theme, shared widgets, storage, and dependency injection.
- `features/auth/`: login state, authentication repository, models, and authentication screens.
- `features/home/`: categories, products, models, repositories, Cubits, and catalog widgets.
- `features/product/`: product detail presentation and add-to-cart interaction.
- `features/cart/`: cart models, repository, Cubit, screen, and cart widgets.
- `features/account/`: account actions and logout UI.
- `features/address/`: address book presentation.
- `features/main/`: main navigation container.

## Tech Stack

- **Framework:** Flutter / Dart
- **State management:** `flutter_bloc` and Cubit
- **Navigation:** `go_router`, `go_transitions`
- **Networking:** `dio`, `pretty_dio_logger`
- **Dependency injection:** `get_it`
- **Functional error handling:** `dartz`
- **Secure storage:** `flutter_secure_storage`
- **Responsive layout:** `flutter_screenutil`
- **Image loading:** `cached_network_image`
- **Loading and motion:** `lottie`, `shimmer`, `flutter_staggered_animations`
- **User feedback:** `animated_snack_bar`

## API Integration

The base URL is configured in `lib/core/network/api_endpoints.dart`:

```text
https://fakestoreapi.com/
```

| Purpose | Endpoint | Method |
| --- | --- | --- |
| Login | `auth/login` | POST |
| All products | `products` | GET |
| Categories | `products/categories` | GET |
| Products by category | `products/category/{category}` | GET |
| Cart retrieval | `carts/user/2` | GET |
| Add/update cart | `carts/2` | PUT |

The current API helper supports GET, POST, and PUT requests. Request logging is enabled through `PrettyDioLogger` during development.

## Project Structure

```text
lib/
├── core/
│   ├── constants/
│   ├── network/
│   ├── routing/
│   ├── styles/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── account/
│   ├── address/
│   ├── auth/
│   ├── cart/
│   ├── home/
│   ├── main/
│   └── product/
└── main.dart

assets/
├── icons/
└── lottie/

test/
└── widget_test.dart
```

## Getting Started

### Prerequisites

- Flutter SDK compatible with the Dart SDK constraint in `pubspec.yaml` (`^3.12.2`).
- Android Studio or Xcode for mobile development.
- A connected emulator, simulator, or physical device.
- Network access to `fakestoreapi.com`.

### Installation

```bash
git clone <repository-url>
cd ecommerce_app
flutter pub get
flutter run
```

Check the local environment before running:

```bash
flutter doctor
```

Useful commands:

```bash
flutter analyze
flutter test
flutter build apk --release
```

### Demo Authentication

Authentication is delegated to Fake Store API. Use credentials supported by the API environment configured for your development session. The token is stored locally after a successful login and read again during the next app startup.

## Known Limitations

- The search field and search button are visual only; product filtering is not implemented.
- Registration is a presentation-only form and does not call an API.
- The cart uses hard-coded user and cart identifiers (`2`).
- Cart quantity controls, deletion, totals, and checkout callbacks are not implemented.
- Cart prices, taxes, shipping fees, and total are placeholder values.
- Cart item images are not resolved from product data.
- Product details show a hard-coded review count.
- Adding an item from product details does not automatically refresh the cart tab.
- Address entries are static and cannot be added, edited, deleted, or persisted.
- Account entries for orders, details, FAQ, and help center are currently menu placeholders.
- Network-backed empty and error states are not consistently surfaced on the home screen.
- There is no route-level authentication guard, refresh-token flow, authenticated request interceptor, pagination, offline cache, retry strategy, or request timeout configuration.
- The application title is still set to `Flutter Demo` and should be renamed for release builds.
- The configured Urbanist typeface should be bundled or explicitly configured if it is required across platforms.
- The default counter widget test does not represent the current application and currently fails against the production UI.

## Roadmap

### Commerce Flow

- Implement real product search with debouncing and clear/reset behavior.
- Add product image fallback, empty states, retry actions, and richer product metadata.
- Build cart quantity increment/decrement and item deletion.
- Calculate subtotal, VAT, shipping, and total from real product prices.
- Synchronize cart state after add, update, and delete operations.
- Implement checkout, payment handoff, order creation, and order history.

### Account and Authentication

- Connect registration to an API and validate password confirmation correctly.
- Add account details and profile editing.
- Replace static addresses with persisted add/edit/delete address management.
- Add route guards and authenticated request headers.
- Add token refresh and a consistent logout state reset.

### Platform Quality

- Replace the stale counter test with Cubit, repository, routing, and widget tests.
- Introduce typed JSON parsing and immutable data models.
- Centralize API error mapping and add timeout, retry, cancellation, and environment configuration support.
- Remove deprecated secure-storage options and review analyzer diagnostics.
- Add CI checks for formatting, analysis, tests, and release builds.
- Add localization, accessibility semantics, and release-ready app branding.
