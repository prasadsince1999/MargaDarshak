import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

/// True when the invoked Gradle tasks include a release variant. Used so the
/// missing-keystore check fails release builds only, never `flutter run`.
val isBuildingRelease = gradle.startParameter.taskNames.any {
    it.contains("Release", ignoreCase = true)
}

android {
    namespace = "com.margadarshak.margadarshak"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlin {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }

    defaultConfig {
        // Permanent once published to Play. Owned by KSM x Tech.
        applicationId = "com.ksmxtech.margadarshak"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (keystorePropertiesFile.exists()) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"] as String?
                keyPassword = keystoreProperties["keyPassword"] as String?
                storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }
                storePassword = keystoreProperties["storePassword"] as String?
            }
        }
    }

    buildTypes {
        release {
            // Never fall back to the debug key. A debug-signed "release" is
            // rejected by Play, and if one ever slipped through the key could
            // not be rotated. Checked only when a release task is actually
            // requested, so `flutter run` still works without a keystore.
            if (isBuildingRelease && !keystorePropertiesFile.exists()) {
                throw GradleException(
                    "android/key.properties is missing — cannot build a release. " +
                    "Create it with keyAlias, keyPassword, storeFile and storePassword."
                )
            }
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                null
            }

            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )

            // Full native symbols so Play can symbolicate crashes.
            ndk {
                debugSymbolLevel = "FULL"
            }
        }
    }
}

flutter {
    source = "../.."
}
