//
//  Bundle+Utils.swift
//  MVPExample
//
//  Created by Pablo Dominé on 16/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation

extension Bundle {

    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }

    var displayName: String? {
        return infoDictionary?["CFBundleDisplayName"] as? String
    }

    var releaseVersionNumberPretty: String {
        return "\(displayName ?? "App") - v\(releaseVersionNumber ?? "Unknown") (\(buildVersionNumber ?? "Unknown"))"
    }
}
