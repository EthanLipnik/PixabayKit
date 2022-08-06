//
//  Image.swift
//  
//
//  Created by Ethan Lipnik on 8/5/22.
//

import Foundation

public struct Image: Codable, Identifiable, Hashable {
    public var id: Int
    public var pageURL: URL?
    public var type: ImageType
    public var tags: [String]
    public var preview: Preview
    public var webformat: Preview
    public var largeImageURL: URL?
    public var fullHDURL: URL?
    public var imageURL: URL?
    public var imageWidth: Int
    public var imageHeight: Int
    public var imageSize: Int
    public var views: Int
    public var downloads: Int
    public var comments: Int
    public var user: User
    
    public enum ImageType: String, Codable {
        case all
        case photo
        case illustration
        case vector
    }
    
    public struct Preview: Codable, Hashable {
        var url: URL?
        var width: Int
        var height: Int
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case pageURL
        case type
        case tags
        
        case previewURL
        case previewWidth
        case previewHeight
        
        case webformatURL
        case webformatWidth
        case webformatHeight
        
        case largeImageURL
        case fullHDURL
        case imageURL
        case imageWidth
        case imageHeight
        case imageSize
        
        case views
        case downloads
        case comments
        
        case username = "user"
        case userID = "user_id"
        case userProfilePic = "userImageURL"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        pageURL = try? container.decode(URL.self, forKey: .pageURL)
        type = try container.decode(ImageType.self, forKey: .type)
        tags = (try container.decode(String.self, forKey: .tags)).components(separatedBy: ", ").map({ String($0) })
        
        preview = .init(url: try? container.decode(URL.self, forKey: .previewURL),
                        width: try container.decode(Int.self, forKey: .previewWidth),
                        height: try container.decode(Int.self, forKey: .previewHeight))
        
        webformat = .init(url: try? container.decode(URL.self, forKey: .webformatURL),
                        width: try container.decode(Int.self, forKey: .webformatWidth),
                        height: try container.decode(Int.self, forKey: .webformatHeight))
        
        largeImageURL = try? container.decode(URL.self, forKey: .largeImageURL)
        fullHDURL = try? container.decode(URL.self, forKey: .fullHDURL)
        imageURL = try? container.decode(URL.self, forKey: .imageURL)
        imageWidth = try container.decode(Int.self, forKey: .imageWidth)
        imageHeight = try container.decode(Int.self, forKey: .imageHeight)
        imageSize = try container.decode(Int.self, forKey: .imageSize)
        
        views = try container.decode(Int.self, forKey: .views)
        downloads = try container.decode(Int.self, forKey: .downloads)
        comments = try container.decode(Int.self, forKey: .comments)
        
        let username = try container.decode(String.self, forKey: .username)
        let userID = try container.decode(Int.self, forKey: .userID)
        let userProfilePic = try? container.decode(URL.self, forKey: .userProfilePic)
        user = User(id: userID, name: username, profilePic: userProfilePic)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(pageURL, forKey: .pageURL)
        try container.encode(type, forKey: .type)
        try container.encode(tags.joined(separator: ", "), forKey: .tags)
        
        try container.encode(preview.url, forKey: .previewURL)
        try container.encode(preview.width, forKey: .previewWidth)
        try container.encode(preview.height, forKey: .previewHeight)
        
        try container.encode(webformat.url, forKey: .webformatURL)
        try container.encode(webformat.width, forKey: .webformatURL)
        try container.encode(webformat.height, forKey: .webformatURL)
        
        try container.encode(largeImageURL, forKey: .largeImageURL)
        try container.encode(fullHDURL, forKey: .fullHDURL)
        try container.encode(imageURL, forKey: .imageURL)
        try container.encode(imageWidth, forKey: .imageWidth)
        try container.encode(imageHeight, forKey: .imageHeight)
        try container.encode(imageSize, forKey: .imageSize)
        
        try container.encode(views, forKey: .views)
        try container.encode(downloads, forKey: .downloads)
        try container.encode(comments, forKey: .comments)
        
        try container.encode(user.id, forKey: .userID)
        try container.encode(user.name, forKey: .username)
        try container.encode(user.profilePic, forKey: .userProfilePic)
    }
}
