//
//  PostModels.swift
//  CleanPosts
//
//  Created by Francisca Velueta on 07/12/19.
//  Copyright (c) 2019 Francis Velueta. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum PostScene {
  // MARK: Use cases
  
  enum Load {
    struct Request {
    }
    struct Response {
        let posts: [Post]
    }
    struct ViewModel {
         let posts: [Post]
    }
  }
    
    enum Comments {
        struct Request {
            let post: Post
            }
            struct Response {
              
            }
            struct ViewModel {
              
            }
    }
}
