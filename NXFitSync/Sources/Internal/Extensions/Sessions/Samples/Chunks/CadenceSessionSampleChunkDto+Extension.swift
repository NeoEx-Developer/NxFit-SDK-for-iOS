//
//  CadenceSessionSampleChunkDto+Extension.swift
//  NXFit
//
//  Created by IRC Developer on 2025-06-26.
//

import Foundation
import NXFitServices

extension CadenceSessionSampleChunkDto {
    internal convenience init(valuePerMinute: Int, dateInterval: DateInterval) {
        let startedOn = dateInterval.start
        let endedOn = dateInterval.duration > 0 ? dateInterval.end : nil
        
        self.init(valuePerMinute: valuePerMinute, startedOn: startedOn, endedOn: endedOn)
    }
}
