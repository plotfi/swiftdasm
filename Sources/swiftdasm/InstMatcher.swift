//
//  Copyright © 2020 Puyan Lotfi. All rights reserved.
//
// Apache License v2.0 License.
// https://github.com/plotfi/swiftdasm/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0
//
// InstMatcher.swift
// Walks the encoding groups and instruction bit patterns. Once a matching
// pattern is found a proper decoder function in dasm.swift is called.
//

import Foundation

func match(_ Pattern: InstructionPattern, _ Encoding: InstructionEncoding) -> Bool {
  if (Encoding.Encodings[0] & ~Pattern.Mask) == Pattern.Match {
    print(String(format: "Masked:   %X", (Pattern.Mask)))
    print(String(format: "Encoding: %X", (Encoding.Encodings[0])))
    print(String(format: "Masked Encoding: %X", (Encoding.Encodings[0] & ~Pattern.Mask)))

    return true
  }

  return false
}

func match(Encodings: [InstructionEncoding]) {
  for Encoding in Encodings {
    for pattern in AArch64Patterns {

      if (Encoding.Encodings[0] & ~pattern.Mask) != pattern.Match {
        continue
      }

      print("MATCH Group: \(pattern.GroupName)")
      for Pattern in pattern.InstructionPatterns {
        if !match(Pattern, Encoding) {
          continue
        }

        if let I = Pattern.Decode(Encoding) {
          print("\t\(I.Opcode)")
        }
      }
    }
  }
}
