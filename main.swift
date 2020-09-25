//
//  Copyright © 2020 Puyan Lotfi. All rights reserved.
//
// Apache License v2.0 License.
// https://github.com/plotfi/swiftdasm/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0
//
// main.swift
// Runs tests and the dasm run loop.
// TODO: Get @main working on Linux...
//

@main
class SwiftDasm {
  static func main() {
    runTests()
    runLoop()
  }
}
