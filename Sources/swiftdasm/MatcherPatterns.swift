//
//  Copyright © 2020 Puyan Lotfi. All rights reserved.
//
// Apache License v2.0 License.
// https://github.com/plotfi/swiftdasm/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0
//
// MatcherPatterns.swift
// Used by InstMatcher.swift. This is a tree of instruction encoding groups and
// instruction bit patterns. Each pattern consists of a mask, an expected bit
// match (once the mask is applied), and decode function to call in the case where
// ~Mask == Match.
//

import Foundation

struct InstructionEncoding {
  var Encodings: [UInt64]
}

struct Instruction {
  var Encoding : InstructionEncoding
  var Opcode: String
}

struct InstructionPattern {
  let Mask: UInt64
  let Match: UInt64
  let Decode: (InstructionEncoding) -> Instruction?
}

struct GroupPattern {
  let GroupName: String
  let Mask: UInt64
  let Match: UInt64
  let InstructionPatterns: [InstructionPattern]
}

let AArch64Patterns = [
  GroupPattern(
    GroupName: "DataProcessing - Immediate",
    Mask: 0xE3FF_FFFF, Match: 0x1000_0000,
    InstructionPatterns: [
      InstructionPattern(Mask: 0xE0FF_FFFF, Match: 0x1000_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "adr") }),
      InstructionPattern(Mask: 0xE07F_FFFF, Match: 0x1180_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "addSubImmWithTag") }),
      InstructionPattern(Mask: 0xE07F_FFFF, Match: 0x1100_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "addSubImm") }),
      InstructionPattern(Mask: 0xE07F_FFFF, Match: 0x1200_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "logicImm") }),
      InstructionPattern(Mask: 0xE07F_FFFF, Match: 0x1280_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "movImm") }),
      InstructionPattern(Mask: 0xE07F_FFFF, Match: 0x1300_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "bitField") }),
      InstructionPattern(Mask: 0xE07F_FFFF, Match: 0x1380_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "extract") }),
    ]
  ),
  GroupPattern(
    GroupName: "Branches, Exception Generating and System instructions",
    Mask: 0xEBFF_FFFF, Match: 0x1400_0000,
    InstructionPatterns: [
      InstructionPattern(Mask: 0x2BFF_FFEF, Match: 0x5400_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "B.cond") }),
      InstructionPattern(Mask: 0x20FF_FFFF, Match: 0xD400_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "exceptionGen") }),
      InstructionPattern(Mask: 0x20FC_0FE0, Match: 0xD503_201F, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "hint") }),
      InstructionPattern(Mask: 0x20FC_0FFF, Match: 0xD503_3000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "barrier") }),
      InstructionPattern(Mask: 0x20FC_0FFF, Match: 0xD500_4000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "pstate") }),
      InstructionPattern(Mask: 0x20E7_FFFF, Match: 0xD508_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "system") }),
      InstructionPattern(Mask: 0x20E7_FFFF, Match: 0xD518_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "sysregmov") }),
      InstructionPattern(Mask: 0x28FF_FFFF, Match: 0xD600_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "uncondbr") }),
      InstructionPattern(Mask: 0xCBFF_FFFF, Match: 0x1400_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "uncondbrimm") }),
      InstructionPattern(Mask: 0xC9FF_FFFF, Match: 0x3400_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "compbrimm") }),
      InstructionPattern(Mask: 0xC9FF_FFFF, Match: 0x3600_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "testbrimm") }),
    ]
  ),
  GroupPattern(
    GroupName: "Load and Stores",
    Mask: 0xF5FF_FFFF, Match: 0x0800_0000,
    InstructionPatterns: [
      InstructionPattern(Mask: 0xF7FF_FFFF, Match: 0x0800_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstore") }),
    ]
  ),
]

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