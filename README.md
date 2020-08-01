# BEHAVE
![N|Solid](http://bytedissident.com/behave.png)

[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/behave/blob/master/LICENSE)
[![Build Status](https://travis-ci.com/Freshly/Behave.svg?branch=master)](https://travis-ci.com/Freshly/Behave)

### What is Behave
**Behave** is a lightweight, flexible Swift library designed to help iOS developers write simple BDD (UI Tests) that execute quickly.

*Note: Included in the ExampleApp is a side by side comparison of a test written in XCTestUI vs. Behave*

# Installation:
### CocoaPods
CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Behave into your Xcode project using CocoaPods, specify it in your Podfile:
```
pod 'Behave', '~> 1.0'
```
**The anatomy of a behave test**
**Declare** an instance of **Behaviour** in your **XCTestCase** file
``` swift
let api = Behaviour()
```
**Expectations**
Wrap your test in an Expectation. *Use the **testTimeInterval** value for your timeout value*
``` swift
func testMyBehavior() {
  let expectations = expectation(description: "Fulfill")
  // TEST CODE WILL LIVE HERE
  let api = Behaviour()
  waitForExpectations(timeout: api.testTimeInterval){ error in }
}
```
**listen:**
The listen method adds an event to your test queue and then listens for it to be triggered.
``` swift
api.listen(for: "my-view") {
    // This completion handler gets called once the object has been detected
}
```
1. Behave, like XCUITest, relies on **accessibility identifiers**. You will need to add them in order to access elements in your code. They can be added in code directly or via Interface Builder.
2. Behave listens for events to complete. When an event completes you can either trigger an action or verify some state change.
3. When the event is triggered the completion handler will be called. Each event added to the test gets tested in the order it was added, **FIFO**. The events are triggered synchronously.

**Run:**
To make your test run use the run method. Behave tests will not run without explicitly calling run. Run has a *fail* completion handler, this will get triggered if any of your events are not triggered. Behave will pass back the identifier in question so you can identify the issue.
``` swift
  api.run(fail: { error in
    XCTFail(error)
    expectations.fullfill()
  })
```
**Sample Test**
The test below is included in our sample app. It tests a simple login flow:
``` swift
func testGivenTheUsersEntersCredsWhenTheUserTapsSubmitAndTheRequestSucceedsThenDisplayTheHomeScreen() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        api.listen(for: "login-view") {
            api.stubNetworkRequest(stub: Stub(httpResponse: 200, jsonReturn: "{\"success\":\"true\"}", urlString: URLS.login.rawValue))
            api.typeIntoTextField(identifier: "email", text: "email")
            api.typeIntoTextField(identifier: "password", text: "password")
            api.tapButton(identifier: "submit")
        }
        api.listen(for: "home-view") {
            expectations.fulfill()
        }
        api.run(fail: { error in
           XCTFail(error)
           expectations.fulfill()
        })
        waitForExpectations(timeout: api.testTimeInterval)
    }
```
# API:
``` swift
query(identifier: String) -> UIView?
```
``` swift
stubNetworkRequest(stub: Stub, httpResponse: Int32, jsonReturn: String, urlString: String)
```
``` swift
typeIntoTextField(identifier: String, text: String)
```
``` swift
typeIntoSecureTextField(identifier: String, text: String)
```
``` swift
tapRightNavigationItem(with object: Any? = nil, with additionalObject: Any? = nil)
```
``` swift
tapBackButton()
```
``` swift
tapButton(identifier: String)
```
``` swift
selectTabOnTabBar(index: Int)
```
``` swift
selectTableRow(identfier: String, indexPath: IndexPath)
```
``` swift
scrollTableTo(indexPath: IndexPath, identfier: String)
```
``` swift
selectCollectionItem(identfier: String, indexPath: IndexPath)
```
``` swift
selectEmebeddedCollectionItem(parentView: UIView, identfier: String, indexPath:IndexPath)
```
``` swift
waitForAlert(complete: @escaping () -> Void)
```

 ###### Behave was developed at [Freshly](https://tech.freshly.com/) and is maintained by [Derek Bronston](https://github.com/bytedissident), [Denis  Efimov](https://github.com/denpef) and the Freshly iOS team.


