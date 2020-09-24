//
//  tests.swift
//  swiftdasm
//
//  Created by Puyan Lotfi on 7/21/20.
//  Copyright © 2020 Puyan Lotfi. All rights reserved.
//

import Foundation

let tests = [
  // Data Processing -- Immediate
  "  adrp  x21, #6553600         ; encoding: [0x15,0x32,0x00,0x90]",
  "  addg  x0, x0, #1008, #7     ; encoding: [0x00,0x1c,0xbf,0x91]",
  // What is mte/memory taging?
  "  adds  x8, x0, #1            ; encoding: [0x08,0x04,0x00,0xb1]",
  "  eor  w0, w8, #0x7fff00      ; encoding: [0x00,0x39,0x18,0x52]",
  "  movk x0, #45055, lsl #48       ; encoding: [0xe0,0xff,0xf5,0xf2]",
  "  mov  x0, #1152921435887370240  ; encoding: [0xe0,0x5f,0x5c,0xb2]",
  "  ubfiz x29, x30, #1, #1         ; encoding: [0xdd,0x03,0x7f,0xd3]",
  // Branches, Exception Generating and System instructions
  "  b.eq    LBB3_6                 ; encoding: [0x60,0xff,0xff,0x54]",
]
