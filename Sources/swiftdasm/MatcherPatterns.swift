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

let AArch64Patterns = [
  GroupPattern(
    GroupName: "DataProcessing - Immediate",
    Mask: 0xE3FF_FFFF, Match: 0x1000_0000,
    InstructionPatterns: [
      InstructionPattern(
        Prefix: "adr[p]",
        Mask: 0xE0FF_FFFF, Match: 0x1000_0000,
        Decode: adrDecode),
      InstructionPattern(
        Prefix: "AddSubImmWithTags",
        Mask: 0xE07F_FFFF, Match: 0x1180_0000, Decode: addSubImmWithTagDecode),
      InstructionPattern(
        Prefix: "AddSubImm",
        Mask: 0xE07F_FFFF, Match: 0x1100_0000, Decode: addSubImmDecode),
      InstructionPattern(
        Prefix: "LogicImm",
        Mask: 0xE07F_FFFF, Match: 0x1200_0000, Decode: logicImmDecode),
      InstructionPattern(
        Prefix: "MoveImm",
        Mask: 0xE07F_FFFF, Match: 0x1280_0000, Decode: movImmDecode),
      InstructionPattern(
        Prefix: "Bitfield",
        Mask: 0xE07F_FFFF, Match: 0x1300_0000, Decode: bitFieldDecode),
      InstructionPattern(
        Prefix: "Extract",
        Mask: 0xE07F_FFFF, Match: 0x1380_0000, Decode: extractDecode),
    ]
  ),
  GroupPattern(
    GroupName: "Branches, Exception Generating and System instructions",
    Mask: 0xEBFF_FFFF, Match: 0x1400_0000,
    InstructionPatterns: [
      InstructionPattern(
        Prefix: "B.cond",
        Mask: 0x2BFF_FFEF, Match: 0x5400_0000, Decode: bcondDecode),
      InstructionPattern(
        Prefix: "exceptionGen",
        Mask: 0x2BFF_FFFF, Match: 0xD400_0000, Decode: exceptionGenDecode),
      InstructionPattern(
        Prefix: "hint",
        Mask: 0x2AFC_DFE0, Match: 0xD503_201F, Decode: hintDecode),
      InstructionPattern(
        Prefix: "barriers",
        Mask: 0x2AFC_CFFF, Match: 0xD503_3000, Decode: barrierDecode),
      InstructionPattern(
        Prefix: "pstate",
        Mask: 0x2AFC_CFFF, Match: 0xD503_3000, Decode: pstateDecode),
    ]
  ),
]
