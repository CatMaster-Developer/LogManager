

import UIKit

public class LogManager: NSObject {
    
    /// Instance
    static public let instane = LogManager()
    
    /// The Log Type [ struct : LogType ]
    private(set) var logType:LogType = [.desktop, .llvm]
    
    /// set to log type
    /// - Parameter logType: The Log Type [ struct : LogType ]
    public func setLogType( _ logType:LogType) {
        self.logType = logType
    }
    
    /// Write Log
    ///
    /// - Parameters:
    ///   - file: The Called file name
    ///   - function: The Called function name
    ///   - line: The Called file line
    internal func trace( _ file:String = #fileID,
                     _ function:String = #function,
                     _ line:Int = #line) {
        trace(msg: "")
    }
    
    /// Write Log
    ///
    /// - Parameters:
    ///   - file: The Called file name
    ///   - function: The Called function name
    ///   - line: The Called file line
    ///   - msg: The Log String
    public func trace( _ file:String = #fileID,
                     _ function:String = #function,
                     _ line:Int = #line,
                     msg:String) {
                
        // Create the Log File
        createLogFile()
        
        // Configure log text
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM-dd HH:mm:ss.SSS"
        let logTextFormat = "[\(dateFormat.string(from: Date()))]" + "<\(file)(\(line))>" + " \(function) " + "📕 " + msg + "\n\n"
        
        let data = logTextFormat.data(using: .utf8)
        guard let dataU = data else { return }
        
        //MARK: llvm
        if logType.contains(.llvm) {
            print(logTextFormat)
        }
        
        //MARK: device( Write to iPhone's log file )
        if logType.contains(.device) {
        }
        
        //MARK: desktop( write to mac's log file )
        if logType.contains(.desktop) {
            guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let fileURL = dir.appendingPathComponent("streamLog.txt")
            do {
                let fh = try FileHandle(forWritingTo: fileURL)
                fh.seekToEndOfFile()
                fh.write(dataU)
                fh.closeFile()
                
            } catch {
                print("error : " + error.localizedDescription)
            }
        }
    }
}







