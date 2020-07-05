# android-apps-benchmark-energy-measures
This repositroy contains the raw data and analysis scripts for the experiments about the energy consumption of the apps of our Android apps benchmark.

## The experiment
For the experiment, 15 benchmark apps were used. Each benchmark app tests a different functionality within the phone (e.g. the camera or writing to local storage). These benchmark apps can be found in the [Benchmark Apps](https://github.com/S2-group/android-apps-benchmark) repository. Some of these apps have different intensities (low, medium, and high) and are thus replicated 3 times. In total, 27 benchmark app frequency combinations have been tested. We have also used three different test devices, the Xiaomi Mi 9T, LG Nexus 5X and a Nexus 5X configured to work with a [Monsoon Power Monitor](https://www.msoon.com/online-store/High-Voltage-Power-Monitor-Part-Number-AAA10F-p90002590). Each test is also replicated for each test device which totals the number of tests to 81.

Android Runner is used to conduct the experiment. Every benchmark app and intensity combination is run for 3 minutes and is then automatically stopped after this period by Android Runner. Each run is replicated 30 times with 2 minutes between each run, in order to account for the fluidity of energy consumption as a measure.

The raw results of the experiment can be found in the [Raw Results](/Raw%20Results) folder. The processed results can be found in the [Processed Results](/Processed%20Results) folder.

## Reproduction - Batterystats
Before reproduction, the experiments can only be conducted on linux distributions (preferably Ubuntu). The experiments can be replicated by following these steps:
* Install Android Studio: this can be done from the Ubuntu Software program or from the [official website](https://developer.android.com/studio/install).
* Install Android Runner: this can be done by following the steps provided on the [official github page](https://github.com/S2-group/android-runner).
* Add your device to devices.json:
  1. Open a Terminal and run `adb start-server`.
  2. Run `adb devices` and copy the id of your device.
  3. Open `android-runner/devices.json` with a text editor and add your device to the list. The first part is the device name that we will use in further code to denote your device and the second part is the id of your device which you copied in the previous step.
* Get the power_profile.xml from your phone:
  1. Open Android Studio. Head to the Device File Explorer tab in the bottom right of your screen. Navigate to the sytem folder -> framework folder -> Grab the framework-res.apk and copy it to your PC.
  2. Install APKTool: this can be done by following the steps provided on the [official website](https://ibotpeaches.github.io/Apktool/install/).
  3. OPTIONAL: if the apktool does not work in itself, try running `java -jar /usr/local/bin/apktool.jar` instead of `apktool`.
  4. Decode the framework-res.apk file: this can be done by navigating to the directory containing this file inside a terminal. Then execute `java -jar /usr/local/bin/apktool.jar d framework-res.apk`.
  5. Find power_profile.xml: the previous step should have created a framework-res folder in your directory. Find and copy power_profile.xml to the `android-runner/examples/batterystats/Scripts` folder.
* The following steps need to be done for every experiment:
  1. Add APK to batterystats folder: this can be done by building a project from Android Studio and moving the APK file to `android-runner/examples/batterystats`. Rename the apk so that it conforms to this template `%PACKAGE NAME%.apk`. For example, the baseline app needs to be named `e.www.baseline.apk`.
  2. Add APK to config.json: this can be done by opening config.json in the `android-runner/examples/batterystats` folder with a text editor and set `"paths" : [ "%DEFAULT PATH%" ]` to the path of your APK file. Since we placed the APK in the same folder, we can simply add `"android-runner/examples/batterystats/%APK NAME%.apk"` as our path.
  3. ON THE FIRST EXPERIMENT: when you alter the config.json file for the first time, you have to alter some lines. Make sure that `"replications" : 30`. Replace the default device in `"devices" : { "%DEFAULT DEVICE%": {} }` with your own device, remember to use the same name as you have entered in the devices.json file. Set `"duration" : 180000` and `"time_between_run" : 120000`. The Config file used for this experiment can also be found in the [Config](/Android%20Runner%20Config) folder of this repository. 
  4. Start the experiment: open a Terminal and run `python3 android-runner android-runner/examples/batterystats/config.json` to start the experiment. Keep in mind that the experiment takes 2,5 hours to complete. You can find your results in the `android-runner/examples/batterystats/output` folder.

## Reproduction - Monsoon
Review the Monsoon [README](https://github.com/S2-group/android-runner/tree/master/AndroidRunner/Plugins/monsoon).  In summary:
1. A Monsoon configured LG Nexus 5X with WiFi on.
2. One high-voltage Monsoon Power Monitor.
3. [Android Runner](https://github.com/S2-group/android-runner) with [this](/Android%20Runner%20Config) configuration.
4. 10 total, randomized experiments where each app is ran three times (30 times in total) and where each app run lasts for three minutes and rests for two minutes before the next app run begins.
5. Minimal background activity on device: minimal brightness, ambient light, no push notifications, no location services, etc.

## Data analysis
In the Processed Excel files in the [Processed Results](/Processed%20Results) folder, the following steps are taken to analyse the data:
1. All raw results of the benchmark app are entered in the file.
2. Basic measures like min, max, mean, etc. are calculated.
3. Scatter plots are used to plot the variance.

Furthermore, the R file uses the aggregated raw results in the Raw Excel file to create violin plots of the data.
