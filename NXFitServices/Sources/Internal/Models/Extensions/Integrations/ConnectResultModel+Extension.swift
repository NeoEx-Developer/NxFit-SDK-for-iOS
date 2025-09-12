//
//  ConnectResultModel+Extension.swift
//  NXFit
//
//  Created by IRC Developer on 2025-09-11.
//

import NXFitModels

extension ConnectResultModel {
    internal init(dto: ConnectIntegrationDto) {
        self.init(
            authorizeUrl: dto.authorizeUrl,
        )
    }
}
