import Foundation

let AArch64Patterns = [
  // InstructionPattern(Prefix: "UDF", Mask: 0xE1FFFFFF, Match: 0x0, Decode: udfDecode),
  
  InstructionPattern(Prefix: "FALLBACK_ADDSUBIMM_WTAGS",
                     Mask: 0xE3FFFFFF, Match: 0x10000000, Decode: dpDecode),
  
  InstructionPattern(Prefix: "FALLBACK_PCRel",
                     Mask: 0xE0FFFFFF, Match: 0x10000000, Decode: pcrelDecode),
  InstructionPattern(Prefix: "FALLBACK_DATAPROC",
                     Mask: 0xE3FFFFFF, Match: 0x10000000, Decode: dpDecode)
]
