//
//  File.swift
//  
//
//  Created by Puyan Lotfi on 2/9/22.
//

import Foundation

func ParseAdr(_ Encoding: InstructionEncoding) -> Instruction? {
  let arm64Encoding : UInt32 = UInt32(Encoding.Encodings[0] & 0x0000_0000__FFFF_FFFF)

  
  let Op = (arm64Encoding & 0x8000_0000) >> 31
  
  return Instruction(Encoding: Encoding, Opcode: Op == 0x0 ? "ADR" : "ADRP")
}
