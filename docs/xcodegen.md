# XcodeGen

XcodeGen support is optional in this MVP.

Use XcodeGen when you want the Xcode project to be generated from a declarative project.yml file.

## Commands

```bash
brew install xcodegen
xcodegen generate
```

CI/CD does not require XcodeGen. The default path uses the generated .xcodeproj and xcodebuild directly.
