//
//  BaseSessionSampleDto.swift
//  fitstop
//
//  Created by Neo eX on 2022-09-28.
//

import Foundation

package class BaseSessionSampleDto : Decodable {
    package let timestamp: Date
    package let intervalInSeconds: Int
    package let activeTimeInSeconds: Int
    
    package init(timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.timestamp = timestamp
        self.intervalInSeconds = intervalInSeconds
        self.activeTimeInSeconds = activeTimeInSeconds
    }
}
