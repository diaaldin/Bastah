plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.diaaldin.basta"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.diaaldin.basta"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        release {
            keyAlias = 'bastah-key-alias'
            keyPassword = 'diakrea00'
            storeFile = file('/full/path/to/my-release-key.jks')
            storePassword = 'diakrea00'
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.release
            minifyEnabled = false
        }
    }
}

flutter {
    source = "../.."
}
