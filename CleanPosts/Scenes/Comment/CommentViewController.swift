//
//  CommentViewController.swift
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

protocol CommentDisplayLogic: class {
  func displayInitialData(viewModel: CommentScene.Load.ViewModel)
}

class CommentViewController: UIViewController, CommentDisplayLogic {
  var interactor: CommentBusinessLogic?
  var router: (NSObjectProtocol & CommentRoutingLogic & CommentDataPassing)?
     @IBOutlet weak var tableView: UITableView!
    var arrayComments = [Comment]()

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = CommentInteractor()
    let presenter = CommentPresenter()
    let router = CommentRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Comments"
    self.tableView.dataSource = self

    loadInitialData()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func loadInitialData() {
    let request = CommentScene.Load.Request()
    interactor?.doLoadInitialData(request: request)
  }
  
  func displayInitialData(viewModel: CommentScene.Load.ViewModel) {
    arrayComments = viewModel.coments
    tableView.reloadData()
    //nameTextField.text = viewModel.name
  }
}

extension CommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "commentsCell", for: indexPath) as? CommentCell {
            let comment = arrayComments[indexPath.row]
            cell.titleLabel.text = comment.name
            cell.emailLabel.text = comment.email
            cell.contentLabel.text = comment.body
            return cell
        } else {
            return UITableViewCell()
        }
       
        
    }
}
