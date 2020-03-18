//
//  PostModel.swift
//  DevelopmentTest
//
//  Created by Shu Wei Liang on 2020/3/20.
//  Copyright © 2020 Shu Wei Liang. All rights reserved.
//

import Foundation

struct PostModel {
    var total: Int = 0
    var hasMore: Bool = true
    var currentPage: Int = 0
    var posts: [Post] = []
    
    init(from dict: [String: Any]) {
        self.total = dict["total"] as? Int ?? 0
        self.hasMore = dict["has_more"] as? Bool ?? false
        self.currentPage = dict["current_page"] as? Int ?? 0
        var posts: [Post] = []
        for post in (dict["datas"] as? [[String: Any]] ?? []) {
            posts.append(Post(from: post))
        }
        self.posts = posts
    }
}

struct Post {
    var id: String
    var title: String
    var likes: Int
    var isLike: Bool
    var user: User
    var cover: Cover
    var status: Int
    
    init(from dict: [String : Any]) {
        self.id = dict["id"] as? String ?? ""
        self.title = dict["title"] as? String ?? ""
        self.likes = dict["likes"] as? Int ?? 0
        self.isLike = dict["is_like"] as? Bool ?? false
        self.user = User(from: dict["user"] as? [String: Any] ?? [:])
        self.cover = Cover(from: dict["cover"] as? [String: Any] ?? [:])
        self.status = dict["status"] as? Int ?? 0
    }
}

struct User {
    var id: String = ""
    var name: String = ""
    var cover: URL?
    
    init(from dict: [String : Any]) {
        self.id = dict["id"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        if let cover = dict["cover"] as? String,
            let url = URL(string: cover) {
            self.cover = url
        } else {
            self.cover = nil
        }
    }
}

struct Cover {
    var url: URL?
    var width: Int
    var height: Int
    
    init(from dict: [String : Any]) {
        if let cover = dict["url"] as? String,
            let url = URL(string: cover) {
            self.url = url
        } else {
            self.url = nil
        }
        self.width = dict["width"] as? Int ?? 0
        self.height = dict["height"] as? Int ?? 0
    }
}
