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

while let line = readLine(strippingNewline: true) {
  if line.starts(with: "//") || line.isEmpty {
    continue
  }

  match(Encodings: parse(Encodings: [line]))
}