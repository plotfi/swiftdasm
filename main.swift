//
//  Copyright © 2020 Puyan Lotfi. All rights reserved.
//
// Apache License v2.0 License.
// https://github.com/plotfi/swiftdasm/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0
//
// main.swift
// Runs tests and/or the dasm run loop.
//

import Foundation

@main
class SwiftDasm {
  static func main() {

    var RunTests = false
    for Arg in CommandLine.arguments {
      if Arg.lowercased() == "test" {
        RunTests = true
      }
    }

    if RunTests {
      runTests()
      return
    }

    runLoop()
  }
}
