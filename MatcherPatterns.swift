import Foundation

let AArch64Patterns = [
  GroupPattern(GroupName: "DataProcessing",
              Mask: 0xE3FFFFFF, Match: 0x10000000,
              InstructionPatterns: [
                InstructionPattern(Prefix: "adr[p]",
                                   Mask: 0xE0FFFFFF, Match: 0x10000000,
                                   Decode: adrDecode),
                InstructionPattern(Prefix: "AddSubImmWithTags",
                                   Mask: 0xE07FFFFF, Match: 0x11800000, Decode: addSubImmWithTagDecode),
                InstructionPattern(Prefix: "AddSubImm",
                                   Mask: 0xE07FFFFF, Match: 0x11000000, Decode: addSubImmDecode),
                InstructionPattern(Prefix: "LogicImm",
                                   Mask: 0xE07FFFFF, Match: 0x12000000, Decode: logicImmDecode),
              ]
  )
]
