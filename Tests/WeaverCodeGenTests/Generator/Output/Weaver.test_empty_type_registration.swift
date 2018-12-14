/// This file is generated by Weaver 0.11.2
/// DO NOT EDIT!
// MARK: - LoggerTest1
protocol LoggerTest1DependencyResolver {
    var logEngine: LogEngineTest1 { get }
}
final class LoggerTest1DependencyContainer: LoggerTest1DependencyResolver {
    private var _logEngine: LogEngineTest1?
    var logEngine: LogEngineTest1 {
        if let value = _logEngine { return value }
        let value = LogEngineTest1()
        _logEngine = value
        return value
    }
    init() {
        _ = logEngine
    }
}
// MARK: - ManagerTest1
protocol ManagerTest1DependencyResolver {
    var logger: LoggerTest1 { get }
}
final class ManagerTest1DependencyContainer: ManagerTest1DependencyResolver {
    private var _logger: LoggerTest1?
    var logger: LoggerTest1 {
        if let value = _logger { return value }
        let value = LoggerTest1(injecting: LoggerTest1DependencyContainer())
        _logger = value
        return value
    }
    init() {
        _ = logger
    }
}
