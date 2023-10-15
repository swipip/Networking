##!/bin/sh

hosting_base_path="$1"

# Create the docC archive.
xcrun xcodebuild docbuild \
    -project Sample/NetworkingSample.xcodeproj \
    -scheme Networking \
    -derivedDataPath "./.build" \
    -destination 'generic/platform=iOS Simulator' | xcpretty
    
# Convert the created docC archive to a static website.
xcrun docc process-archive transform-for-static-hosting \
    "./.build/Build/Products/Debug-iphonesimulator/Networking.doccarchive" \
    --output-path "./docs" \
    --hosting-base-path "$hosting_base_path" | xcpretty

# Overwrite generated index.html with a redirection. 
echo '<script>window.location.href += "documentation/networking"</script>' > ./docs/index.html
