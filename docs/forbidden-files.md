# Forbidden Files

AI coding tools must not modify these files unless explicitly requested:

- *.xcodeproj/project.pbxproj
- *.xcworkspace/contents.xcworkspacedata
- *.mobileprovision
- *.p12
- *.cer
- ExportOptions.plist
- fastlane/.env
- secrets/**
- credentials/**
- DerivedData/**
- build/**
- .build/**

If XcodeGen is enabled, prefer updating project.yml instead of directly editing .xcodeproj internals.
