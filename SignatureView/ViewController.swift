//
//  ViewController.swift
//  SignatureView
//
//  Created by Christian Ampe on 9/29/19.
//  Copyright © 2019 Christian Ampe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var drawingView: ACDrawing.View = {
        let drawingView = ACDrawing.View()
        drawingView.translatesAutoresizingMaskIntoConstraints = false
        drawingView.backgroundColor = .white
        return drawingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(drawingView)
        
        drawingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        drawingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        drawingView.heightAnchor.constraint(equalTo: drawingView.widthAnchor, multiplier: 0.5).isActive = true
        drawingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
