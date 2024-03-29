//
//  CommentPresenter.swift
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

protocol CommentPresentationLogic {
  func presentInitialData(response: CommentScene.Load.Response)
}

class CommentPresenter: CommentPresentationLogic {
  weak var viewController: CommentDisplayLogic?
  
  // MARK: Do something
  
  func presentInitialData(response: CommentScene.Load.Response) {
    let viewModel = CommentScene.Load.ViewModel(coments: response.coments)
    viewController?.displayInitialData(viewModel: viewModel)
  }
}
