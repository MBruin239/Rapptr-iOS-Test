//
//  Message.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

struct Message: Decodable {
    var userID: String
    var name: String
    var avatarURL: URL?
    var message: String
    
    private enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name = "name"
        case avatarURL = "avatar_url"
        case message = "message"
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        message = try values.decode(String.self, forKey: .message)
        avatarURL = try values.decode(URL?.self, forKey: .avatarURL)
        userID = try values.decode(String.self, forKey: .userID)
    }
    
    init(testName: String, withTestMessage message: String) {
        self.userID = "0"
        self.name = testName
        self.avatarURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/220px-Smiley.svg.png")
        self.message = message
    }
}
