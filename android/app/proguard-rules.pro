# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# SQLite & Drift Database Rules
-keep class androidx.sqlite.db.** { *; }
-keep class androidx.sqlite.db.framework.** { *; }
-keep class com.simonbinder.sqlite3_flutter_libs.** { *; }

# Keep model & data classes for reflection
-keepattributes *Annotation*,EnclosingMethod,InnerClasses,Signature
-keepattributes SourceFile,LineNumberTable
