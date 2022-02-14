//
//  Created by Puyan Lotfi on 2/13/22.
//

import Foundation

func ParseDPImmediate(_ Encoding: InstructionEncoding) -> Instruction? {
  let arm64Encoding : UInt32 = UInt32(Encoding.Encodings[0] & 0x0000_0000__FFFF_FFFF)

  let sf = (0x8000_0000 & arm64Encoding) >> 31
  let op = (0x4000_0000 & arm64Encoding) >> 30
  let S  = (0x2000_0000 & arm64Encoding) >> 29

  let mnemonic = (op == 0x1 ? "SUB" : "ADD") + (S == 0x1 ? "S" : "")

  return Instruction(Encoding: Encoding, Opcode: mnemonic)
}
