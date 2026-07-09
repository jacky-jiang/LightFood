# GitHub Copilot Instructions

This is a native iOS project using SwiftUI and MVVM.

Follow these rules:

- Keep SwiftUI Views lightweight and declarative.
- Put state and user interaction logic in ViewModels.
- Do not call APIs directly from Views.
- Use async/await for asynchronous logic.
- Use protocols for services that need to be mocked in tests.
- Add XCTest coverage for ViewModels and service logic.
- Do not modify signing settings or Bundle ID unless explicitly requested.
- Respect dependency direction: App → Features → Core / Shared.
