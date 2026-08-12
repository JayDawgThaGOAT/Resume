// Import the rendercv function and all the refactored components
#import "@preview/rendercv:0.3.0": *

// Apply the rendercv template with custom configuration
#show: rendercv.with(
  name: "Jalen Jackson",
  title: "Jalen Jackson - CV",
  footer: context { [#emph[Jalen Jackson -- #str(here().page())\/#str(counter(page).final().first())]] },
  top-note: [ #emph[Last updated in Aug 2026] ],
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
    month: 8,
    day: 11,
  ),
)


= Jalen Jackson

  #headline([Software Engineer: Cross-Platform Systems & Mobile])

#connections(
  [#link("mailto:jackson.jalen@proton.me", icon: false, if-underline: false, if-color: false)[#connection-with-icon("envelope")[jackson.jalen\@proton.me]]],
  [#link("https://linkedin.com/in/jalen-jackson", icon: false, if-underline: false, if-color: false)[#connection-with-icon("linkedin")[jalen-jackson]]],
  [#link("https://github.com/JayDawgThaGOAT", icon: false, if-underline: false, if-color: false)[#connection-with-icon("github")[JayDawgThaGOAT]]],
)


== Summary

Software Engineer with 5+ years building production software across mobile, game engine, and SDK platforms in C\#, C++, Java, and GDScript.

== Experience

#regular-entry(
  [
    #strong[Software Engineer, Identities], Zynga -- Remote

  ],
  [
    Jan 2023 – present

  ],
  main-column-second-row: [
    - Authored the AuthenticationFlow API guard recommendations, scoping a single concurrency flag to replace granular per-method flags and categorizing which public auth entry points need guards

    - Drove V2 API naming consistency across the C\# and C++ SDKs, aligning public callbacks and methods to remove cross-platform drift

    - Migrated reCAPTCHA from Classic to Enterprise in C++ for Unreal Engine 5 iOS, writing a reusable CMake helper to embed Swift frameworks into the static auth library

    - Fixed WebGL incompatibility in the C\# SDK by replacing blocking delays with a task utility, preserving the base-class contract for WebGL builds

    - Refactored the ImpersonateAccount API to Impersonate across the C++ SDK, unit tests, and integration tests, replacing the legacy command in the launcher

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

#strong[Languages:] C\#, C++, Java, GDScript, Objective-C, Kotlin

#strong[Platforms & Practices:] iOS, Android, Unity, Unreal Engine 5, WebGL, JNI, CMake, SPM, Gradle
