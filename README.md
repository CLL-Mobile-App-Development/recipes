# Recipe Collection

* Description

This is a simple android app built as an interface to access a collection of recipes that you might enjoy exploring and cooking. It has been written using *Flutter/Dart* and is part of an online course taught by *Maximilian Schwarzmüller*. Most of the sample recipe data rendered in the app has been obtained from the online course project, along with the ideas for styling, screen layout and navigation.

The original app idea from the course has been extended to have a switch on each category's recipe collection screen that could filter recipes by applying your preset preferences. Additionally, the app data is stored in and fetched from Firebase Cloud Firestore (a NoSQL database). This is different from the online course approach to store and access data locally from a file that is part of the app source.

Different recipes in the app have been organized into multiple categories, as a recipe can be tagged under more than one category. Each recipe would have the list of ingredients, steps, along with an image of the final recipe. Users can also mark their favorite recipes with quick access through a dedicated *Favorites* tab.


<img src="https://github.com/CLL-Mobile-App-Development/recipes/blob/master/Recipe_App_Final_Gif.gif" alt="Recipe-Collection-App-Gif" width=500px height=875px/>


***


* Installation

Apart from the normal process of installing an Android app on an emulator or actual device, two additional steps are needed
specific to this app.

1. If your android version < 5.0 (API level 21), _Multidex_ should be enabled in app-level _build.gradle_ file. Reason       being that the Dalvik executable (android's run-time until version 5.0) generated for this version of app has referenced methods in excess of 64K. That is the default limit set for Dalvik's executable (DEX file) in order to restrict the app (.apk file) to have a single DEX file.

_Multidex_ is a way to allow multiple DEX files in the app executable.

More information is available in below link, along with the required settings in app-level _build.gradle_ file:  
[Enable multidex for apps with over 64K methods](https://developer.android.com/studio/build/multidex)

*sample app-level gradle configuration file (within android/app folder) setting to enable multidex*:

    android {
        defaultConfig {
            ...
            minSdkVersion 15    // version number is < 21
            targetSdkVersion 28
            multiDexEnabled true // New line to be added to enable Multidex
        }
        ...
    }

    dependencies {
    // include below line only if your project had not been created with project type(-t option) set to AndroidX
    implementation 'com.android.support:multidex:1.0.3'

    // include below two lines only if your project had the project type(-t option) set to AndroidX at the creation time
    def multidex_version = "2.0.1"
    implementation 'androidx.multidex:multidex:$multidex_version'

    ...
    }


More details on migrating android projects to AndroidX can be found here: [AndroidX Migration](https://flutter.dev/docs/development/androidx-migration)




2. Register app to Firebase Cloud Firestore. Necessary Cloud Firestore files and settings to be included in the project will be available as part of the Firebase account set-up and app registration process. 

During the app set-up process on Firebase, a _google-services.json_ file will be created with information like your api-key, which is to be downloaded and included in the android project's app folder path. That file would be used to enable app connection with Cloud Firestore and perform different data operations through its api. Additional settings would also be required in the *project-level* and *app-level* *build.gradle* files. All of that information will be given to you during the set-up process.

Here is the link to Google Firebase: [Firebase](https://firebase.google.com/)