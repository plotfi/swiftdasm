//
//  tests.swift
//  swiftdasm
//
//  Created by Puyan Lotfi on 7/21/20.
//  Copyright © 2020 Puyan Lotfi. All rights reserved.
//

import Foundation

let tests = [
  "  adrp  x21, #6553600         ; encoding: [0x15,0x32,0x00,0x90]",
  "  addg  x0, x0, #1008, #7     ; encoding: [0x00,0x1c,0xbf,0x91]",
  // What is mte/memory taging?
  "  adds  x8, x0, #1            ; encoding: [0x08,0x04,0x00,0xb1]",
  "  eor  w0, w8, #0x7fff00      ; encoding: [0x00,0x39,0x18,0x52]"
]
