import Foundation

struct Encoding {
  var Encodings: [UInt64]
}

struct Instruction {
  var Opcode: String
}

func parse(encodingStr: String) -> Encoding? {

  let revEncodingSplit = String(
    { (encoding: String) -> String in
      if let range = encoding.range(of: "encoding: ") {
        return String(encoding[range.upperBound...])
      } else {
        return encoding
      }
    }(encodingStr)
    .replacingOccurrences(of: "[", with: ",")
    .replacingOccurrences(of: "]", with: " ")
    .reversed()
  )
  .trimmingCharacters(in: .whitespaces)
  .replacingOccurrences(of: " ", with: "")
  .replacingOccurrences(of: "x0", with: "")
  .split(separator: ",")

  let totalBits = revEncodingSplit.map({ $0.count }).reduce(0, +) * 4
  if totalBits != 32 || revEncodingSplit.count != 4 {
    return nil
  }

  var encoding: UInt64 = 0x0
  for nibbleStr in revEncodingSplit {
    if let nibble =
      UInt64(String(nibbleStr.split(separator: "x")[0].reversed()), radix: 16)
    {
      encoding = (encoding << 8) | nibble
      continue
    }

    return nil
  }

  return Encoding(Encodings: [encoding])
}
