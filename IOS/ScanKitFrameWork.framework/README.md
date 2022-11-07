# ScanKit iOS SDK

ScanKit  Huawei code scanning service（Scan Kit）Provide convenient barcode and QR code scanning, parsing, generation capabilities, help you quickly build the scanning function in the application.

Thanks to Huawei's ability to accumulate in the field of computer vision, Scan Kit can realize the detection and automatic amplification of long-distance code or small code. At the same time, it makes targeted identification optimization for common complex code scanning scenes (such as reflection, dark light, stain, blur, cylinder), so as to improve the success rate of code scanning and user experience.

## SDK Access

### Add SDK

1. Open a command line window and 'cd' to the location of the Xcode project.
2. Create a 'Podfile' file. If it already exists, skip this step.
```
cd project-directory 
pod init
```
3. Add the pod of SDK to podfile. The currently supported services are shown in the following table.
```
pod 'ScanKitFrameWork', '~> 1.0.1.300'
```
|service|collocation method|
|----|-----|
|Certification services|pod ‘ScanKitFrameWork’|

4. install pod，Then open it .xcworkspace file add view the project。
```
pod install
```

## LICENSE

see[Huawei License file](./LICENSE)

