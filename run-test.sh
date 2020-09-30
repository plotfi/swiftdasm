#!/bin/bash

cat ./Tests/asm/arm64.s | ./.build/debug/swiftdasm | FileCheck-10 ./Tests/asm/arm64.s
