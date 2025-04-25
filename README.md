# Send OTP React-Native Sdk!

**The SendOtp SDK makes verifying OTP easy. SDK supports the verification of email and phone numbers via SMS, Calls & Whatsapp.**



## Getting started

Login or create account at MSG91 to use sendOTP services.

**Get your widgetId and authToken:**

After login at MSG91, follow below steps to get your widgetId and authToken:
1. Select OTP option available on dashboard.
2. Create and configure your widget.
3. If you are first time user then generate new token and keep it enable.
4. The widgetId and authToken generated from the above steps will be required for initializing the widget.

**Note:** To ensure that this SDK functions correctly within your mobile application, please enable Mobile Integration while configuring the widget.

## 📦 Installation

### Swift Package Manager (SPM)

You can install the package via **Xcode**:

1. Open your project in **Xcode**
2. Go to **File > Add Packages**
3. Enter the repository URL: https://github.com/d-o-2021/sendOTP
4. Select the latest version
5. Click **Add Package**

Or 

Add the package manually to your `Package.swift` file:

```swift
dependencies: [
 .package(url: "https://github.com/d-o-2021/sendOTP", from: "1.0.0")
]
```

## Example

```jsx
import SwiftUI
import sendOtp // Importing the custom Swift Package you created

struct ContentView: View {
    @State private var number: String = ""

    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Input Field
            // User enters the mobile number here
            TextField("Enter number/mail", text: $number)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

            // MARK: - Send OTP Button
            Button(action: {
                handleSendOtp() // Trigger OTP send when tapped
            }) {
                Text("Send OTP")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
        .padding()
        .onAppear {
            // MARK: - Initialize OTP Widget
            // This must be called before using OTP methods
            OTPWidget.initializeWidget(
                widgetId: "3461******************38",
                tokenAuth: "125*******************TP1"
            )
        }
    }

    // MARK: - OTP Sending Logic
    func handleSendOtp() {
        let data: [String: Any] = [
            "identifier": number // Pass user-entered number in expected key
        ]

        // Call the sendOTP function from the Swift Package
        OTPWidget.sendOTP(body: data) { result in
            switch result {
            case .success(let response):
                // Handle success - You can parse and use `response` as needed
                print("OTP Response: \(response)")
            case .failure(let error):
                print("Error sending OTP: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
```


# SDK Methods

We provide methods, which helps you integrate the OTP verification within your own user interface.

`getWidgetProcess` is an optional method, this will receive the widget configuration data.
<br>
<br>

There are three methods `sendOTP`, `retryOTP` and `verifyOTP` for the otp verification process.

You can call these methods as follow:

### `sendOTP`

The sendOTP method is used to send an OTP to an identifier. The identifier can be an email or mobile number (it must contain the country code without +).
<br>
You can call this method on a button press.
<br>
<br>

```jsx
let body: [String: Any] = [
    "identifier": "91**********"
]
        
OTPWidget.sendOTP(body: body) { result in
    switch result {
    case .success(let response):
        print("OTP Response: \(response)")
    case .failure(let error):
        print("Error: \(error.localizedDescription)")
    }
}
```
**or**
```jsx
let body: [String: Any] = [
    "identifier": "alpha_do@gmail.com"
]
        
OTPWidget.sendOTP(body: body) { result in
    switch result {
    case .success(let response):
        print("OTP Response: \(response)")
    case .failure(let error):
        print("Error: \(error.localizedDescription)")
    }
}
```

### `retryOTP`

The retryOTP method allows retrying the OTP on desired communication channel.
<br>
retryOTP method takes optional channel code for `'SMS-11'`, `'VOICE-4'`, `'EMAIL-3'`, `'WHATSAPP-12'` for retrying otp.

*Note:* If the widget uses the default configuration, don't pass the channel as argument.

```jsx
let retryBody: [String: Any] = [
    "reqId": "3463***************43931",
    "retryChannel":"11" // Retry channel code (here, SMS:11)
]

OTPWidget.retryOTP(body: retryBody) { result in
    switch result {
    case .success(let response):
        print("Retry Response:", response)
    case .failure(let error):
        print("Error:", error)
    }
}
```

### `verifyOTP`

The verifyOTP method is used to verify an OTP entered by the user.

```jsx
let verifyBody: [String: Any] = [
    "reqId": "3463***************43931",
    "otp":"****"
]

OTPWidget.verifyOTP(body: verifyBody) {result in
    switch result {
    case .success(let response):
        print("Verify Otp Response:", response)
    case .failure(let error):
        print("Error:", error)
    }    
}
```



<br>
<br>
<br>

## License

```
Copyright 2022 MSG91
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```@