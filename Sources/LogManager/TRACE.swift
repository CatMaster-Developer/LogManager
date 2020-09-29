
/// Define TRACE API

/// Write Log ( not Message )
///

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
