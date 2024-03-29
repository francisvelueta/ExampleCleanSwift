//
//  CommentWorker.swift
//  CleanPosts
//
//  Created by Francisca Velueta on 08/12/19.
//  Copyright (c) 2019 Francis Velueta. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class CommentWorker {
    func fetchPComments(postId: Int, completionHandler: @escaping ([Comment]) -> Void) {
        NetworkManager.shared.getCommentsForPost(withPostId: "\(postId)") { comments in
            completionHandler(comments)
        }
  }
}
