//
//  Ticker.swift
//  BankApp
//
//  Created by Amable A Aristy  on 7/1/24.
//

import Foundation

class TrieNode {
    var children: [Character: TrieNode] = [:]
    var isEndOfWord: Bool = false
}

class Trie {
    private let root = TrieNode()

    func insert(_ word: String) {
        var current = root
        for char in word {
            if current.children[char] == nil {
                current.children[char] = TrieNode()
            }
            current = current.children[char]!
        }
        current.isEndOfWord = true
    }

    func search(_ prefix: String) -> [String] {
        var current = root
        for char in prefix {
            guard let node = current.children[char] else {
                return []
            }
            current = node
        }
        return findWords(from: current, prefix: prefix)
    }

    private func findWords(from node: TrieNode, prefix: String) -> [String] {
        var results: [String] = []
        if node.isEndOfWord {
            results.append(prefix)
        }
        for (char, childNode) in node.children {
            results.append(contentsOf: findWords(from: childNode, prefix: prefix + String(char)))
        }
        return results
    }
}

func loadWords(from fileName: String) -> [String] {
    guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else { return [] }
    do {
        let content = try String(contentsOfFile: path)
        return content.components(separatedBy: .newlines).filter { !$0.isEmpty }
    } catch {
        print("Error loading words: \(error)")
        return []
    }
}
