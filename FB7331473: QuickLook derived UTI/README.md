# Description
iOS QuickLook system prefers xml text based view (public.xml) over derived format

# Environment
iPad OS 13.0, 13.1, 13.1.1
iOS 13.0, 12.x

# Steps to reproduce
1. Create Quick Look Preview Extension that registers xml derived file format via the main app
2. Open QL for this file in Files app or any other app 
3. XML text preview will be shown but Quick Look Extension won't be called.

# Expected behaviour
QL system should prefer derived format over based and call QL extension for this file type

# Workaround
Replacing based format with public.data

# Sample project description:
The app registers external (imported) com.topografix.gpx file type with "gpx" file extension.
This UTI conforms to public.xml, which conforms to public.text by itself.
QuickLookPreviewExtension that provides preview for this GPX file format won't be called by system in any app. Instead more generic text preview of XML content will be shown. However, replacing base UTI public.xml with public.data forces system to launch QuickLookPreviewExtension.
Exactly this base UTI is used in "Building an App Based on the Document Browser View Controller" demo https://developer.apple.com/documentation/uikit/view_controllers/building_an_app_based_on_the_document_browser_view_controller.
