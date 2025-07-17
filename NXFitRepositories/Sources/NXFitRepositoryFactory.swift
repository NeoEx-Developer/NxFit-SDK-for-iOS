//
//  NXFitReposFactory.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-06.
//

import Foundation
import NXFit

///  Factory for the NXFitRepositories SDK on iOS and watchOS.
///
///  The SDK must be built via the static ``NXFitRepositoryFactory/build(_:userId:)`` function.
///
///  ```
///  let repos = NXFitRepositoriesFactory.build(nxfitCore, someUserId)
///  ```
@available(iOS 16, watchOS 9, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
public class NXFitRepositoryFactory {
    private init() { }
    
    /// Static function to build the repository SDK via the passed parameters.
    /// - Parameters:
    ///   - nxfit: Instance of the Core SDK entry point
    ///   - userId: NXFit platform User ID.
    /// - Returns: A configured instance of the repository SDK.
    public static func build(_ nxfit: NXFit, userId: Int) -> NXFitRepository {
        return NXFitRepositoryService(nxfit, userId: userId)
    }
}
