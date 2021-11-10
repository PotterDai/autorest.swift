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

struct CoreDataRelationshipViewModel {
    let entity: String
    let name: String
    let isOptional: String
    let isArray: Bool
    let deletionRule: String
    let destination: String
    let inverseName: String
    let inverseEntity: String

    init(model: ObjectViewModel, property: PropertyViewModel, isInverse: Bool) {
        entity = isInverse ? (property.isGroupType ? property.elementClassName! : property.className) : model.name
        name = isInverse ? "inverse\(model.name.capitalized)\(property.name.capitalized)" : "\(property.name)"
        isOptional = (property.optional && !property.isGroupType) ? "YES" : "NO"
        isArray = property.isGroupType
        deletionRule = isInverse ? "Nullify" : "Cascade"
        destination = isInverse ? model.name : (property.isGroupType ? property.elementClassName! : property.className)
        inverseName = isInverse ? "\(property.name)" : "inverse\(model.name.capitalized)\(property.name.capitalized)"
        inverseEntity = isInverse ? model.name : (property.isGroupType ? property.elementClassName! : property.className)
    }

    init(toInverseRelationship: CoreDataRelationshipViewModel) {
        entity = toInverseRelationship.inverseEntity
        name = toInverseRelationship.inverseName
        isOptional = toInverseRelationship.isOptional
        isArray = false
        deletionRule = "Nullify"
        destination = toInverseRelationship.entity
        inverseName = toInverseRelationship.name
        inverseEntity = toInverseRelationship.entity
    }
}
