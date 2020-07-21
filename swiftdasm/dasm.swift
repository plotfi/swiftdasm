import Foundation

func udfDecode(Encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "UDF")
}

func fallbackDecode(encoding: Encoding) -> Instruction? {
  for pattern in AArch64Patterns {
    if matchEncoding(Pattern: pattern, Encoding: encoding) {
      return Instruction(Opcode: pattern.Prefix)
    }
  }
  
  return nil
}
