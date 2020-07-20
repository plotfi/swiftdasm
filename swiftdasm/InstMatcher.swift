import Foundation


struct InstructionPattern {
  let Prefix: String
  let Mask: uint64
  let Match: uint64
  let Decode: (Encoding) -> Instruction?
}

func matchEncoding(Pattern: InstructionPattern, Encoding: Encoding) -> Bool {
  if (Encoding.Encodings[0] & ~Pattern.Mask) == Pattern.Match {
    return true
  }
  
  return false
}
