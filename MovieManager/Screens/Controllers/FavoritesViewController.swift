//
//  FavoritesViewController.swift
//  MovieManager
//
//  Created by Leandro Diaz on 9/18/22.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        configureNavigationController()

        // Do any additional setup after loading the view.
    }
    

    func configureNavigationController(with color: UIColor? = .systemBlue) {
//        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorites))
//        navigationItem.rightBarButtonItem = addBtn
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
