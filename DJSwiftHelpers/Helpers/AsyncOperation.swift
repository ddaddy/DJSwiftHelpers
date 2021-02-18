//
//  Operation.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 18/02/2021.
//  Copyright © 2021 Dappological Ltd. All rights reserved.
//

import Foundation

/**
 An async `Operation`
 
 Subclass this to create your own async `Operation`.
 
 You must override `main()` as a minimum.
 
 [Thanks to SwiftLee](https://www.avanderlee.com/swift/asynchronous-operations/)
 */
public
class AsyncOperation: Operation {
    private let lockQueue = DispatchQueue(label: "com.djswifthelpers.asyncoperation", attributes: .concurrent)

    public override var isAsynchronous: Bool {
        return true
    }

    private var _isExecuting: Bool = false
    public override private(set) var isExecuting: Bool {
        get {
            return lockQueue.sync { () -> Bool in
                return _isExecuting
            }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            lockQueue.sync(flags: [.barrier]) {
                _isExecuting = newValue
            }
            didChangeValue(forKey: "isExecuting")
        }
    }

    private var _isFinished: Bool = false
    public override private(set) var isFinished: Bool {
        get {
            return lockQueue.sync { () -> Bool in
                return _isFinished
            }
        }
        set {
            willChangeValue(forKey: "isFinished")
            lockQueue.sync(flags: [.barrier]) {
                _isFinished = newValue
            }
            didChangeValue(forKey: "isFinished")
        }
    }

    public override func start() {
        
        guard !isCancelled else {
            finish()
            return
        }

        isFinished = false
        isExecuting = true
        main()
    }

    public override func main() {
        fatalError("Subclasses must implement `main` without overriding super.")
    }

    public func finish() {
        isExecuting = false
        isFinished = true
    }
}
