import Moya
import Alamofire

class APIManager {
    static let shared = APIManager()

    private let session: Session
    private let loggerPlugin: PluginType

    private init() {
        self.session = Session()
        self.loggerPlugin = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
    }

    public func createProvider<T: TargetType>(for targetType: T.Type) -> MoyaProvider<T> {
        return MoyaProvider<T>(
            session: session,
            plugins: [loggerPlugin]
        )
    }

    public func testProvider<T: TargetType>(for targetType: T.Type) -> MoyaProvider<T> {
        return MoyaProvider<T>(
            stubClosure: MoyaProvider.immediatelyStub,
            plugins: [loggerPlugin]
        )
    }
}
