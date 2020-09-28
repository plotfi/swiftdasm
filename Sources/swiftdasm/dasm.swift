//
//  Copyright © 2020 Puyan Lotfi. All rights reserved.
//
// Apache License v2.0 License.
// https://github.com/plotfi/swiftdasm/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0
//
// dasm.swift
// This file contains decode functions that disassemble instructions for each
// AArch64 encoding group.
//

import Foundation

/// Undefined Instruction
func udfDecode(Encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "UDF")
}

/// Data Processing Immediate Instructions

func adrDecode(encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "adr")
}

func addSubImmWithTagDecode(encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "addSubImmWithTag")
}

func addSubImmDecode(encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "addSubImm")
}

func logicImmDecode(encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "logicImm")
}

func movImmDecode(encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "movImm")
}

func bitFieldDecode(encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "bitField")
}

func extractDecode(encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "extract")
}

/// Branches Exception Generating and System Instructions

func bcondDecode(encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "B.cond")
}

func exceptionGenDecode(encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "exceptionGen")
}

func hintDecode(encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "hint")
}

func barrierDecode(encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "barrier")
}

func pstateDecode(encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "pstate")
}
