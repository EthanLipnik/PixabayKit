//
//  User.swift
//
//
//  Created by Ethan Lipnik on 8/4/22.
//

import Foundation

public struct User: Identifiable, Hashable {
    public var id: Int
    public var name: String
    public var profilePic: URL?
}
