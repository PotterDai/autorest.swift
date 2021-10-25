// --------------------------------------------------------------------------
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//
// The MIT License (MIT)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the ""Software""), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
//
// --------------------------------------------------------------------------

import Foundation

struct CoreDataPropertyViewModel {
    let name: String
    let className: String
    let isOptional: String
    let attributeType: String

    init(property: PropertyViewModel) {
        if property.isEnumType {
            name = property.name
            className = "String"
            isOptional = property.optional ? "YES" : "NO"
            attributeType = AutorestSwift.attributeType(ofType: property.isGroupType ? "[]" : "String")
        } else if property.isDateType {
            name = property.name
            className = "Date"
            isOptional = property.optional ? "YES" : "NO"
            attributeType = AutorestSwift.attributeType(ofType: property.isGroupType ? "[]" : "Date")
        } else {
            name = property.name
            className = property.className
            isOptional = property.optional ? "YES" : "NO"
            attributeType = AutorestSwift.attributeType(ofType: property.isGroupType ? "[]" : property.className)
        }
    }
}

private func attributeType(ofType type: String) -> String {
    if type == "String" {
        return "String"
    } else if type == "Bool" {
        return "Boolean"
    } else if type == "Int" {
        return "Integer 64"
    } else if type == "Int64" {
        return "Integer 64"
    } else if type == "Int32" {
        return "Integer 32"
    } else if type == "Int16" {
        return "Integer 16"
    } else if type == "Double" {
        return "Double"
    } else if type == "Decimal" {
        return "Decimal"
    } else if type.starts(with: "Float") {
        return "Float"
    } else if type == "Data" {
        return "Binary"
    } else if type == "Date" {
        return "Date"
    } else if type == "UUID" {
        return "UUID"
    } else if type == "URL" {
        return "URI"
    } else if type.starts(with: "[") {
        return "Transformable"
    } else {
        fatalError(
            "Cannot resolve CoreData attribute type for \"\(String(describing: type))\""
        )
    }
}
