// Top-level build.gradle.kts

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Custom build directory path (optional)
val customBuildDir = file("../../build")

// Configure subprojects
subprojects {
    // Optional: set buildDir for each subproject
    buildDir = File(customBuildDir, name)

    // Ensure ':app' is evaluated before others
    evaluationDependsOn(":app")
}
// Clean task
tasks.register<Delete>("clean") {
    delete(customBuildDir)
}
