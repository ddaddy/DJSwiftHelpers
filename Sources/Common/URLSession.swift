//
//  URLSession.swift
//  DJSwiftHelpers
//
//  Created by Darren Jones on 24/11/2020.
//  Copyright © 2020 Dappological Ltd. All rights reserved.
//

import Foundation

@available(iOS 10.3, *)
@available(watchOS 3.3, *)
public
extension URLSession {
    
    static var selfSignedSSLSession:URLSession = SelfSignedURLSession().session
    static func selfSignedSSLSession(config: URLSessionConfiguration) -> URLSession {
        return SelfSignedURLSession(config: config).session
    }
}

@available(iOS 10.3, *)
@available(watchOS 3.3, *)
fileprivate
class SelfSignedURLSession:NSObject, URLSessionDelegate {
    
    public var config: URLSessionConfiguration = .default
    
    init(config: URLSessionConfiguration = .default) {
        self.config = config
    }
    
    /**
     A URLSession that will bypass an SSL certificate check.
     
     WARNING!!
     Be careful where you use this! It can be dangerous.
     */
    var session:URLSession {
        return URLSession(configuration: config, delegate: self, delegateQueue: .main)
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard challenge.previousFailureCount == 0 else {
            challenge.sender?.cancel(challenge)
            // Inform the user that the user name and password are incorrect
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Within your authentication handler delegate method, you should check to see if the challenge protection space has an authentication type of NSURLAuthenticationMethodServerTrust
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
           challenge.protectionSpace.serverTrust != nil
        {
            let proposedCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, proposedCredential)
            return
        }
        
        completionHandler(.performDefaultHandling, nil)
    }
}

@available(iOS 10.3, *)
@available(watchOS 3.3, *)
@available(OSX 10.12.4, *)
fileprivate
extension SecTrust {

    var isSelfSigned: Bool? {
        guard SecTrustGetCertificateCount(self) == 1 else {
            return false
        }
        guard let cert = SecTrustGetCertificateAtIndex(self, 0) else {
            return nil
        }
        return cert.isSelfSigned
    }
}

@available(iOS 10.3, *)
@available(watchOS 3.3, *)
@available(OSX 10.12.4, *)
fileprivate
extension SecCertificate {

    var isSelfSigned: Bool? {
        guard
            let subject = SecCertificateCopyNormalizedSubjectSequence(self),
            let issuer = SecCertificateCopyNormalizedIssuerSequence(self)
        else {
            return nil
        }
        return subject == issuer
    }
}

