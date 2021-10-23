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

import Stencil

public func renderTemplate(filename: String, dictionary: [String: Any]) throws -> String {
    let fsLoader = FileSystemLoader(bundle: [Bundle.main])
    let ext = Extension()
    // Register your filters and tags with the extension
    ext.registerFilter("optionalMark") { (value: Any?) in
        if let value = value as? Bool, value {
            return "?"
        }
        return ""
    }
    ext.registerFilter("decapitalize") { (value: Any?) in
        if let value = value as? String {
            return String(value.prefix(1).lowercased() + value.dropFirst())
        }
        return value
    }
    ext.registerFilter("slice") { (value: Any?, arguments: [Any?]) in
        guard arguments.count < 2 else {
            throw TemplateSyntaxError("'dropFirst' filter takes at most one argument")
        }
        let amount: Int = (arguments.first as? Int) ?? 0
        if let value = value as? String {
            if amount < 0 {
                return value.dropLast(-amount)
            } else {
                return value.dropFirst(amount)
            }
        }
        return value
    }
    let environment = Environment(loader: fsLoader, extensions: [ext], trimBehavior: TrimBehavior.smart)
    return try environment.renderTemplate(name: filename, context: dictionary)
}
