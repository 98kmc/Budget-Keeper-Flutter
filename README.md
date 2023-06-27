# Flutter Budget Keeper.


-
|       Home Screen:        |    New / Update Screen:   |
| :-----------------------: | :-----------------------: |
| ![budget_keeper_flutter_home_screen](https://github.com/98kmc/Budget-Keeper-Flutter/assets/109832770/c7bcf316-7dfe-45e8-854d-ed47b8d6c824) | ![budget_keeper_flutter_update_screen](https://github.com/98kmc/Budget-Keeper-Flutter/assets/109832770/45685474-0064-4382-be9e-f85545c89a7f) |

### About
This is a simple Flutter app inspired by the classic "ToDo List" concept. It follows the principles of clean architecture and does not rely on any third-party dependencies.

### Features
Create new accounts with a title and an initial amount set to zero.
Edit existing accounts to update their amount value.
Delete accounts that are no longer needed.
### Clean Architecture
The app is structured using the principles of clean architecture, which provide a clear separation of concerns and make the codebase highly testable and maintainable. The architecture consists of the following layers:

- Presentation: Contains the UI components, including the screens and widgets. It is responsible for displaying data and receiving user input.
- Domain: Defines the core business logic and entities of the app, including entities and services logic.
- Data: Handles the data access and repository implementation. It abstracts the app's data sources using a local database and provides methods for CRUD operations on accounts.


### Dependencies
The Flutter Budget Keeper app is built using the following third-party dependencies:
- cupertino_icons: https://github.com/flutter/flutter.git
- sqflite: https://github.com/tekartik/sqflite.git
- fluttertoast: https://github.com/ponnamkarthik/FlutterToast.git
- money2: https://pub.dev/packages/money2
  
These dependencies enhance the functionality of the app and provide additional features and utilities.
