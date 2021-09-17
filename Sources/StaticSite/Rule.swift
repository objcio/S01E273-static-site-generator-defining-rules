//
//  File.swift
//  
//
//  Created by Chris Eidhof on 16.09.21.
//

import Foundation

protocol Rule {
    associatedtype Body: Rule
    var body: Body { get }
}

protocol BuiltinRule {
    func run()
}

extension BuiltinRule {
    var body: Never {
        fatalError()
    }
}

extension Never: Rule {
    var body: Never {
        fatalError()
    }
}

import Swim

struct Write: BuiltinRule, Rule {
    var contents: Node
    var to: String // relative path
    
    func run() {
        print("\(contents) — filename: \(to)")
    }
}

struct AnyBuiltinRule: BuiltinRule {
    let _run: () -> ()
    init<R: Rule>(_ rule: R) {
        if let builtin = rule as? BuiltinRule {
            self._run = builtin.run
        } else {
            self._run = { AnyBuiltinRule(rule.body).run() }
        }
    }
    
    func run() {
        _run()
    }
}

extension Rule {
    func execute() {
        AnyBuiltinRule(self).run()
    }
}
