# CI/CD

## Local test command

```bash
xcodebuild test   -project LightFood.xcodeproj   -scheme LightFood   -destination 'platform=iOS Simulator,name=iPhone 16'   CODE_SIGNING_ALLOWED=NO
```

## Archive command placeholder

```bash
xcodebuild archive   -project LightFood.xcodeproj   -scheme LightFood   -archivePath build/LightFood.xcarchive
```

CD is intentionally not automated in MVP. Add signing, exportOptions, and App Store Connect integration in later versions.
