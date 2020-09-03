//
//  URLHandler.swift
//  deeplink
//
//  Created by Mackey on 2020/08/31.
//  Copyright © 2020 Mackey. All rights reserved.
//

import UIKit
import Foundation

enum DeepLink {
    struct Components {
        let host: Host?
        let pathes: [Path]?
        let queries: [Query: String]?
    }
    
    enum Host: String {
        case route
    }
    
    enum Path: String {
        case present
        case push
    }
    
    enum Query: String {
        case title
    }
    
    static func parse(url: URL) -> Components? {
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        
        var host: Host?
        if let urlHost = components.host {
            host = Host(rawValue: urlHost)
        }
        
        var pathes: [Path]?
        if let urlPath = components.path {
            pathes = urlPath.split(separator: "/")
                .compactMap { Path(rawValue: String($0)) }
        }
        
        var queries: [Query: String]?
        if let queryItems = components.queryItems {
            queries = Dictionary(uniqueKeysWithValues: queryItems.compactMap { queryItem -> (Query, String)? in
                guard let query = Query(rawValue: queryItem.name), let value = queryItem.value else { return nil }
                return (query, value)
            })
        }
        
        return Components(host: host, pathes: pathes, queries: queries)
    }
}

class URLHandler {
    private(set) var stored: URL?
    private var canHandle: Bool = false
    
    @discardableResult
    func handle() -> Bool {
        canHandle = true
        
        guard let url = stored else {
            print("🚧 stored url to handle isn't exist")
            return false
        }
        return handle(url: url)
    }
    
    @discardableResult
    func handle(string: String) -> Bool {
        guard let url = URL(string: string) else { return false }
        return handle(url: url)
    }
    
    @discardableResult
    func handle(url: URL) -> Bool {
        print("🚀 travel to url: \(url.absoluteString)")
        
        var result: Bool = false
        defer { stored = result ? nil : url }
        
        guard canHandle else { return result }
        
        guard let components = DeepLink.parse(url: url), let host = components.host else { return result }
        
        switch host {
        case .route:
            result = handle(route: components)
        // Write down here any deeplink host cases...
        }
        
        return result
    }
    
    private func handle(route components: DeepLink.Components) -> Bool {
        guard let path = components.pathes?.first else { return false }
        
        guard let title = components.queries?[.title] else { return false }
        let viewController = MainViewController(urlController: self, title: title)
        
        switch path {
        case .present:
            UIViewController.topMostViewController?.present(viewController, animated: true, completion: nil)
        case .push:
            UIViewController.topMostViewController?.navigationController?.pushViewController(viewController, animated: true)
        }
        
        return true
    }
}
