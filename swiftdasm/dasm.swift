import Foundation

func udfDecode(Encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "UDF")
}

func pcrelDecode(Encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "FALLBACK_PCRel")
}

func dpDecode(Encoding: Encoding) -> Instruction? {
  return Instruction(Opcode: "FALLBACK_DATAPROC")
}
