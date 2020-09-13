cmake_minimum_required(VERSION 3.15.1)

project(swiftdasm LANGUAGES Swift)

add_executable(swiftdasm MatcherPatterns.swift main.swift tests.swift InstMatcher.swift dasm.swift parseEncoding.swift)
