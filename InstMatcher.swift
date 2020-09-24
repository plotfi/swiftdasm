import Foundation

struct InstructionPattern {
  let Prefix: String
  let Mask: UInt64
  let Match: UInt64
  let Decode: (Encoding) -> Instruction?
}

struct GroupPattern {
  let GroupName: String
  let Mask: UInt64
  let Match: UInt64
  let InstructionPatterns: [InstructionPattern]
}

func matchEncoding(Pattern: InstructionPattern, Encoding: Encoding) -> Bool {
  if (Encoding.Encodings[0] & ~Pattern.Mask) == Pattern.Match {
    print(String(format: "Masked:   %X", (Pattern.Mask)))
    print(String(format: "Encoding: %X", (Encoding.Encodings[0])))
    print(String(format: "Masked Encoding: %X", (Encoding.Encodings[0] & ~Pattern.Mask)))

    return true
  }

  return false
}

func matchEncodings(Encodings: [String]) {
  for encodingStr in Encodings {
    if let encoding = parse(encodingStr: encodingStr) {
      for pattern in AArch64Patterns {

        if (encoding.Encodings[0] & ~pattern.Mask) != pattern.Match {
          continue
        }

        print("MATCH Group: \(pattern.GroupName)")
        for IP in pattern.InstructionPatterns {
          if !matchEncoding(Pattern: IP, Encoding: encoding) {
            continue
          }

          if let I = IP.Decode(encoding) {
            print("\t\(I.Opcode)")
          }
        }
      }
    }
  }
}

func runTests() {
  matchEncodings(Encodings: tests)
}

func runLoop() {
  while true {
    if let line = readLine(strippingNewline: true) {
      matchEncodings(Encodings: [line])
    }
  }
}
