// REQUIRES: OS=macosx
// REQUIRES: swift_stdlib_no_asserts
// RUN: %empty-directory(%t.tmp)
// mkdir %t.tmp/module-cache && mkdir %t.tmp/dummy.sdk
// RUN: %api-digester -dump-sdk -module Swift -o %t.tmp/current-stdlib.json -module-cache-path %t.tmp/module-cache -sdk %t.tmp/dummy.sdk -abi -avoid-location
// RUN: %api-digester -diagnose-sdk -input-paths %S/Inputs/stdlib-stable-abi.json -input-paths %t.tmp/current-stdlib.json -abi -o %t.tmp/changes.txt -v
// RUN: %clang -E -P -x c %S/Outputs/stability-stdlib-abi.without.asserts.swift.expected -o - | sed '/^\s*$/d' | sort > %t.tmp/stability-stdlib-abi.swift.expected
// RUN: %clang -E -P -x c %t.tmp/changes.txt -o - | sed '/^\s*$/d' | sort > %t.tmp/changes.txt.tmp
// RUN: diff -u %t.tmp/stability-stdlib-abi.swift.expected %t.tmp/changes.txt.tmp

// The digester can incorrectly register a generic signature change when
// declarations are shuffled. rdar://problem/46618883
// UNSUPPORTED: swift_evolve
