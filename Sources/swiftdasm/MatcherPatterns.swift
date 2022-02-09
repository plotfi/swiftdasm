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

// This is dumb for an arm64 dasm because everything is 32bit.
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
    GroupName: "Data Processing -- Immediate",
    Mask: 0xE3FF_FFFF, Match: 0x1000_0000,
    InstructionPatterns: [
      InstructionPattern(Mask: 0xE07F_FFFF, Match: 0x1000_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "adr") }),
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
      InstructionPattern(Mask: 0x01FF_FFEF, Match: 0x5400_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "B.cond") }),
      InstructionPattern(Mask: 0x00FF_FFFF, Match: 0xD400_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "exceptionGen") }),
      InstructionPattern(Mask: 0x0000_0FFF, Match: 0xD503_1000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "syswreg") }),
      InstructionPattern(Mask: 0x0000_0FE0, Match: 0xD503_201F, Decode: ParseHint),
      InstructionPattern(Mask: 0x0000_0FFF, Match: 0xD503_3000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "barrier") }),
      InstructionPattern(Mask: 0x0007_0FFF, Match: 0xD500_4000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "pstate") }),
      InstructionPattern(Mask: 0x0027_FFFF, Match: 0xD508_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "system") }),
      InstructionPattern(Mask: 0x002F_FFFF, Match: 0xD510_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "sysregmov") }),
      InstructionPattern(Mask: 0x01FF_FFFF, Match: 0xD600_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "uncondbr") }),
      InstructionPattern(Mask: 0x83FF_FFFF, Match: 0x1400_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "uncondbrimm") }),
      InstructionPattern(Mask: 0x81FF_FFFF, Match: 0x3400_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "compbrimm") }),
      InstructionPattern(Mask: 0x81FF_FFFF, Match: 0x3600_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "testbrimm") }),
    ]
  ),
  GroupPattern(
    GroupName: "Loads and Stores",
    Mask: 0xF5FF_FFFF, Match: 0x0800_0000,
    InstructionPatterns: [
      InstructionPattern(Mask: 0x4040_FFFF, Match: 0x0C00_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstoresimdmulti") }),
      InstructionPattern(Mask: 0x405F_FFFF, Match: 0x0C80_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstoresimdmultipost") }),
      InstructionPattern(Mask: 0x4060_FFFF, Match: 0x0D00_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstoresimdsingle") }),
      InstructionPattern(Mask: 0x407F_FFFF, Match: 0x0D80_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstoresimdsinglepost") }),
      InstructionPattern(Mask: 0x00DF_FFFF, Match: 0xD920_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstorememtags") }),
      InstructionPattern(Mask: 0xC0FF_FFFF, Match: 0x0800_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstoreexclusive") }),
      InstructionPattern(Mask: 0xC0DF_F3FF, Match: 0x1900_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "ldapr_stlr_unscaledimm") }),
      InstructionPattern(Mask: 0xC4FF_FFFF, Match: 0x1800_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadregliteral") }),
      InstructionPattern(Mask: 0xC47F_FFFF, Match: 0x2800_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstorepairnoalloc") }),
      InstructionPattern(Mask: 0xC47F_FFFF, Match: 0x2880_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstorepairregpost") }),
      InstructionPattern(Mask: 0xC47F_FFFF, Match: 0x2900_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstorepairregoffset") }),
      InstructionPattern(Mask: 0xC47F_FFFF, Match: 0x2980_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstorepairregpre") }),
      InstructionPattern(Mask: 0xC4DF_FFFF, Match: 0x3800_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstoreregunscaleimm") }),
      InstructionPattern(Mask: 0xC4DF_F3FF, Match: 0x3800_0400, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstoreregpostimm") }),
      InstructionPattern(Mask: 0xC4DF_F3FF, Match: 0x3800_0800, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstoreregunpriv") }),
      InstructionPattern(Mask: 0xC4DF_F3FF, Match: 0x3800_0C00, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstoreregimmpre") }),
      InstructionPattern(Mask: 0xC4DF_F3FF, Match: 0x3820_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "atomicmem") }),
      InstructionPattern(Mask: 0xC4DF_F3FF, Match: 0x3820_0800, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstoreregregoff") }),
      InstructionPattern(Mask: 0xC4DF_FBFF, Match: 0x3820_0400, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstoreregpac") }),
      InstructionPattern(Mask: 0xC4FF_FFFF, Match: 0x3900_0000, Decode: { Encoding in Instruction(Encoding: Encoding, Opcode: "loadstoreregunsignimm") }),
    ]
  ),
  GroupPattern(
    GroupName: "Data Processing -- Register",
    Mask: 0xF1FF_FFFF, Match: 0x0A00_0000,
    InstructionPatterns: [
    ]
  ),
  GroupPattern(
    GroupName: "Data Processing -- Scalar Floating-Point and Advanced SIMD",
    Mask: 0xF1FF_FFFF, Match: 0x0E00_0000,
    InstructionPatterns: [
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
    print("========= End Encoding ==========")
  }
}
