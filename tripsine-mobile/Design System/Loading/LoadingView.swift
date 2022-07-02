//
//  LoadingView.swift
//  tripsine-mobile
//
//  Created by Bianca on 01/07/22.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    var loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.red], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    
    // MARK: - UI Setup
   func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.backgroundColor = .white
        self.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor
                .constraint(equalTo: self.centerXAnchor),
            loadingIndicator.centerYAnchor
                .constraint(equalTo: self.centerYAnchor),
            loadingIndicator.widthAnchor
                .constraint(equalToConstant: 50),
            loadingIndicator.heightAnchor
                .constraint(equalTo: self.loadingIndicator.widthAnchor)
        ])
    }
}
