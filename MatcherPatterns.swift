import Foundation

let AArch64Patterns = [
  GroupPattern(
    GroupName: "DataProcessing",
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
    ]
  )
]
