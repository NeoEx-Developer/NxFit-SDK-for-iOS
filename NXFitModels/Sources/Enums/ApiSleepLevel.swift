//
//  ApiSleepLevel.swift
//  NXFit
//
//  Created by IRC Developer on 2025-11-19.
//

public enum ApiSleepLevel : Int, Codable {
    case awake = 1,
         rem = 2,
         light = 3,
         deep = 4
}
