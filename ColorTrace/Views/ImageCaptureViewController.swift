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
        view.accessibilityIdentifier = "preview"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(red: 23/255, green: 63/255, blue: 206/255, alpha: 1)
        return view
    }()
    
    private lazy var traceButton: UIButton = {
        let button = UIButton.init(frame: .zero)
        button.accessibilityIdentifier = "traceButton"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("GET", for: .normal)
        button.addTarget(self, action: #selector(getColor), for: .touchUpInside)
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private lazy var historyButton: UIButton = {
        let button = UIButton.init(frame: .zero)
        button.accessibilityIdentifier = "historyButton"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("H", for: .normal)
        button.addTarget(self, action: #selector(showHistory), for: .touchUpInside)
        button.backgroundColor = .orange
        return button
    }()
    
    var viewModel: ImageCaptureViewModel = ImageCaptureViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mask = self.createMask(frame: view.bounds,
                                   x: view.center.x,
                                   y: view.center.y,
                                   radius: 20)
        self.view.backgroundColor = .white
        preView.session = viewModel.session
        view.addSubview(preView)
        view.addSubview(mask)
        view.addSubview(traceButton)
        view.addSubview(historyButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.startCapture()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.stopCapture()

    }
    
    func createMask(frame: CGRect, x: CGFloat, y:CGFloat, radius: CGFloat) -> UIView {
        let maskView = UIView.init(frame: frame)
        maskView.accessibilityIdentifier = "mask"
        maskView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        let path = CGMutablePath()
        path.addArc(center: CGPoint.init(x: x, y: y),
                    radius: radius,
                    startAngle: 0,
                    endAngle: 2.0*CGFloat.pi,
                    clockwise: false)
        path.addRect(CGRect.init(origin: .zero, size: maskView.frame.size))
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        
        maskLayer.path = path
        maskLayer.fillRule = .evenOdd
        
        maskView.layer.mask = maskLayer
        maskView.clipsToBounds = true
        
        return maskView
    }
    
    @objc
    func getColor(_ sender: UIButton) {
        sender.wave()
        viewModel.getColor()
    }
    
    @objc
    func showHistory() {
        self.present(HistoryViewController(), animated: true) 
    }
    
    override func viewDidLayoutSubviews() {
           
           let constraints = [
           preView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
           preView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
           preView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
           preView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
           
           traceButton.widthAnchor.constraint(equalToConstant: 100),
           traceButton.heightAnchor.constraint(equalToConstant: 100),
           traceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
           traceButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
           
           historyButton.widthAnchor.constraint(equalToConstant: 44),
           historyButton.heightAnchor.constraint(equalToConstant: 44),
           historyButton.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
           historyButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 75),
           ]
           NSLayoutConstraint.activate(constraints)
       }

}


