//
//  TrackerTests.swift
//  TrackerTests
//
//  Created by Aleksandr Dugaev on 01.03.2025.
//

import XCTest
import SnapshotTesting
@testable import Tracker

final class TrackerTests: XCTestCase {
    
    func testViewController() throws {
        let vc = TrackersViewController()
        
        assertSnapshots(matching: vc, as: [
            .image(traits: .init(userInterfaceStyle: .dark)),
            .image(traits: .init(userInterfaceStyle: .light))
        ])
    }
}
