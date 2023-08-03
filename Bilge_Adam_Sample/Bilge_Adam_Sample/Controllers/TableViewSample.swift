//
//  VC1.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 1.08.2023.
//

import UIKit
import SnapKit
import TinyConstraints

class CustomCell:UITableViewCell {
    
    
    private lazy var lblTitle:UILabel = {
        let l = UILabel()
        l.textColor = .blue
        return l
    }()
    
    private lazy var lblSubtitle:UILabel = {
        let l = UILabel()
        l.textColor = .blue
        return l
    }()
    
    private lazy var lblDesc:UILabel = {
        let l = UILabel()
        l.textColor = .blue
        return l
    }()
    
    private lazy var imgHeader:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    public func configure(name:String, image:UIImage){
        
        lblTitle.text = name
        lblSubtitle.text = name
        lblDesc.text = name
        
        imgHeader.image = image
    }
    
    private func setupViews(){
        self.backgroundColor = .white
        self.contentView.addSubviews(lblTitle,
                                     lblSubtitle,
                                     lblDesc,
                                     imgHeader
                                     )
        
        setupLayout()
    }
    
    
    private func setupLayout(){
        
        imgHeader.leadingToSuperview(offset:8)
        imgHeader.topToSuperview(offset:8)
        imgHeader.bottomToSuperview(offset:-8)
        imgHeader.height(80)
        imgHeader.width(80)
        
        lblTitle.topToSuperview(offset:8)
        lblTitle.leadingToTrailing(of: imgHeader,offset: 12)
        lblTitle.trailingToSuperview(offset:16)
        
        lblSubtitle.topToBottom(of: lblTitle,offset: 8)
        lblSubtitle.leading(to: lblTitle)
        lblSubtitle.trailingToSuperview(offset:16)
        
        lblDesc.topToBottom(of: lblSubtitle,offset: 8)
        lblDesc.leading(to: lblTitle)
        lblDesc.trailingToSuperview(offset:16)
        lblDesc.bottomToSuperview(offset:-16)
    }
}








class TableViewSample: UIViewController {
    
    let array = ["İstanbul","Ankara", "İzmir"]
    let images = [#imageLiteral(resourceName: "united-states"), #imageLiteral(resourceName: "Apple-Logo"), #imageLiteral(resourceName: "turkey")]
    
    private lazy var tableView:UITableView = {
       let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .white
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 100
        tv.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

        setupView()
    }
    
    private func goDestinationVC(name:String){
        
        let vc = TableViewDetailVC()
        vc.name = name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupView(){
        self.view.backgroundColor = .yellow
        self.view.addSubviews(tableView)
        
        setupLayout()
    }
    
    func setupLayout(){
        
        tableView.edgesToSuperview()
    }
    

}


extension TableViewSample:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let name = array[indexPath.row]
        goDestinationVC(name: name)
        
    }
}

extension TableViewSample:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else { return UITableViewCell() }
        
        cell.configure(name: array[indexPath.row], image: images[indexPath.row])
        
        
        
        return cell
    }
    
    
}
