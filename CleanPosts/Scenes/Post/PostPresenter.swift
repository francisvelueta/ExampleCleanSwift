//
//  PostPresenter.swift
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

protocol PostPresentationLogic {
  func presentInitialData(response: PostScene.Load.Response)
    func presentComments(response: PostScene.Comments.Response)
}

class PostPresenter: PostPresentationLogic {
  weak var viewController: PostDisplayLogic?
  
  // MARK: Do something
  
  func presentInitialData(response: PostScene.Load.Response) {
    let viewModel = PostScene.Load.ViewModel(posts: response.posts)
    viewController?.displayInitialData(viewModel: viewModel)
    
  }
    func presentComments(response: PostScene.Comments.Response) {
        let viewModel = PostScene.Comments.ViewModel()
        viewController?.displayComments(viewModel: viewModel)
    }
}