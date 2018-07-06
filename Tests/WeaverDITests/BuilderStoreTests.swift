//
//  BuilderStoreTests.swift
//  WeaverTests
//
//  Created by Théophane Rupin on 2/21/18.
//

import Foundation
import XCTest

@testable import WeaverDI

final class BuilderStoreTests: XCTestCase {

    var rootBuilderStore: BuilderStore!
    var parentBuilderStore: BuilderStore!
    var childBuilderStore: BuilderStore!
    
    let builderKey = BuilderKey(for: String.self, name: "test")
    
    func rootBuilder(_: Void) -> String {
        return "root_builder"
    }
    
    func parentBuilder(_: Void) -> String {
        return "parent_builder"
    }
    
    func childBuilder(_: Void) -> String {
        return "child_builder"
    }
    
    override func setUp() {
        super.setUp()
        
        rootBuilderStore = BuilderStore()
        
        parentBuilderStore = BuilderStore()
        parentBuilderStore.parent = rootBuilderStore
        
        childBuilderStore = BuilderStore()
        childBuilderStore.parent = parentBuilderStore
    }
    
    override func tearDown() {
        defer { super.tearDown() }
        
        rootBuilderStore = nil
        parentBuilderStore = nil
        childBuilderStore = nil
    }
    
    // MARK: - Set / Get through hierarchy
    
    func test_set_then_get_should_retrieve_the_builder_registered_in_the_child_first() {
        
        rootBuilderStore.set(scope: .container, for: builderKey) { self.rootBuilder($0()) }
        parentBuilderStore.set(scope: .container, for: builderKey) { self.parentBuilder($0()) }
        childBuilderStore.set(scope: .container, for: builderKey) { self.childBuilder($0()) }
        
        let builder: Builder<String, Void>? = childBuilderStore.get(for: builderKey)
        
        XCTAssertEqual(builder?.make()({()}), "child_builder")
    }
    
    func test_set_then_get_should_retrieve_the_builder_registered_in_the_parent_when_its_child_has_not_it_set() {

        rootBuilderStore.set(scope: .container, for: builderKey) { self.rootBuilder($0()) }
        parentBuilderStore.set(scope: .container, for: builderKey) { self.parentBuilder($0()) }

        let builder: Builder<String, Void>? = childBuilderStore.get(for: builderKey)

        XCTAssertEqual(builder?.make()({()}), "parent_builder")
    }

    func test_set_then_get_should_retrieve_the_builder_registered_in_the_root_when_no_child_has_it_set_and_the_builder_is_not_shared_with_children() {

        rootBuilderStore.set(scope: .graph, for: builderKey) { self.rootBuilder($0()) }

        let builder: Builder<String, Void>? = childBuilderStore.get(for: builderKey)

        XCTAssertNil(builder)
    }

    func test_set_then_get_should_retrieve_the_builder_registered_in_the_root_when_the_child_has_not_it_set_and_the_parent_has_it_set_but_not_shared_with_children() {

        rootBuilderStore.set(scope: .container, for: builderKey) { self.rootBuilder($0()) }
        parentBuilderStore.set(scope: .graph, for: builderKey) { self.parentBuilder($0()) }

        let builder: Builder<String, Void>? = childBuilderStore.get(for: builderKey)

        XCTAssertEqual(builder?.make()({()}), "root_builder")
    }
}