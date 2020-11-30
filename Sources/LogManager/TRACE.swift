

/// Set LogType
/// - Parameter logType: The Log Type [ struct : LogType ]
public func LogType(_ logType: LogManager.LogType) {
    LogManager.instane.trace()
}

/// Write Log ( not Message )
///
public func TRACE() {
    LogManager.instane.trace()
}

/// Write Log
///
/// - Parameters:
///   - msg: The Log String
public func TRACE( _ msg : String ) {
    LogManager.instane.trace(msg: msg)
}
