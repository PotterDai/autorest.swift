// --------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for
// license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.
// --------------------------------------------------------------------------

import AzureCore
import Foundation
// swiftlint:disable superfluous_disable_command
// swiftlint:disable identifier_name
// swiftlint:disable line_length
// swiftlint:disable cyclomatic_complexity

public struct BaseError: Codable, Swift.Error {
    // MARK: Properties

    public let someBaseProp: String?

    // MARK: Initializers

    /// Initialize a `BaseError` structure.
    /// - Parameters:
    ///   - someBaseProp:
    public init(
        someBaseProp: String? = nil
    ) {
        self.someBaseProp = someBaseProp
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case someBaseProp = "someBaseProp"
    }

    /// Initialize a `BaseError` structure from decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.someBaseProp = try? container.decode(String.self, forKey: .someBaseProp)
    }

    /// Encode a `BaseError` structure
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if someBaseProp != nil { try? container.encode(someBaseProp, forKey: .someBaseProp) }
    }
}
