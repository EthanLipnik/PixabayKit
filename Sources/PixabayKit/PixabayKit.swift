import Foundation

public class PixabayKit {
    private var apiKey: String
    
    public init(_ apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func searchVideos(_ query: String? = nil, count: Int = 20) async throws -> [Video] {
        guard let url = createUrl("videos", queryItems: [URLQueryItem(name: "q", value: query), URLQueryItem(name: "per_page", value: "\(count)")]) else { throw URLError(.badURL) }
        
        let data = try await URLSession.shared.data(from: url).0
        let response = try JSONDecoder().decode(Response<Video>.self, from: data)
        return response.hits
    }
    
    public func getImage(_ id: String) async throws -> Image? {
        guard let url = createUrl(queryItems: [URLQueryItem(name: "id", value: id)]) else { throw URLError(.badURL) }
        
        let data = try await URLSession.shared.data(from: url).0
        let response = try JSONDecoder().decode(Response<Image>.self, from: data)
        return response.hits.first
    }
    
    private func createUrl(_ path: String = "", queryItems: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pixabay.com"
        urlComponents.path = "/api/" + path
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: apiKey)
        ] + queryItems.filter({ $0.value != nil })
        
        return urlComponents.url
    }
}
