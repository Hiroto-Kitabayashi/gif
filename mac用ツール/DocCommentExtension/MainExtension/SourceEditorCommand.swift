//
//  SourceEditorCommand.swift
//  MainExtension
//
//  Created by hiroto-kitabayashi on 2018/03/14.
//  Copyright © 2018年 SCC. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        let textBuffer = invocation.buffer
        let lines = textBuffer.lines
        let selections = textBuffer.selections
        guard let selection = selections.firstObject as? XCSourceTextRange else {
            completionHandler(NSError(domain: "MainExtension", code: 401, userInfo: ["reason": "text not selected"]))
            return
        }
        /**
         
         - Author: 
         - Date: 2018/03/14
         - Remark: 
         */
        
        let line = selection.end.line
        let end = selection.end.column
        let format = DateFormatter()
        format.dateStyle = .medium
        format.locale = Locale(identifier: "ja_JP")
        let indentSpace = String(repeating: " ", count: end)
        lines.insert("\(indentSpace)/**\n" +
            "\(indentSpace) \n" +
            "\(indentSpace) - Author: \n" +
            "\(indentSpace) - Date: \(format.string(from: Date()))\n" +
            "\(indentSpace) - Remark: \n" +
            "\(indentSpace) */", at: line)
        
        completionHandler(nil)
    }
    
}
