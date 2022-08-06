//
//  Video.swift
//  
//
//  Created by Ethan Lipnik on 8/4/22.
//

import Foundation

public struct Video: Codable, Identifiable, Hashable {
    public var id: Int
    public var pageURL: URL?
    public var type: VideoType
    public var tags: [String]
    public var duration: Double
    public var pictureID: String
    public var items: [Item: Item.VideoItem]
    public var views: Int
    public var downloads: Int
    public var comments: Int
    public var user: User
    
    public enum VideoType: String, Codable {
        case all
        case film
        case animation
    }
    
    public enum Item: Codable, Hashable {
        case large
        case medium
        case small
        case tiny
        
        public struct VideoItem: Codable, Hashable {
            public var url: URL
            public var width: Int
            public var height: Int
            public var size: Int
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case pageURL
        case type
        case tags
        case duration
        case pictureID = "picture_id"
        case items = "videos"
        case views
        case downloads
        case comments
        
        case username = "user"
        case userID = "user_id"
        case userProfilePic = "userImageURL"
        
        case large
        case medium
        case small
        case tiny
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        pageURL = try? container.decode(URL.self, forKey: .pageURL)
        type = try container.decode(VideoType.self, forKey: .type)
        tags = (try container.decode(String.self, forKey: .tags)).components(separatedBy: ", ").map({ String($0) })
        duration = try container.decode(Double.self, forKey: .duration)
        pictureID = try container.decode(String.self, forKey: .pictureID)
        views = try container.decode(Int.self, forKey: .views)
        downloads = try container.decode(Int.self, forKey: .downloads)
        comments = try container.decode(Int.self, forKey: .comments)
        
        items = [:]
        let videosContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .items)
        if let largeVideo = try? videosContainer.decode(Item.VideoItem.self, forKey: .large) {
            items[.large] = largeVideo
        }
        if let mediumVideo = try? videosContainer.decode(Item.VideoItem.self, forKey: .medium) {
            items[.medium] = mediumVideo
        }
        if let smallVideo = try? videosContainer.decode(Item.VideoItem.self, forKey: .small) {
            items[.small] = smallVideo
        }
        if let tinyVideo = try? videosContainer.decode(Item.VideoItem.self, forKey: .tiny) {
            items[.tiny] = tinyVideo
        }
        
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
        try container.encode(duration, forKey: .duration)
        try container.encode(pictureID, forKey: .pictureID)
        try container.encode(views, forKey: .views)
        try container.encode(downloads, forKey: .downloads)
        try container.encode(comments, forKey: .comments)
        
        try container.encode(user.id, forKey: .userID)
        try container.encode(user.name, forKey: .username)
        try container.encode(user.profilePic, forKey: .userProfilePic)
    }
}
