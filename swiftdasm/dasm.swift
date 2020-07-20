import Foundation

func udfDecode(Encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "UDF")
}

func dpDecode(Encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "DP")
}
