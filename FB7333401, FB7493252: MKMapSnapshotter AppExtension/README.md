# Status update
QuickLookPreview use case was fixed in iOS 13.3. However, `MKMapSnapshotter` still doesn't work in Thumbnail extension 😕 [FB7493252]

# Description
`MKMapSnapshotter` does not render a map in QuickLookPreview and Thumbnail extensions and throws an error even though it renders in a map in a host app.
Also, since iOS 13 it is impossible to use `MKMapView` in extension because it consumes too much memory and reaches extension's memory limit [FB7257369].

# Steps to reproduce
Create `MKMapSnapshotter` in QuickLookPreview or Thumbnail extension and call `start` method.

# Expected result
`MKMapSnapshotter` should return `MKMapSnapshotter.Snapshot` object that contains an image.

# Actual result
`MKMapSnapshotter` returns nil instead of `MKMapSnapshotter.Snapshot` and an error.
Full error's description:
```
Error Domain=NSCocoaErrorDomain Code=4099 "The connection to service on pid 0 named com.apple.MapKit.SnapshotService was invalidated."
```
In Thumbnail extension log there is also this message
```
Couldn't read values in CFPrefsPlistSource<0x10460c9f0> (Domain: com.apple.GEO, User: kCFPreferencesCurrentUser, ByHost: No, Container: kCFPreferencesNoContainer, Contents Need Refresh: No): accessing preferences outside an application's container requires user-preference-read or file-read-data sandbox access
```

# Environment
Tested on iOS/iPadOS 13.1.1
`MKMapSnapshotter` doesn't render an image on iOS 12 too failing with another error.

# Demo app
The app registers new file type to trigger QuickLookPreview or Thumbnail extensions which call `MKMapSnapshotter`. It shouldn't register "public.text" derived type otherwise system will open text preview but not a QuickLookPreview extension [FB7331473].
'Open Preview' button in the app presents QuickLookPreview extension via system `QLPreviewController`. Share action in this preview will trigger Thumbnail extension.
