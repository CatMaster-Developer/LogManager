
import Foundation


extension LogManager {
    
    /// log file write
    internal func createLogFile()  {
        
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
    
    public struct LogType : OptionSet {
        public let rawValue:Int

        static public let none = LogType(rawValue: 1 << 0)      // not log
        static public let llvm = LogType(rawValue: 1 << 1)      // llvm view log( nslog or print )
        static public let device = LogType(rawValue: 1 << 2)    // mobile device log ( for users or customers )
        static public let desktop = LogType(rawValue: 1 << 3)   // mac desktop log ( for developer )
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
    
}
