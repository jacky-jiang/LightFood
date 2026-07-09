# AI Coding Guidelines

## 1. Goal

This document defines how AI coding tools should modify this native iOS project.

## 2. Architecture

The project uses SwiftUI + MVVM.

Allowed dependency direction:

App → Features → Core / Shared

## 3. Directory Responsibilities

- App: application entry, environment, and routing.
- Features: feature-specific Views, ViewModels, Models, Services, and mocks.
- Core: networking, storage, logging, and system integrations.
- Shared: reusable components, design system, and utilities.

## 4. Swift Rules

- Use async/await for asynchronous work.
- Avoid force unwrap unless explicitly justified.
- Prefer value types for models.
- Prefer final classes for reference types not intended for inheritance.
- Use explicit access control when it improves clarity.

## 5. SwiftUI Rules

- Views should stay declarative and lightweight.
- ViewModels own view state and user interaction logic.
- Do not put network calls in Views.
- Extract complex Views into smaller subviews.

## 6. Testing Rules

- ViewModels with branching logic must have XCTest coverage.
- Services should be testable through protocols.
- Unit tests must not rely on live network calls.

## 7. CI Rules

Use xcodebuild for simulator-based build and test.

## 8. XcodeGen Policy

XcodeGen is optional. If project.yml exists and XcodeGen is enabled, update project.yml instead of directly editing generated Xcode project internals.

## 9. Forbidden Files

See docs/forbidden-files.md.
