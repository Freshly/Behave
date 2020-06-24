# BEHAVE

![N|Solid](http://bytedissident.com/behave.png)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

**What is Behave**
**Behave** is a lightweight, flexible swift library designed to help iOS developers write simple BDD (UI Tests) that execute quickly.

**The premise is simple.**


**Sample Test**
The test below is included in our sample app. It tests a simple login flow:
``` swift
func testGivenTheUsersEntersCredsWhenTheUserTapsSubmitAndTheRequestSucceedsThenDisplayTheHomeScreen() {
        let expectations = expectation(description: "\(#function)")
        let api = Behaviour()
        api.listen(for: "login-view") {
            api.stubNetworkRequest(stub: Stub(httpMethod: HTTPMethods.post, httpResponse: 200, jsonReturn: "{\"success\":\"true\"}"))
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
**The anatomy of a behave test**
**Declare** an instance of **Behavior** in your **XCTestCase** file
```
let api = Behavior()
```
**Expectations**
Wrap your test in an Expectation.
```
func testMyBehavior() {
  let expectations = expectation(description: "Fulfill")
  // TEST CODE WILL LIVE HERE
  waitForExpectations(timeout: 3){ error in }
}
```
**listen():**
The listen method adds an event to your test queue and then listens for it to be triggered.
```
api.listen(for: "my-view") {
    // This completion handler gets called once the object has been detected
}
```
1. Behave, like XCUITest, relies on **accessibility identifiers**. You will need to add them in order to access elements in your code. They can be added in code directly or via Interface Builder.
2. Behave listens for events to complete. When an event completes you can either trigger an action or verify some state change.
3. When the event is triggered the completion handler will be called. Each event added to the test gets tested in the order it was added, **FIFO**. The events are triggered synchronously.

**Run():**
To make your test run use the run method. Behave tests will not run without explicitly calling run. The run method has a completion handler called finally. This is called when all of your events complete. If any event failed in the chain of events an error string is passed to the completion handler. The string is the identifier that was set for that event. You should fulfill your XCTest expectation in the finally completion handler.

```
  api.run(success: {
     expectations.fullfill()
  }, fail: { error in
    XCTFail(error)
    expectations.fullfill()
  })
```
# API:
```
query(identifier: String) -> UIView?
```
```
typeIntoTextField(identifier: String, text: String)
```
```
typeIntoSecureTextField(identifier: String, text: String)
```
```
tapRightNavigationItem(with object: Any? = nil, with additionalObject: Any? = nil)
```
```
tapBackButton()
```
```
tapButton(identifier: String)
```
```
selectTabOnTabBar(index: Int)
```
```
selectTableRow(identfier: String, indexPath: IndexPath)
```
```
scrollTableTo(indexPath: IndexPath, identfier: String)
```
```
selectCollectionItem(identfier: String, indexPath: IndexPath)
```
```
selectEmebeddedCollectionItem(parentView: UIView, identfier: String, indexPath:IndexPath)
```
```
alert(complete: @escaping () -> Void)
```
```
stubNetworkRequest(stub: Stub, httpResponse: Int32, jsonReturn: String)
```



