//
//  LoadingView.swift
//  tripsine-mobile
//
//  Created by Bianca on 01/07/22.
//

import UIKit

class LoadingView: UIView {
    
    var loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.red], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    
    // MARK: - UI Setup
    func setupUI(viewController: UIViewController) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        viewController.view.backgroundColor = .white
        viewController.view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
            loadingIndicator.widthAnchor
                .constraint(equalToConstant: 50),
            loadingIndicator.heightAnchor.constraint(equalTo: loadingIndicator.widthAnchor)
        ])
    }
}
