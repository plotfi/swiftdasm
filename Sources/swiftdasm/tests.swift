//
//  Copyright © 2020 Puyan Lotfi. All rights reserved.
//
// Apache License v2.0 License.
// https://github.com/plotfi/swiftdasm/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0
//
//.test.swift
// This is a really lame set of encoding tests dumped out of the llvm assembler
// by running: `llvm-mc -triple=aarch64--  -o - -show-encoding`
//

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
  "  b.eq LBB3_6                  ; encoding: [0x60,0xff,0xff,0x54]",
  "  svc #0xa                     ; encoding: [0x41,0x01,0x00,0xd4]",
  "  nop                          ; encoding: [0x1f,0x20,0x03,0xd5]",
  "  clrex                        ; encoding: [0x5f,0x3f,0x03,0xd5]",
  "  cfinv                        ; encoding: [0x1f,0x40,0x00,0xd5]",

]
