//
//  UserSettings.swift
//  envobjects-playground
//
//  Created by George Sun on 5/12/20.
//  Copyright © 2020 Nextiles. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UserSettings: ObservableObject {
    @Published var score: Int = 0
}
