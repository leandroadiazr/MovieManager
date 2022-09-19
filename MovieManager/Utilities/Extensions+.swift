//
//  Extensions+.swift
//  MovieManager
//
//  Created by Leandro Diaz on 9/18/22.
//

import UIKit
fileprivate var containerView: UIView!

extension Array where Element == MoviesEntity {
    func matching(_ text: String?) -> [MoviesEntity]{
        if let text = text, text.count > 0 {
            return  self.filter {
                $0.title!.contains(text)
            }
        } else {
            return self
        }
    }
}

extension String  {
    func searchText(_ text: String?) -> String{
        if let text = text, text.count > 0 {
            return  text
        } else {
            return self
        }
    }
}

extension UITableView {
    func removeEmptyCells() {
        tableFooterView = UIView(frame: .zero)
    }
}

extension UIViewController {
    
    func showCustomAlert(title: String, message: String, CtaTitle: String, action: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CtaTitle, style: .default, handler: {_ in action?() }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showCustomLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async{
            containerView.removeFromSuperview()
        }
    }
}

