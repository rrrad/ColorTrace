//
//  HistoryViewController.swift
//  ColorTrace
//
//  Created by Radislav Gaynanov on 07.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var list: UITableView!
    let viewModel = HistoryViewModel()
    
    var returnButton: UIButton = {
           let button = UIButton.init(frame: .zero)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.setTitle("H", for: .normal)
           button.addTarget(self, action: #selector(dismissHistory), for: .touchUpInside)
           button.backgroundColor = .orange
           return button
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        list = UITableView.init(frame: view.bounds)
        list.delegate = self
        list.dataSource = self
        list.backgroundColor = .darkGray
        list.register(RecognizedColorCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(list)
        view.addSubview(returnButton)
    }
    
    override func viewDidLayoutSubviews() {
        let constr = [
            returnButton.widthAnchor.constraint(equalToConstant: 44.0),
            returnButton.heightAnchor.constraint(equalToConstant: 44.0),
            returnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            returnButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -70.0)
        ]
        NSLayoutConstraint.activate(constr)
    }
    
    @objc
    func dismissHistory() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RecognizedColorCell
        cell.configureCell(viewModel.getHistoryItem(at: indexPath.row))
        return cell
    }
    
    
}
