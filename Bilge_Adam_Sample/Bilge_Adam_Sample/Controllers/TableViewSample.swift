//
//  VC1.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 1.08.2023.
//

import UIKit
import SnapKit
import TinyConstraints


struct Member {
    
    var name:String
    var surname:String
    var cars:[String]
    
}

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
    
    let memberArray = [Member(name: "Tarık", surname: "Efe", cars: ["Mercedes","BMW","Mustang"]),
    Member(name: "Mahmut", surname: "Doğan", cars: ["Volkwagen","Audi","Camaro"]),
    Member(name: "Şevval", surname: "Çakıroğlu", cars: ["Audi","Volvo","Tofaş"]),
    Member(name: "Emirhan", surname: "İmrahor", cars: ["Ferrari SF90"])]
    
    var sortedArray = [Member]()
    let array = ["İstanbul","Ankara", "İzmir"]
    let images = [#imageLiteral(resourceName: "united-states"), #imageLiteral(resourceName: "Apple-Logo"), #imageLiteral(resourceName: "turkey")]
    
    private lazy var tableView:UITableView = {
       let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .black
        tv.separatorStyle = .singleLine
        tv.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 100
        tv.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sortedArray = memberArray.sorted { $0.name < $1.name }
        
        print(sortedArray)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

        setupView()
    }
    
    private func deleteArrayElement(at row:Int){
        print(row)
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
        //goDestinationVC(name: name)
        
    }
    
    //MARK: -- Her bir tableviewCell içerisinde solda sağa doğru kaydırmalı buton seti açar.
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //MARK: -- swipe menüsüne buton ekler ve aksiyonlarını tanımlar.
        let action = UIContextualAction(style: .normal, title: "Okundu", handler: { action,view,handler in
            
            
            self.deleteArrayElement(at: indexPath.row)
            
        })
        
        
        let config = UISwipeActionsConfiguration(actions: [action])
        
        
        return config
    }
    
    
    //MARK: -- Her bir tableviewCell içerisinde sağdan sola doğru kaydırmalı buton seti açar.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action2 = UIContextualAction(style: .destructive, title: "", handler: { action,view,handler in
        
            print("action2 çalıştı")
           
        })
        
        action2.image = UIImage(systemName: "xmark.bin.fill")
        
        let config = UISwipeActionsConfiguration(actions: [action2])
        return config
    }
    
    
}

extension TableViewSample:UITableViewDataSource {
    
    
    //MARK: -- Kaç adet section olacağını belirtir.
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    //MARK: -- Her bir section içerisinde kaç tane satır olacağını belirtir. 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return array.count
       
        
    }
    
    
    //MARK: -- Her bir tableView satırına eklenecek UITableViewCell'leri tanımlar.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else { return UITableViewCell() }
    
        
        let nameObject = array[indexPath.row]
        let imageObject = images[indexPath.row]
        
        cell.configure(name: nameObject, image: images[indexPath.row])
        
        
        
        return cell
    }
    
    
}
