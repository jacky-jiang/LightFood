import Foundation

struct Endpoint {
    let baseURL: URL
    let path: String
    let method: String

    func makeURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
