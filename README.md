# BEHAVE
![N|Solid](http://bytedissident.com/behave.png)

[![Build Status](https://www.travis-ci.com/Freshly/Behave.svg?branch=main)](https://www.travis-ci.com/Freshly/Behave)
![Cocoapods](https://img.shields.io/cocoapods/v/Behave)
![GitHub](https://img.shields.io/github/license/freshly/behave)
![Cocoapods platforms](https://img.shields.io/cocoapods/p/Behave)
![GitHub issues](https://img.shields.io/github/issues/freshly/behave?color=green)

[What is Behave](#what-is-behave)

[Installation](#installation)

[How to use Behave](#how-to-use-behave)
  - [Anatomy of a test](#the-anatomy-of-a-behave-test)
    - [Set Up](#set-up)
    - [Expectations](#expectations)
    - [Listen](#listen)
    - [Run](#run)
  - [Sample test](#sample-test)
  - [Stubbing network calls](#stubbing-network-calls)
  - [Performance Beta](#performance-beta)

[API](#api)
  - [Actions](#actions)
  - [Network](#network)
  - [Views](#views)

# What is Behave
**Behave** is a lightweight, flexible Swift library designed to help iOS developers write simple BDD (UI Tests) that execute quickly.

*Note: Included in the ExampleApp is a side by side comparison of a test written in XCTestUI vs. Behave*

**Behave Test:**
![N|Solid](https://user-images.githubusercontent.com/3665250/120073024-97255180-c064-11eb-89e3-549b1da53b96.png)

**XCUI Test:**
![N|Solid](https://user-images.githubusercontent.com/3665250/120073050-c340d280-c064-11eb-9e66-6a6dc28823ba.png)

# Installation
### CocoaPods
CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Behave into your Xcode project using CocoaPods, specify it in your Podfile:
```
pod 'Behave'
```

# How to use Behave

### The Anatomy of a Behave Test

#### Set Up
**Declare** an instance of **Behaviour** in your **XCTestCase** file
``` swift
let api = Behaviour()
```
#### Expectations

Wrap your test in an Expectation. *Use the **testTimeInterval** value for your timeout value*
``` swift
func testMyBehavior() {
  let expectations = expectation(description: "Fulfill")
  let api = Behaviour()
  // TEST CODE WILL LIVE HERE
  waitForExpectations(timeout: api.testTimeInterval){ error in }
}
```
#### Listen
The listen method adds an event to your test queue and then listens for it to be triggered.
``` swift
api.listen(for: "my-view") {
    // In this example the completion handler will be called when the view controller below is loaded
}
```

``` swift
override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "my-view"
    }
```

1. Behave, like XCUITest, relies on **accessibility identifiers**. You will need to add them in order to access elements in your code. They can be added in code directly or via Interface Builder.
2. Behave listens for events to complete. When an event completes you can either trigger an action or verify some state change.
3. When the event is triggered the completion handler will be called. Each event added to the test gets tested in the order it was added, **FIFO**. The events are triggered synchronously.

#### Run
To make your test run use the run method. Behave tests will not run without explicitly calling run. Run has: **success**, **fail** and **warn** completion handlers. 
- **success** This will get triggered upon completion of a successful run.
- **fail** This will get triggered if any of your events are not triggered. Behave will pass back the identifier in question so you can identify the issue.
- **warn** If you are running performance tests ( *testPerformance* property set to *true* ) and any frames get rendered at less than 60fps **Behave** will return a list of events tied to the slow frame rendering to make it easier for a developer to investigate UI issues.
``` swift
  api.run(success: {
    // RESET CUSTOM UI?
  }, fail: {error in
    XCTFail(error)
    expectations.fullfill()
  }, warn: { warnings in 
    print(warnings)
  })
```
***Note:***
Behave attempts to reset the UI between tests in order to ensure smooth testing. There are probably cases where this might not work. So you may need to do this manually in the completion handler of the run() method.
``` swift
  api.run(success: {
    // RESET CUSTOM UI?
  }, fail: {error in
    XCTFail(error)
    expectations.fullfill()
  }, warn: { warnings in 
    print(warnings)
  })
```


### Sample Test
The test below is included in our sample app. It tests a simple login flow:
``` swift
func testGivenTheUserEntersCredsWhenTheUserTapsSubmitAndTheRequestSucceedsThenDisplayTheHomeScreen() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        api.listen(for: "login-view") {
            api.stubNetworkRequest(stub: Stub(httpResponse: 200, jsonReturn: "{\"success\":\"true\"}", urlString: "https://somedomain.io"))
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

### Stubbing Network Calls
Behave is setup to do **Integration Tests**. There will most likely be cases where you will want to stub(fake) network requests. This can be done by passing a **Stub** into the **stubNetworkRequest** method in your test.

***Stub Type:***

``` swift
public struct Stub {
    public let httpResponse: Int32
    public let jsonReturn: String
    public let urlString: String

    public init(httpResponse: Int32, jsonReturn: String, urlString:String) {
        self.httpResponse = httpResponse
        self.jsonReturn = jsonReturn
        self.urlString = urlString
    }
}

```

***Example Network Stub:***

``` swift
  
  let api = Behaviour()

  api.listen(for: "login-view") {
    api.stubNetworkRequest(stub: Stub(httpResponse: 200, jsonReturn: "{\"success\":\"true\"}", urlString: "https://somedomain.io"))
    api.tapButton(identifier: "CTA")
  }

```

### Performance Beta
This is an experimental feature. The intention is to warn the developer about possible screen rendering issues. This feature is set by the **testPerformance** property. By default it is set to **true**. **Behave** will emit warnings when it detects frames being rendered under the 60fps threshold.

``` swift
  
  let api = Behaviour()

  api.run( warn: { warnings in 
    // A list of events tied to slow frame renders.
    /* 
      Example output: 
      Performing under 60fps: 
      [["performance-view": 0.04127258330117911], ["row-15": 0.07719787495443597]]
    */
  })

```

If you wish to turn off performance testing simply set the ***testPerformance*** property to false.


# API
``` swift
listen(for identifier: String, completion: @escaping () -> Void)
```

``` swift
run(success: (() -> Void)? = nil, fail: ((_ error: String) -> Void)? = nil)
```

### Actions
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
### Network
``` swift
stubNetworkRequest(stub: Stub, httpResponse: Int32, jsonReturn: String, urlString: String)
```

### Views
``` swift
query(identifier: String) -> UIView?
```
``` swift
findTable() -> UITableView?
```

``` swift
findButton(identifier: String) -> UIButton?
```
``` swift
wait(for identifier: String, parent: UIView, complete: @escaping () -> Void)
```
``` swift
wait(for identifier: String, complete: @escaping () -> Void, fail: @escaping (_ errorString: String) -> Void)
```

``` swift
wait(for cell: IndexPath, parent: UITableView, complete: @escaping (UITableViewCell?) -> Void)
```

``` swift
waitForAlert(complete: @escaping () -> Void)
```
 ###### Behave was developed at [Freshly](https://tech.freshly.com/) and is maintained by [Derek Bronston](https://github.com/bytedissident), [Denis  Efimov](https://github.com/denpef) and the Freshly iOS team.


