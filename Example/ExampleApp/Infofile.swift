//
//  Infofile.swift
//  ExampleApp
//
//  Created by Derek Bronston on 5/8/21.
//  Copyright © 2021 Freshly. All rights reserved.
//

import SwiftInfoCore

// Use `FileUtils` to configure the path of your logs.
// If you're retrieving them with fastlane and don't know what the name of the log files are going to be,
// just run it once to have it create them.

FileUtils.buildLogFilePath = "./build/build_log/MyApp-MyConfig.log"
FileUtils.testLogFilePath = "./build/tests_log/MyApp-MyConfig.log"

// Now, create a `SwiftInfo` instance by passing your project's information.

let projectInfo = ProjectInfo(xcodeproj: "MyApp.xcodeproj",
                              target: "MyTarget",
                              configuration: "MyConfig")

let api = SwiftInfo(projectInfo: projectInfo)

// Use SwiftInfo's `extract()` method to extract and append all the information you want into a single property.

let output = api.extract(IPASizeProvider.self) +
             api.extract(WarningCountProvider.self) +
             api.extract(TestCountProvider.self) +
             api.extract(TargetCountProvider.self, args: .init(mode: .complainOnRemovals)) +
             api.extract(CodeCoverageProvider.self, args: .init(targets: ["NetworkModule", "MyApp"])) +
             api.extract(LinesOfCodeProvider.self, args: .init(targets: ["NetworkModule", "MyApp"]))

// Lastly, process the output.

if isInPullRequestMode {
    // If called from danger-SwiftInfo, print the results to the pull request
    api.print(output: output)
} else {
    // If called manually, send the results to Slack...
    api.sendToSlack(output: output, webhookUrl: url)
    // ...and save the output to your repo so it serves as the basis for new comparisons.
    api.save(output: output)
}
