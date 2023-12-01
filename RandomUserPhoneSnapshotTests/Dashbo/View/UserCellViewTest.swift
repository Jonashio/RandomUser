//
//  UserCellViewTest.swift
//  RandomUserPhoneSnapshotTests
//
//  Created by Jonashio on 1/12/23.
//

import XCTest
@testable import RandomUserPhone
import SwiftUI
import SnapshotTesting

final class UserCellViewTest: XCTestCase {
    func test_load_view() {
        let userCellView  = UserCellView(user: .fakeItem(), namespace: Namespace().wrappedValue, action: {}).frame(width: 350, height: 80)
        let view: UIView = UIHostingController(rootView: userCellView).view
        
        assertSnapshot(matching: view, as: .image(size: view.intrinsicContentSize), record: true)
    }
}
