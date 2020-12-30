//
//  Copyright © 2020 Puyan Lotfi. All rights reserved.
//
// Apache License v2.0 License.
// https://github.com/plotfi/swiftdasm/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0
//
// parseEncoding.swift
// For now, we are not decoding raw bits out of a __text section from an ELF or
// Mach-O file. We are parsing the byte arrays for instruction encodings printed
// out of llvm tools like llvm-mc or llc when passing -show-encoding or
// -show-mc-encoding.
//

import Foundation

func parse(_ Encoding: String) -> InstructionEncoding? {

  let revEncodingSplit = String(
    { (encoding: String) -> String in
      if let range = encoding.range(of: "encoding: ") {
        return String(encoding[range.upperBound...])
      } else {
        return encoding
      }
    }(Encoding)
    .replacingOccurrences(of: "[", with: ",")
    .replacingOccurrences(of: "]", with: " ")
    .reversed()
  )
  .trimmingCharacters(in: .whitespaces)
  .replacingOccurrences(of: " ", with: "")
  .replacingOccurrences(of: "x0", with: "")
  .split(separator: ",")

  let totalBits = revEncodingSplit.map({ $0.count }).reduce(0, +) * 4
  if totalBits != 32 || revEncodingSplit.count != 4 {
    return nil
  }

  var encoding: UInt64 = 0x0
  for nibbleStr in revEncodingSplit {
    if let nibble =
      UInt64(String(nibbleStr.split(separator: "x")[0].reversed()), radix: 16)
    {
      encoding = (encoding << 8) | nibble
      continue
    }

    return nil
  }

  return InstructionEncoding(Encodings: [encoding])
}

func parse(Encodings: [String]) -> [InstructionEncoding] {
  var Result = [InstructionEncoding]()

  for Encoding in Encodings {
    print("\n\n=================================")
    print("Parsing encoding string: \(Encoding)")
    if let IE = parse(Encoding) {
      Result.append(IE)
    }
  }

  return Result
}