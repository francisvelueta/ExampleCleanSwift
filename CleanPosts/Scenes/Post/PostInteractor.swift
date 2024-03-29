//
//  PostInteractor.swift
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

protocol PostBusinessLogic
{
    func doLoadInitialData(request: PostScene.Load.Request)
    func doLoadComments(request: PostScene.Comments.Request)
}

protocol PostDataStore {
    //var name: String { get set }
    var postId : Int { get set }
}

class PostInteractor: PostBusinessLogic, PostDataStore {
    var presenter: PostPresentationLogic?
    var worker: PostWorker?
    var postId: Int = 0
    
    //var name: String = ""
    
    // MARK: Do something
    
    func doLoadInitialData(request: PostScene.Load.Request) {
        worker = PostWorker()
        worker?.fetchPosts(completionHandler: { posts in
            let response = PostScene.Load.Response(posts: posts)
            self.presenter?.presentInitialData(response: response)
        })
        
    }
    func doLoadComments(request: PostScene.Comments.Request) {
        let post = request.post
        postId = post.id
        let response = PostScene.Comments.Response()
        presenter?.presentComments(response: response)
        
    }
}
