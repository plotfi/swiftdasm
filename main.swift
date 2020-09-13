import Foundation

matchEncodings(Encodings: tests)

while true {
  if let line = readLine(strippingNewline: true) {
    matchEncodings(Encodings: [line])
  }
}
