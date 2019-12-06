//
//  ViewController.swift
//  ColorTrace
//
//  Created by Radislav Gaynanov on 25.11.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import UIKit
import AVFoundation

class ImageCaptureViewController: UIViewController {

    private lazy var preView: PreviewView = {
        let view = PreviewView.init(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(red: 23/255, green: 63/255, blue: 206/255, alpha: 1)
        return view
    }()
    
    private lazy var traceButton: UIButton = {
        let button = UIButton.init(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("GET", for: .normal)
        button.addTarget(self, action: #selector(getColor), for: .touchUpInside)
        button.backgroundColor = .cyan
        return button
    }()
    
    private let viewModel = ImageCaptureViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        preView.session = viewModel.session
        view.addSubview(preView)
        view.addSubview(traceButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.startCapture()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.stopCapture()

    }
    
    
    override func viewDidLayoutSubviews() {
        preView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        preView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        preView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        preView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        
        traceButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        traceButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        traceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        traceButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200).isActive = true


    }
    
    @objc
    func getColor() {
        
    }

}


