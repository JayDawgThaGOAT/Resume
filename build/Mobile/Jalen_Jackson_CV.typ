// Import the rendercv function and all the refactored components
#import "@preview/rendercv:0.3.0": *

// Apply the rendercv template with custom configuration
#show: rendercv.with(
  name: "Jalen Jackson",
  title: "Jalen Jackson - CV",
  footer: context { [#emph[Jalen Jackson -- #str(here().page())\/#str(counter(page).final().first())]] },
  top-note: [ #emph[Last updated in July 2026] ],
  locale-catalog-language: "en",
  text-direction: ltr,
  page-size: "us-letter",
  page-top-margin: 0.5in,
  page-bottom-margin: 0.5in,
  page-left-margin: 0.5in,
  page-right-margin: 0.5in,
  page-show-footer: false,
  page-show-top-note: false,
  colors-body: rgb(0, 0, 0),
  colors-name: rgb(0, 0, 0),
  colors-headline: rgb(0, 79, 144),
  colors-connections: rgb(0, 0, 0),
  colors-section-titles: rgb(0, 0, 0),
  colors-links: rgb(0, 0, 0),
  colors-footer: rgb(128, 128, 128),
  colors-top-note: rgb(128, 128, 128),
  typography-line-spacing: 0.85em,
  typography-alignment: "justified",
  typography-date-and-location-column-alignment: right,
  typography-font-family-body: "Raleway",
  typography-font-family-name: "Raleway",
  typography-font-family-headline: "Raleway",
  typography-font-family-connections: "Raleway",
  typography-font-family-section-titles: "Raleway",
  typography-font-size-body: 10pt,
  typography-font-size-name: 25pt,
  typography-font-size-headline: 10pt,
  typography-font-size-connections: 9pt,
  typography-font-size-section-titles: 1.2em,
  typography-small-caps-name: false,
  typography-small-caps-headline: false,
  typography-small-caps-connections: false,
  typography-small-caps-section-titles: false,
  typography-bold-name: false,
  typography-bold-headline: false,
  typography-bold-connections: false,
  typography-bold-section-titles: false,
  links-underline: false,
  links-show-external-link-icon: false,
  header-alignment: left,
  header-photo-width: 3.5cm,
  header-space-below-name: 0.7cm,
  header-space-below-headline: 0.7cm,
  header-space-below-connections: 0.7cm,
  header-connections-hyperlink: true,
  header-connections-show-icons: true,
  header-connections-display-urls-instead-of-usernames: false,
  header-connections-separator: "",
  header-connections-space-between-connections: 0.5cm,
  section-titles-type: "with_full_line",
  section-titles-line-thickness: 0.5pt,
  section-titles-space-above: 0.7cm,
  section-titles-space-below: 0.45cm,
  sections-allow-page-break: true,
  sections-space-between-text-based-entries: 0.25cm,
  sections-space-between-regular-entries: 0.7cm,
  entries-date-and-location-width: 4.15cm,
  entries-side-space: 0.2cm,
  entries-space-between-columns: 0.1cm,
  entries-allow-page-break: false,
  entries-short-second-row: false,
  entries-degree-width: 1cm,
  entries-summary-space-left: 0cm,
  entries-summary-space-above: 0.25cm,
  entries-highlights-bullet:  text(13pt, [•], baseline: -0.6pt) ,
  entries-highlights-nested-bullet:  text(13pt, [•], baseline: -0.6pt) ,
  entries-highlights-space-left: 0cm,
  entries-highlights-space-above: 0.25cm,
  entries-highlights-space-between-items: 0.2cm,
  entries-highlights-space-between-bullet-and-text: 0.3em,
  date: datetime(
    year: 2026,
    month: 7,
    day: 26,
  ),
)


= Jalen Jackson

  #headline([Software Engineer: Mobile SDK & Authentication Systems])

#connections(
  [#link("mailto:jackson.jalen@proton.me", icon: false, if-underline: false, if-color: false)[#connection-with-icon("envelope")[jackson.jalen\@proton.me]]],
  [#link("https://linkedin.com/in/jalen-jackson", icon: false, if-underline: false, if-color: false)[#connection-with-icon("linkedin")[jalen-jackson]]],
  [#link("https://github.com/JayDawgThaGOAT", icon: false, if-underline: false, if-color: false)[#connection-with-icon("github")[JayDawgThaGOAT]]],
)


== Summary

Software Engineer with 5+ years building cross-platform mobile SDKs, authentication systems, and identity infrastructure across iOS, Android, and game engine platforms.

== Experience

#regular-entry(
  [
    #strong[Software Engineer, Identities], Zynga -- Remote

  ],
  [
    Jan 2023 – present

  ],
  main-column-second-row: [
    - Authored the cross-platform secure token storage tech spec, designing iOS Keychain persistence with lazy migration from legacy PlayerPrefs and a Unity Editor fallback

    - Migrated the iOS Keychain package to Swift Package Manager and root-caused an access-group bug where iOS defaulted to the wrong entitlement, publishing a podspec fix

    - Implemented Android token persistence in C++ via a JNI bridge to Kotlin, adding the missing platform branch that had blocked token storage from ever being written

    - Shipped a Kotlin Auto Backup bridge library and authored the Block Store replacement tech spec to eliminate a cold-start restore race that left auth reading empty storage

    - Guarded Attach and Login against concurrent duplicate calls in C\#, eliminating double recovery pop-ups from rapid taps on Apple Game Center and Google Play Games

  ],
)

#regular-entry(
  [
    #strong[Software Engineer, Unity], Playdots -- Remote

  ],
  [
    June 2021 – Jan 2023

  ],
  main-column-second-row: [
    - Owned core gameplay systems in Unity C\# for Two Dots, a top-100 mobile title, delivering the level editor pipeline and mechanics that powered ongoing releases

    - Led Garden Tails from alpha to Apple Arcade global release, architecting the localization pipeline and ensuring App Store compliance for worldwide distribution

    - Shipped Unity C\# monetization systems for Garden Tails, including an MVC Credits scene and in-game economy features that drove player re-engagement

  ],
)

== Education

#education-entry(
  [
    #strong[California State University, Fullerton], B.S. in Computer Science -- Fullerton, CA

  ],
  [
    Jan 2021

  ],
  main-column-second-row: [
  ],
)

== Skills

#strong[Languages:] C\#, C++, Objective-C, Kotlin, Java

#strong[Platforms & Tooling:] iOS Keychain, Android Auto Backup \/ Block Store, JNI, Swift Package Manager, CocoaPods, Xcode, Gradle, Artifactory
