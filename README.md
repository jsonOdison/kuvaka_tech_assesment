# Personal Finance Tracker

A simple offline-first Flutter app to manage income, expenses, and budgets.  
Built with **Flutter**, **Bloc**, and **Hive**, following clean code principles.

---

## Setup Instructions
- Install Flutter: 3.5.0
- 
- Install dependencies:
   ```bash
   flutter pub get

- Generate Hive adapters::
   ```bash
   dart run build_runner build --delete-conflicting-outputs

# Architecture & State Management

## Architecture
Feature-based clean architecture

## State Management
Flutter Bloc for predictable state handling

## Local Storage
Hive for offline persistence

## Dependency Injection
GetIt for centralized service registration

## UI
Stateless and reactive, built with BlocBuilder and BlocListener


## Features

### Dashboard
- Displays total **Income**, **Expenses**, and **Balance**  
- Visualizes spending by category using a **pie chart**  
- Highlights categories that exceed or approach their **budget limit**

### Transactions
- Add, edit, and delete transactions with predefined categories  
- Swipe-to-delete with confirmation  
- Pull-to-refresh support  
- Offline persistence using Hive  
- Export transactions to **CSV**  

### Budgets
- Add or update budgets for each category  
- Category dropdown ensures consistency with transactions  
- Swipe-to-delete support  
- Dashboard alerts when limits are exceeded  

### Other
- Light and dark mode support  
- Local data storage (Hive)  
- Clean and modular codebase  

---

## Technical Summary
- **Framework:** Flutter 3.x  
- **State Management:** Flutter Bloc  
- **Local Storage:** Hive  
- **Dependency Injection:** GetIt  
- **Charts:** fl_chart  
- **Formatting:** intl  
- **CSV Export:** csv, path_provider  

---

## Quick Overview

| Module | Functionality |
|---------|----------------|
| Transactions | CRUD, categories, swipe-to-delete, CSV export |
| Budgets | CRUD, category-based limits, swipe-to-delete |
| Dashboard | Income/Expense summary, balance, chart, alerts |
| Theme | Light/Dark mode toggle |

---

## CSV Export Path
Files are saved to:
