import Alamofire

class APIHandler {
    
    static let accessKey = "d3343b7c40e0d067e71eb43515a799eb8ecb34b2b575b74f886bad464395d576"
//    static let accessKey = "dddd"
    static let secretKey = "a77cacd6b95602da24841cf7a89dcda97a09185606d3e6f4699ddc66a525e100"
    
    // let center = NotificationCenter.default
    var manager : Alamofire.SessionManager

    init(configuration: URLSessionConfiguration) {
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        self.manager = Alamofire.SessionManager(configuration: configuration)
    }
    
    static let sharedInstance = APIHandler(configuration: URLSessionConfiguration.default)
    
    struct APIScheme {
        static var BaseUrlString = "https://api.unsplash.com/"
        static var getPhotos = APIScheme.BaseUrlString + "photos"
    }
    
    class func fetchData(urlString: String, parameters: Parameters?, success: @escaping (Any?) -> (), failure:
        @escaping (Any?) -> ()) {

        let headers: HTTPHeaders = [
            "Authorization": "Client-ID " + accessKey,
            "Accept-Version": "v1",
            "Content-Type":"application/json"
        ]
        
        sharedInstance.manager.request(
            urlString,
            method: .get,
            parameters: parameters,
            headers: headers
        ).responseJSON { response in
            
            response.result.ifSuccess {
                success(response.result.value)
            }
            
            if let error = response.result.error {
                failure(error)
            }
        }
    }
}
