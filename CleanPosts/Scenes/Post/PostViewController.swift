//
//  PostViewController.swift
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

protocol PostDisplayLogic: class {
  func displayInitialData(viewModel: PostScene.Load.ViewModel)
    func displayComments (viewModel: PostScene.Comments.ViewModel)
}

class PostViewController: UIViewController, PostDisplayLogic {
  var interactor: PostBusinessLogic?
  var router: (NSObjectProtocol & PostRoutingLogic & PostDataPassing)?
// To add tableView
    @IBOutlet weak var tableView: UITableView!
    var arrayPosts = [Post]()
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
    let interactor = PostInteractor()
    let presenter = PostPresenter()
    let router = PostRouter()
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

//    self.tableView.register(PostCell.self, forCellReuseIdentifier: "postCell")
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    
    
    loadInitialData()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func loadInitialData() {
    let request = PostScene.Load.Request()
    interactor?.doLoadInitialData(request: request)
  }
  
  func displayInitialData(viewModel: PostScene.Load.ViewModel) {
    arrayPosts = viewModel.posts
    tableView.reloadData()
    //nameTextField.text = viewModel.name
  }
    func displayComments(viewModel: PostScene.Comments.ViewModel) {
        router?.routeToSComments()
    }
}

extension PostViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrayPosts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostCell {
            let post = arrayPosts[indexPath.row]
            cell.titleLabel.text = post.title
            cell.contentLabel.text = post.body
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
}
extension PostViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = arrayPosts[indexPath.row]
        let request = PostScene.Comments.Request(post: post)
        interactor?.doLoadComments(request: request)
    }
}
