plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.goodcollect"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        kotlinOptions {
            // ✅ CORRECTION : Revenir à la syntaxe standard jvmTarget
            jvmTarget = "17" // Utilisez "17" ou "1.8" (le plus courant) ou "11"
        }
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.goodcollect"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// Dans android/app/build.gradle.kts
dependencies {
    // ... autres dépendances (ex: implementation(kotlin("stdlib")))

    // ✅ CORRECTION : Utilisation de la syntaxe correcte implementation(...)
    // Note: platform() est souvent implicite, mais l'appel peut être nécessaire.
    implementation(platform("com.google.firebase:firebase-bom:34.5.0"))

    // Ajoutez ensuite les dépendances spécifiques, par exemple pour Auth :
    implementation("com.google.firebase:firebase-auth")
}
