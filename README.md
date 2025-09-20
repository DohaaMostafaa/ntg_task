# ntg_task
Overview
A mini e-commerce Flutter app implementing Home and Cart pages based on provided XD designs. The app demonstrates clean architecture, API integration, responsive UI, and state management.
Features
Home Page with bottom navigation, local banners, categories from API, products grid, and shimmer loading animation
Cart Page with add-to-cart, cart summary, total price calculation, and simulated cart actions
Product details page
Light/dark mode support
Basic localization (English/Arabic)
Unit/widget tests
API Endpoints Used
Products:
https://fakestoreapi.com/products
Categories:
https://fakestoreapi.com/products/categories
Folder Structure
lib/core/ – Shared logic (assets, DI, helpers, localization, networking, router, services, theme, widgets)
lib/features/ – Feature modules (cart, home)
assets/ – Images and translations
test/ – Unit and widget tests
State Management
Provider is used for simplicity and scalability, allowing easy separation of UI and business logic.
Localization
Supports English and Arabic via JSON files in assets/translations/.
Light/Dark Mode
Theme switching is supported using Flutter’s built-in theming.
