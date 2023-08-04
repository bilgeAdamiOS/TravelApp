//
//  VC1.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 1.08.2023.
//

import UIKit
import SnapKit
import TinyConstraints





class TableViewSample: UIViewController {
    
    var addressArray: [AddressInfo] = [
        AddressInfo(name: "John Doe", address: "123 Main St", state: "İstanbul", city: "Kadıköy", country: "Türkiye", phone: "555-1234", isDefault: true),
        AddressInfo(name: "Jane Smith", address: "456 Elm St", state: "Ankara", city: "Çankaya", country: "Türkiye", phone: "555-5678", isDefault: false),
        AddressInfo(name: "Alice Johnson", address: "789 Oak St", state: "İzmir", city: "Bornova", country: "Türkiye", phone: "555-9876", isDefault: false),
        AddressInfo(name: "Bob Williams", address: "321 Pine St", state: "Bursa", city: "Osmangazi", country: "Türkiye", phone: "555-4321", isDefault: false),
        AddressInfo(name: "Eve Brown", address: "654 Maple St", state: "Antalya", city: "Muratpaşa", country: "Türkiye", phone: "555-6789", isDefault: false),
        AddressInfo(name: "Michael Lee", address: "987 Birch St", state: "Adana", city: "Seyhan", country: "Türkiye", phone: "555-7890", isDefault: false),
        AddressInfo(name: "Sophia Davis", address: "246 Cedar St", state: "Eskişehir", city: "Tepebaşı", country: "Türkiye", phone: "555-2345", isDefault: false),
        AddressInfo(name: "William Martinez", address: "135 Walnut St", state: "Konya", city: "Selçuklu", country: "Türkiye", phone: "555-8765", isDefault: false),
        AddressInfo(name: "Olivia Johnson", address: "864 Pine St", state: "Mersin", city: "Yenişehir", country: "Türkiye", phone: "555-7654", isDefault: false),
        AddressInfo(name: "James Wilson", address: "579 Elm St", state: "Trabzon", city: "Ortahisar", country: "Türkiye", phone: "555-5432", isDefault: false)
    ]
    
    let memberArray = [Member(name: "Tarık", surname: "Efe", cars: ["Mercedes","BMW","Mustang"]),
    Member(name: "Mahmut", surname: "Doğan", cars: ["Volkwagen","Audi","Camaro"]),
    Member(name: "Şevval", surname: "Çakıroğlu", cars: ["Audi","Volvo","Tofaş"]),
    Member(name: "Emirhan", surname: "İmrahor", cars: ["Ferrari SF90"])]
    
    var sortedArray = [Member]()
    var array = ["İstanbul","Ankara", "İzmir","Trabzon","Adana","Antalya","Sinop","Diyarbakır"]
    let images = [#imageLiteral(resourceName: "united-states"), #imageLiteral(resourceName: "Apple-Logo"), #imageLiteral(resourceName: "turkey"), #imageLiteral(resourceName: "turkey"), #imageLiteral(resourceName: "turkey"), #imageLiteral(resourceName: "turkey"), #imageLiteral(resourceName: "turkey"), #imageLiteral(resourceName: "turkey")]
    
    private lazy var tableView:UITableView = {
       let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 100
        tv.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tv.register(AddressCell.self, forCellReuseIdentifier: "AddressCell")
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
    

    private func showAlert(message:String, for row:Int){
        
        let alert = UIAlertController(title: "Uyarı", message: "\(message) satırını silmek istediğinizden emin misiniz?", preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Evet", style: .default, handler: { action in
            self.deleteArrayElement(at: row)
        })
        
        let cancelButton = UIAlertAction(title: "Vazgeç", style: .destructive)
        
        alert.addAction(cancelButton)
        alert.addAction(doneAction)
        
        self.present(alert, animated: true)
        
    }
    
    private func deleteArrayElement(at row:Int){
        array.remove(at: row)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        return 230
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let name = array[indexPath.row]
        //goDestinationVC(name: name)
        
    }
    
    //MARK: -- Her bir tableviewCell içerisinde solda sağa doğru kaydırmalı buton seti açar.
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //MARK: -- swipe menüsüne buton ekler ve aksiyonlarını tanımlar.
        let action = UIContextualAction(style: .normal, title: "Okundu", handler: { action,view,handler in
            
            
            
            
        })
        
        
        let config = UISwipeActionsConfiguration(actions: [action])
        
        
        return config
    }
    
    
    //MARK: -- Her bir tableviewCell içerisinde sağdan sola doğru kaydırmalı buton seti açar.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cityName = array[indexPath.row]
        
        let action2 = UIContextualAction(style: .destructive, title: "", handler: { action,view,handler in
        
            self.showAlert(message: cityName, for: indexPath.row)
           
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
        
        
        return addressArray.count
       
        
    }
    
    
    //MARK: -- Her bir tableView satırına eklenecek UITableViewCell'leri tanımlar.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as? AddressCell else { return UITableViewCell() }
        
        
        let object = addressArray[indexPath.row]
        cell.configure(object: object)
        
        
        
        return cell
    }
    
    
}
