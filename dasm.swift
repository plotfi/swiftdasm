import Foundation

func udfDecode(Encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "UDF")
}

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

func fallbackDecode(encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "FALLBACK")
}
