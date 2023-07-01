//
//  DetailViewController.swift
//  MVP-LevelOne
//
//  Created by Даниил Тчанников on 30.06.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var commentLabel: UILabel!
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setComment()
    }
    
    @IBAction func popAction(_ sender: Any) {
        presenter.tap()
    }
    
}

extension DetailViewController: DetailViewProtocol {
    func setComment(comment: Comment?) {
        commentLabel.text = comment?.body
    }
}
