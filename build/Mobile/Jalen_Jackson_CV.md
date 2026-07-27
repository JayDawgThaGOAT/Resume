# Jalen Jackson's CV

- Email: [jackson.jalen@proton.me](mailto:jackson.jalen@proton.me)
- LinkedIn: [jalen-jackson](https://linkedin.com/in/jalen-jackson)
- GitHub: [JayDawgThaGOAT](https://github.com/JayDawgThaGOAT)


# Summary
Software Engineer with 5+ years building cross-platform mobile SDKs, authentication systems, and identity infrastructure across iOS, Android, and game engine platforms.

# Experience
## **Software Engineer, Identities**, Zynga -- Remote

Jan 2023 – present

- Authored the cross-platform secure token storage tech spec, designing iOS Keychain persistence with lazy migration from legacy PlayerPrefs and a Unity Editor fallback

- Migrated the iOS Keychain package to Swift Package Manager and root-caused an access-group bug where iOS defaulted to the wrong entitlement, publishing a podspec fix

- Implemented Android token persistence in C++ via a JNI bridge to Kotlin, adding the missing platform branch that had blocked token storage from ever being written

- Shipped a Kotlin Auto Backup bridge library and authored the Block Store replacement tech spec to eliminate a cold-start restore race that left auth reading empty storage

- Guarded Attach and Login against concurrent duplicate calls in C#, eliminating double recovery pop-ups from rapid taps on Apple Game Center and Google Play Games



## **Software Engineer, Unity**, Playdots -- Remote

June 2021 – Jan 2023

- Owned core gameplay systems in Unity C# for Two Dots, a top-100 mobile title, delivering the level editor pipeline and mechanics that powered ongoing releases

- Led Garden Tails from alpha to Apple Arcade global release, architecting the localization pipeline and ensuring App Store compliance for worldwide distribution

- Shipped Unity C# monetization systems for Garden Tails, including an MVC Credits scene and in-game economy features that drove player re-engagement



# Education
## **California State University, Fullerton**, B.S. in Computer Science -- Fullerton, CA
Jan 2021



# Skills
**Languages:** C#, C++, Objective-C, Kotlin, Java

**Platforms & Tooling:** iOS Keychain, Android Auto Backup / Block Store, JNI, Swift Package Manager, CocoaPods, Xcode, Gradle, Artifactory
