import Foundation

while true {
  if let line = readLine(strippingNewline: true) {
    let encoding = parse(encodingStr: line)
    for pattern in AArch64Patterns {
      if (matchEncoding(Pattern: pattern, Encoding: encoding)) {
        print("MATCH!")
        if let I = pattern.Decode(encoding) {
          print(I.Opcode)
        }
        break
      }
    }
  }
}

// matchEncoding(Pattern: dp, Encoding: parse(encodingStr: "; encoding: [0xff,0x43,0x00,0xd1]"))
