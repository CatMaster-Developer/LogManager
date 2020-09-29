

import UIKit


open class LogManager: NSObject {
    
    /// Instance
    static let instane = LogManager()
    
    /// The Log Type [ struct : LogType ]
    private(set) var logType:LogType = [.desktop, .llvm]
    
    /// set to log type
    func setLogType( _ logType:LogType) {
        self.logType = logType
    }
    
    /// Write Log
    ///
    /// - Parameters:
    ///   - file: The Called file name
    ///   - function: The Called function name
    ///   - line: The Called file line
    open func trace( _ file:String = #fileID,
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
    open func trace( _ file:String = #fileID,
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
        
        // case : llvm
        if logType.contains(.llvm) {
            print(logTextFormat)
        }
        
        // case : device
        if logType.contains(.device) {
        }
        
        // case : desktop
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




extension LogManager {
    
    /// Create the Log File
    private func createLogFile()  {
        
        guard let infoDic = Bundle.main.infoDictionary else {return}
        let appName = infoDic["CFBundleName"] as? String ?? "not info"
        let appVersion = infoDic["CFBundleShortVersionString"] as? String ?? "not info"
        let appBuildVersion = infoDic["CFBundleVersion"] as? String ?? "not info"
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM-dd HH:mm:ss"
        
        let logFileInfo = "📓 " + "App Name : " + appName + "\nApp Version : " + appVersion + "\nApp Build Version : " + appBuildVersion + "\nData : " + dateFormat.string(from: Date()) + "\n"
        
        // to mobile device
        if logType.contains(.device) {
        }
        
        // to desktop
        if logType.contains(.desktop) {
            guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return  }
            let fileURL = dir.appendingPathComponent("streamLog.txt")
            if !FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    try logFileInfo.write(to: fileURL, atomically: true, encoding: .utf8)
                } catch {
                    print("error : " + error.localizedDescription)
                }
            }
        }
    }
    
}



/// define
extension LogManager {
    
    struct LogType : OptionSet {
        let rawValue:Int
        
        static let none = LogType(rawValue: 1 << 0)     // not log
        static let llvm = LogType(rawValue: 1 << 1)  // llvm view log( nslog or print )
        static let device = LogType(rawValue: 1 << 2)   // mobile device log ( for users or customers )
        static let desktop = LogType(rawValue: 1 << 3)  // mac desktop log ( for developer )
    }
    
}
