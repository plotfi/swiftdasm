
LBB3_6:

// TODO: This is just to deal with poor parsing.
//       I want to keep this label in case this is run through llvm-mc
// CHECK: =================================
// CHECK: Parsing encoding string: LBB3_6:

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: DataProcessing - Immediate
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT: adr
// CHECK-NEXT: ========= End Encoding ==========
adrp x21, #6553600 // encoding: [0x15,0x32,0x00,0x90]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: DataProcessing - Immediate
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT: addSubImmWithTag
// CHECK-NEXT: ========= End Encoding ==========
addg x0, x0, #1008, #7 // encoding: [0x00,0x1c,0xbf,0x91]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: DataProcessing - Immediate
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT: addSubImm
// CHECK-NEXT: ========= End Encoding ==========
adds x8, x0, #1 // encoding: [0x08,0x04,0x00,0xb1]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: DataProcessing - Immediate
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT: logicImm
// CHECK-NEXT: ========= End Encoding ==========
eor w0, w8, #0x7fff00 // encoding: [0x00,0x39,0x18,0x52]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: DataProcessing - Immediate
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT: movImm
// CHECK-NEXT: ========= End Encoding ==========
movk x0, #45055, lsl #48 // encoding: [0xe0,0xff,0xf5,0xf2]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: DataProcessing - Immediate
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT: logicImm
// CHECK-NEXT: ========= End Encoding ==========
mov x0, #1152921435887370240 // encoding: [0xe0,0x5f,0x5c,0xb2]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: DataProcessing - Immediate
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT: bitField
// CHECK-NEXT: ========= End Encoding ==========
ubfiz x29, x30, #1, #1 // encoding: [0xdd,0x03,0x7f,0xd3]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: Branches, Exception Generating and System instructions
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT: B.cond
// CHECK-NEXT: ========= End Encoding ==========
b.eq LBB3_6 // encoding: [0x60,0xff,0xff,0x54]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: Branches, Exception Generating and System instructions
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT: exceptionGen
// CHECK-NEXT: ========= End Encoding ==========
svc #0xa // encoding: [0x41,0x01,0x00,0xd4]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: Branches, Exception Generating and System instructions
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT: hint
// CHECK-NEXT: ========= End Encoding ==========
nop // encoding: [0x1f,0x20,0x03,0xd5]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: Branches, Exception Generating and System instructions
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT: barrier
// CHECK-NEXT: ========= End Encoding ==========
clrex // encoding: [0x5f,0x3f,0x03,0xd5]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: Branches, Exception Generating and System instructions
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT: pstate
// CHECK-NEXT: ========= End Encoding ==========
cfinv // encoding: [0x1f,0x40,0x00,0xd5]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: Branches, Exception Generating and System instructions
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT:         system
// CHECK-NEXT: ========= End Encoding ==========
sysl    x1, #0, c15, c15, #2    // encoding: [0x41,0xff,0x28,0xd5]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: Branches, Exception Generating and System instructions
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT:         sysregmov
// CHECK-NEXT: ========= End Encoding ==========
mrs     x0, AMEVCNTVOFF19_EL2   // encoding: [0x20,0xdb,0x3c,0xd5]


// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: Branches, Exception Generating and System instructions
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT:         uncondbr
// CHECK-NEXT: ========= End Encoding ==========
eret                                // encoding: [0xe0,0x03,0x9f,0xd6]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: Branches, Exception Generating and System instructions
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT:         uncondbrimm
// CHECK-NEXT: ========= End Encoding ==========
bl      #0                      // encoding: [0x00,0x00,0x00,0x94]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: Branches, Exception Generating and System instructions
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT:         compbrimm
// CHECK-NEXT: ========= End Encoding =========
cbz        w20, #1048572           ; encoding: [0xf4,0xff,0x7f,0x34]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: Branches, Exception Generating and System instructions
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT:         testbrimm
// CHECK-NEXT: ========= End Encoding ========
tbz        w3, #5, #32764          ; encoding: [0xe3,0xff,0x2b,0x36]

// CHECK: =================================
// CHECK-NEXT: Parsing encoding string:
// CHECK-NEXT: MATCH Group: Branches, Exception Generating and System instructions
// CHECK-NEXT: Masked:
// CHECK-NEXT: Encoding:
// CHECK-NEXT: Masked Encoding:
// CHECK-NEXT:         syswreg
// CHECK-NEXT: ========= End Encoding ==========
wfet    x17  // encoding: [0x11,0x10,0x03,0xd5]