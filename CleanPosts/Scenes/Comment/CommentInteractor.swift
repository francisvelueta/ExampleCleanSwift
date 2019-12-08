//
//  CommentInteractor.swift
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

protocol CommentBusinessLogic {
  func doLoadInitialData(request: CommentScene.Load.Request)
}

protocol CommentDataStore {
  //var name: String { get set }
    var postId : Int { get set }
}

class CommentInteractor: CommentBusinessLogic, CommentDataStore {
  var presenter: CommentPresentationLogic?
  var worker: CommentWorker?
    var postId: Int = 0 
  //var name: String = ""
  
  // MARK: Do something
  
  func doLoadInitialData(request: CommentScene.Load.Request) {
    worker = CommentWorker()
    worker?.fetchPComments(postId: postId, completionHandler: { coments in
         let response = CommentScene.Load.Response(coments: coments)
        self.presenter?.presentInitialData(response: response)
    })
    
   
  }
}