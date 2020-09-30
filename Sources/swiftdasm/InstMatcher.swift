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

struct InstructionPattern {
  let Prefix: String
  let Mask: UInt64
  let Match: UInt64
  let Decode: (Encoding) -> Instruction?
}

struct GroupPattern {
  let GroupName: String
  let Mask: UInt64
  let Match: UInt64
  let InstructionPatterns: [InstructionPattern]
}

func matchEncoding(Pattern: InstructionPattern, Encoding: Encoding) -> Bool {
  if (Encoding.Encodings[0] & ~Pattern.Mask) == Pattern.Match {
    print(String(format: "Masked:   %X", (Pattern.Mask)))
    print(String(format: "Encoding: %X", (Encoding.Encodings[0])))
    print(String(format: "Masked Encoding: %X", (Encoding.Encodings[0] & ~Pattern.Mask)))

    return true
  }

  return false
}

func matchEncodings(Encodings: [String]) {
  for encodingStr in Encodings {
    print("\n\n=================================")
    print("Parsing encoding string: \(encodingStr)")
    if let encoding = parse(encodingStr: encodingStr) {
      for pattern in AArch64Patterns {

        if (encoding.Encodings[0] & ~pattern.Mask) != pattern.Match {
          continue
        }

        print("MATCH Group: \(pattern.GroupName)")
        for IP in pattern.InstructionPatterns {
          if !matchEncoding(Pattern: IP, Encoding: encoding) {
            continue
          }

          if let I = IP.Decode(encoding) {
            print("\t\(I.Opcode)")
          }
        }
      }
    }
    print("========= End Encoding ==========")
  }
}

func runTests() {
  matchEncodings(Encodings: tests)
}

func runLoop() {
  while let line = readLine(strippingNewline: true) {
    if line.starts(with: "//") || line.isEmpty {
      continue
    }

    matchEncodings(Encodings: [line])
  }
}
