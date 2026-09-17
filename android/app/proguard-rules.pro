# Mārgadarshak — R8 / ProGuard rules
#
# The Dart layer is AOT-compiled and unaffected by R8; these rules protect the
# Java/Kotlin side that R8 does shrink. Keep this file minimal — every rule
# here is a shrinking opportunity given up, so add one only with a reason.

# ─── Flutter engine & embedding ──────────────────────────────────────────
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Plugin registration is reflective — the registrant must survive shrinking.
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }

# ─── shared_preferences ──────────────────────────────────────────────────
# The only plugin in this app. Its Android side is reached via the
# MethodChannel, which R8 cannot see as a reference.
-keep class io.flutter.plugins.sharedpreferences.** { *; }

# ─── AndroidX / Kotlin / Play Core housekeeping ──────────────────────────
-dontwarn kotlin.**
-dontwarn kotlinx.**
-dontwarn com.google.android.play.core.**
-keepattributes *Annotation*

# Keep line numbers so crash reports stay readable after obfuscation.
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile
