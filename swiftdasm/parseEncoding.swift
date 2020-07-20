import Foundation

struct Encoding {
  var Encodings : [uint64];
}

struct Instruction {
  var Opcode: String
}

func parse(encodingStr: String) -> Encoding {
  var mutableEncodingStr = encodingStr
  
  let label = "encoding: "
  if mutableEncodingStr.contains(label) {
    let cstr = mutableEncodingStr.cString(using: .ascii)
    let trim = strstr(cstr, label)
    let clip = trim! + strlen(label)
    mutableEncodingStr = String(cString: clip)
  }
    
  mutableEncodingStr = String(mutableEncodingStr.reversed())
  mutableEncodingStr = mutableEncodingStr.replacingOccurrences(of: "[", with: " ")
  mutableEncodingStr = mutableEncodingStr.replacingOccurrences(of: "]", with: " ")
  
  let revEncodingSplit = mutableEncodingStr.split(separator: ",")
  assert(revEncodingSplit.count <= 8, "Expected encoding string no larger than 64-bits")

  var encoding: uint64 = 0x0
  for nibbleStr in revEncodingSplit {
    let nibbleArray = nibbleStr.trimmingCharacters(in: .whitespaces).split(separator: " ")
    let trimmed = nibbleArray.count > 0 ? nibbleArray[0] : ""
    
    if trimmed.count != 4 || !trimmed.hasSuffix("x0") {
      break
    }

    if let nibble = uint64(String(trimmed.split(separator: "x")[0].reversed()), radix: 16) {
      encoding = (encoding << 8) | nibble
      continue
    }

    assert(false, "Fail!")
  }
    
  return Encoding(Encodings: [encoding])
}
