import Foundation
import OHHTTPStubs

public extension Behaviour {
    func stubNetworkRequest(stub: Stub) {
        requests.append(stub)
        stubRequest()
    }
    
    internal func stubRequest() {
        for request in requests {
            stub(condition: isAbsoluteURLString(request.urlString), response: { _ -> HTTPStubsResponse in
                let stubData = request.jsonReturn.data(using: String.Encoding.utf8)
                return HTTPStubsResponse(data: stubData!, statusCode: request.httpResponse, headers: nil)
            })
        }
    }

    /**
     READ DATA FILE INTO STRING

     - parameter: urlString:String
     - return: String?
     */
    func openFileAndReadIntoString(urlString: String) -> String? {
        if let dir = Bundle.main.path(forResource: urlString, ofType: "json") {
            do {
                let text2 = try String(contentsOfFile: dir)
                return text2
            } catch _ as NSError {
                return nil
            }
        }
        return nil
    }
}
