//
//  ViewController.swift
//  StevenMVVM
//
//  Created by steven on 2021/3/25.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: OilViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        self.view.addSubview(addModelStringButton)
        viewModel = OilViewModel()
        initBinding()
        
    }
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"HomeCell", bundle:nil), forCellReuseIdentifier:"HomeCell")
        return tableView
    }()
    
    lazy var addModelStringButton: UIButton = {
        var addModelStringButton = UIButton()
        addModelStringButton.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        addModelStringButton.center = view.center
        addModelStringButton.backgroundColor = .red
        addModelStringButton.setTitle("新增Model", for: .normal)
        addModelStringButton.addTarget(self, action: #selector(addModelStringButtonPress(sender:)), for: .touchUpInside)
        return addModelStringButton
    }()
    
    @objc func addModelStringButtonPress(sender: UIButton) {
        print("新增文字")
        let oilModel = OilModel()
        oilModel.title = "test\(viewModel.oilModelList.value.count)"
        viewModel.oilModelList.value.append(oilModel)
    }
    
    func initBinding() {
        viewModel.oilModelList.addObserver { [weak self] (list) in
            self?.tableView.reloadData()
            print(list)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.oilModelList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeCell = tableView.dequeueReusableCell(withIdentifier: "HomeCell")  as! HomeCell
        cell.titleLabel.text = viewModel.oilModelList.value[indexPath.item].title
        return cell
    }
}

