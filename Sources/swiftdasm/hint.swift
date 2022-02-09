//
//  File.swift
//  
//
//  Created by Puyan Lotfi on 2/9/22.
//

import Foundation

enum HintCRmOp2: UInt32 {
  case NOP = 0x0
  case YIELD = 0x1
  case WFE = 0x2
  case WFI = 0x3
  case SEV = 0x4
  case SEVL = 0x5
  case DGH = 0x6 // FEAT_DGH
  // TODO: Ignore FEAT_PAuth for now.
  // TODO: Ignore FEAT_RAS, FEAT_SPE, FEAT_TRF
}

func ParseHint(_ Encoding: InstructionEncoding) -> Instruction? {
  let arm64Encoding : UInt32 = UInt32(Encoding.Encodings[0] & 0x0000_0000__FFFF_FFFF)
  
  let op2 = (arm64Encoding & 0xFFF) >> 5
  
  switch (op2) {
  case HintCRmOp2.NOP.rawValue:
    return Instruction(Encoding: Encoding, Opcode: "NOP")
  case HintCRmOp2.YIELD.rawValue:
    return Instruction(Encoding: Encoding, Opcode: "YIELD")
  default:
    return Instruction(Encoding: Encoding, Opcode: "hint2")
  }
}

