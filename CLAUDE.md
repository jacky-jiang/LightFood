# CLAUDE.md

## Working Agreement

Before modifying code:

1. Read the related View, ViewModel, Model, and Service files.
2. Preserve MVVM boundaries.
3. Prefer small, reviewable diffs.
4. Do not rewrite unrelated Xcode project settings.
5. Add or update XCTest coverage for ViewModel and Service logic.

## SwiftUI Rules

- Keep Views declarative.
- Do not perform networking in Views.
- Move state transitions into ViewModels.
- Avoid force unwraps.
- Prefer dependency injection through protocols.

## Xcode Project Rules

- Do not modify signing settings unless explicitly requested.
- Do not modify Bundle Identifier unless explicitly requested.
- Do not modify project.pbxproj broadly.
- If XcodeGen is enabled, update project.yml instead of editing generated project files.

## Validation

After changes, run:

```bash
xcodebuild test   -project LightFood.xcodeproj   -scheme LightFood   -destination 'platform=iOS Simulator,name=iPhone 16'   CODE_SIGNING_ALLOWED=NO
```
