//
//  ViewController.swift
//  Writing to a file
//
//  Created by Kyi Zar Theint on 9/5/17.
//  Copyright © 2017 Kyi Zar Theint. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        debugPrint("this is a debugprint")
        //////////NSLog format
        NSLog("%0.4f", CGFloat.pi)
        NSLog("%@", "Hi this is NSLog")
        //////////os_log format
        let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "network")
        os_log("this is os_log haha!", type: .default)
        os_log("%@", "kyi zar theint")
        os_log("%@",log: log,type: .debug, "meimeikyizar!")
        let bool = writeFile1(data: "its bull shit!!!!!!")
        print("////////\(bool)")
        
        //os_log(OS_LOG_DEFAULT, "This is a log message.")
        // Do any additional setup after loading the view, typically from a nib.
        let filename = "Text"
        let DocumentDirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = DocumentDirURL.appendingPathComponent(filename).appendingPathExtension("txt")
        let pathString = fileURL.path
        
        print("File Path: \(fileURL.path)")
        
        let writeString = "write this text to the file in swift"
        //add myself
        
        do{
            try writeString.write(toFile: pathString, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed to write to URL")
            print(error)
        }
        ///////////read file function
        
         var readString = ""
        do {
            readString = try String(contentsOf: fileURL)
        }
        catch let error as NSError {
            print("Failed to read file")
            print(error)
        }
        print("Contents of the file \(readString)")
    ////////////////////////
       /* let path = NSBundle.mainBundle().pathForResource("README", ofType: "txt")
        textView.text = String(contentsOfFile: path,
                               encoding: NSUTF8StringEncoding,
                               error: nil)*/
    let testing = Bundle.main.path(forResource: "hello", ofType: "txt")
        
       /* let writeString1 = "writing testt"
        do{
        try writeString1.write(toFile: testing!, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed to write to URL ")
            print(error)
        }*/
    var readString1 = ""
    
    do{
        readString1 = try String(contentsOfFile: testing!, encoding: String.Encoding.utf8)
    } catch let error as NSError {
    print("Failed to read from project!")
    print(error)
    }
    print("readString1 \(readString1)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func writeFile(data: String) -> Bool {
       let pathString1 = Bundle.main.path(forResource: "hello", ofType: "txt")
        var retVal = false
        do {
            try data.write(toFile: pathString1!, atomically: true, encoding: String.Encoding.utf8)
            retVal = true
        }catch let error as NSError {
            print("Error: \(error)")
        }
        print("pathString1 is \(pathString1!)")
        return retVal
    }
    func writeFile1(data: String) -> Bool {
        var retVal = false
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("votes.txt")
        
        if let outputStream = OutputStream(url: fileURL, append: true) {
            outputStream.open()
            let text = "some text\n"
            let bytesWritten = outputStream.write(text, maxLength: 12)
            retVal = true
            if bytesWritten < 0 { print("write failure") }
            outputStream.close()
            
        } else {
            print("Unable to open file")
        }
        return retVal
}
   /* func readFile1() -> UnsafeMutablePointer<Any> {
        let data: UnsafeMutablePointer<UInt8>
        let fileURL1 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("votes.txt")
        
        if let inputStream = InputStream(url: fileURL1) {
            inputStream.open()
            print("I reach here reading")
        inputStream.read( data, maxLength: 32)
            inputStream.close()
            
        } else {
            print("Unable to open file")
        }
        return data
    }*/
}
/*extension FileTransferManager {
    func sendFile(response: SensorManagerResponse) {
        let activity = Activity("Send", parent: Acitivity.current)
        var scope = activity.enter()
        defer {
            scope.leave()
        }
    }
}*/
extension OutputStream {
    
    /// Write `String` to `OutputStream`
    ///
    /// - parameter string:                The `String` to write.
    /// - parameter encoding:              The `String.Encoding` to use when writing the string. This will default to `.utf8`.
    /// - parameter allowLossyConversion:  Whether to permit lossy conversion when writing the string. Defaults to `false`.
    ///
    /// - returns:                         Return total number of bytes written upon success. Return `-1` upon failure.
    
    func write(_ string: String, encoding: String.Encoding = .utf8, allowLossyConversion: Bool = false) -> Int {
        
        if let data = string.data(using: encoding, allowLossyConversion: allowLossyConversion) {
            return data.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) -> Int in
                var pointer = bytes
                var bytesRemaining = data.count
                var totalBytesWritten = 0
                
                while bytesRemaining > 0 {
                    let bytesWritten = self.write(pointer, maxLength: bytesRemaining)
                    if bytesWritten < 0 {
                        return -1
                    }
                    
                    bytesRemaining -= bytesWritten
                    pointer += bytesWritten
                    totalBytesWritten += bytesWritten
                }
                
                return totalBytesWritten
            }
        }
        
        return -1
    }
    
}

