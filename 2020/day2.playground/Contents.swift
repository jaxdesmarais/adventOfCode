import UIKit

let fileURL = Bundle.main.url(forResource: "passwordPolicy", withExtension: ".txt")
let passwordPolicyString = try String(contentsOf: fileURL!, encoding: .utf8)
let passwordPolicyArray = passwordPolicyString.components(separatedBy: .newlines)

struct PasswordPolicy {
    let min: Int
    let max: Int
    let char: Character
    let password: Substring
}

let lines = passwordPolicyString.split(separator: "\n")
let passwordPolicies = lines.map { line -> PasswordPolicy in
    let words = line.split(separator: " ")
    let range = words[0].split(separator: "-")
    return PasswordPolicy(min: Int(range[0])!,
                  max: Int(range[1])!,
                  char: words[1][words[1].startIndex],
                  password: words[2])
}

let validPasswordCount1 = passwordPolicies.reduce(0) { count, policy -> Int in
    let charCount = policy.password.reduce(0) { $1 == policy.char ? $0 + 1 : $0 }
    return (policy.min...policy.max).contains(charCount) ? count + 1 : count
}

print("First question answer: \(validPasswordCount1)")

let validPasswordCount2 = passwordPolicies.reduce(0) { count, policy -> Int in
    let minChar = policy.password[policy.password.index(policy.password.startIndex, offsetBy: policy.min - 1)]
    let maxChar = policy.password[policy.password.index(policy.password.startIndex, offsetBy: policy.max - 1)]
    return (minChar == policy.char) != (maxChar == policy.char) ? count + 1 : count
}

print("Second question answer: \(validPasswordCount2)")



