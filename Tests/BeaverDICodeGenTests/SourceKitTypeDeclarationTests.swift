//
//  SourceKitTypeDeclarationTests.swift
//  BeaverDICodeGenTests
//
//  Created by Théophane Rupin on 2/22/18.
//

import Foundation
import XCTest

@testable import BeaverDICodeGen

final class SourceKitTypeDeclarationTests: XCTestCase {
    
    func testModelShouldBeValid() {

        let json = """
{
  "key.accessibility" : "source.lang.swift.accessibility.internal",
  "key.attributes" : [
    {
      "key.attribute" : "source.decl.attribute.final"
    }
  ],
  "key.bodylength" : 707,
  "key.bodyoffset" : 81,
  "key.kind" : "source.lang.swift.decl.class",
  "key.length" : 725,
  "key.name" : "MyService",
  "key.namelength" : 9,
  "key.nameoffset" : 70,
  "key.offset" : 64,
  "key.runtime_name" : "_TtC8__main__9MyService",
  "key.substructure" : []
}
"""
        let data = json.data(using: .utf8)!
        let model = try? JSONDecoder().decode(SourceKitTypeDeclaration.self, from: data)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.length, 725)
        XCTAssertEqual(model?.offset, 64)
        XCTAssertEqual(model?.name, "MyService")
    }
    
    func testModelShouldBeInvalidWhenKindIsNotSupported() {
        
        let json = """
{
  "key.accessibility" : "source.lang.swift.accessibility.internal",
  "key.attributes" : [
    {
      "key.attribute" : "source.decl.attribute.final"
    }
  ],
  "key.bodylength" : 707,
  "key.bodyoffset" : 81,
  "key.kind" : "unknown_kind",
  "key.length" : 725,
  "key.name" : "MyService",
  "key.namelength" : 9,
  "key.nameoffset" : 70,
  "key.offset" : 64,
  "key.runtime_name" : "_TtC8__main__9MyService",
  "key.substructure" : []
}
"""
        
        let data = json.data(using: .utf8)!
        do {
            _ = try JSONDecoder().decode(SourceKitTypeDeclaration.self, from: data)
        } catch {
            XCTAssertEqual(error as? SourceKitTypeDeclaration.Error, .unsupportedKind)
        }
    }
}
