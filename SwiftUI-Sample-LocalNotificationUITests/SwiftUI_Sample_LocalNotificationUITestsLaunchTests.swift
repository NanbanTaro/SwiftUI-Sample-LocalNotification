//
//  SwiftUI_Sample_LocalNotificationUITestsLaunchTests.swift
//  SwiftUI-Sample-LocalNotification
//
//  Created by NanbanTaro on 2024/09/16.
//  
//

import XCTest

final class SwiftUI_Sample_LocalNotificationUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
