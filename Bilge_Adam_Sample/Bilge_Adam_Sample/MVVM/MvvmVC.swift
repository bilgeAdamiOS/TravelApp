//
//  MvvmVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 11.08.2023.
//

import UIKit
import TinyConstraints

class MvvmVC: UIViewController {

    let viewModel = MvvmVM()
    
    var array = [Photo]()

    private lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .white
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupViews()
        setupVM()
    }
    
    private func setupVM(){
        
       
        viewModel.photoArrayClosure = { [weak self] in
            
            guard let this = self else { return }
            
            this.array = this.viewModel.photoArray
            
        }
        
        print("B")
        viewModel.getDataFromRemote(with: { obj in
        
        })
    }
    
    
    
    private func setupViews(){
        self.view.addSubview(tableView)
        setupLayout()
        
        print("git eklendi")
        print("branch açıldı")
        
        print("Bir branch daha açılıdı: DetailVC")
    }
    
    
    private func setupLayout(){
        tableView.edgesToSuperview()
    }
    
}


extension MvvmVC:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension MvvmVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.photoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        
        cell.textLabel?.text = viewModel.photoArray[indexPath.row].name
        
        return cell
    }
}
