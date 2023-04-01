//
//  Task.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 26/01/2022.
//  Copyright © 2022 Dappological Ltd. All rights reserved.
//

import Foundation

@available(macOS 10.15, iOS 13.0, watchOS 6.0, watchOSApplicationExtension 6.0, *)
public
extension Task where Failure == Error {
    
    /**
     Creates a recurring `Task` that executes until success
     - Parameters:
        - priority: TaskPriority
        - maxRetryCount: `Int` How many times to retry. Defaults to inifinity
        - retryDelay: Delay between retries
        - operation: The operation block to complete on each try
     - Returns: A `Task` that can be retained if you want to be able to cancel
     
     From within the `operation` block retturn the value you want access to on completion. The value can be accesses by reading `.value` from the `Task`
     ```
     let currentTask = Task.retrying(retryDelay: 5) {
         return try await someFunction()
     }
     let result = try? await currentTask.value
     ```
     */
    @discardableResult
    static func retrying(priority: TaskPriority? = nil, maxRetryCount: Int = .max, retryDelay: TimeInterval = 1, operation: @Sendable @escaping () async throws -> Success) -> Task {
        
        Task(priority: priority) {
            for _ in 0..<maxRetryCount - 1 {
                do {
                    return try await operation()
                } catch {
                    let oneSecond = TimeInterval(1_000_000_000)
                    let delay = UInt64(oneSecond * retryDelay)
                    try await Task<Never, Never>.sleep(nanoseconds: delay)
                    continue
                }
            }
            
            try Task<Never, Never>.checkCancellation()
            return try await operation()
        }
    }
}
