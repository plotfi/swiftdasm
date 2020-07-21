import Foundation

struct Encoding {
  var Encodings : [uint64];
}

struct Instruction {
  var Opcode: String
}

func parse(encodingStr: String) -> Encoding {
  
  let revEncodingSplit = String(
  { (encoding: String) -> String in
    if let range = encoding.range(of: "encoding: ") {
      return String(encoding[range.upperBound...])
    } else {
      return encoding
    }
  }(encodingStr)
  .replacingOccurrences(of: "[", with: " ")
  .replacingOccurrences(of: "]", with: " ")
  .reversed())
  .split(separator: ",")

  assert(revEncodingSplit.count <= 8, "Expected encoding string no larger than 64-bits")

  var encoding: uint64 = 0x0
  for nibbleStr in revEncodingSplit {
    let nibbleArray = nibbleStr.trimmingCharacters(in: .whitespaces).split(separator: " ")
    
    if nibbleArray.count < 1 || nibbleArray[0].count != 4 || !nibbleArray[0].hasSuffix("x0") {
      break
    }

    if let nibble = uint64(String(nibbleArray[0].split(separator: "x")[0].reversed()), radix: 16) {
      encoding = (encoding << 8) | nibble
      continue
    }

    assert(false, "Fail!")
  }
    
  return Encoding(Encodings: [encoding])
}
