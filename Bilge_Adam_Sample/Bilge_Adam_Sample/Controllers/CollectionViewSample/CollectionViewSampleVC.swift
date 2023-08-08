//
//  CollectionViewSampleVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 7.08.2023.
//

import UIKit
import SnapKit

enum CurrentType:String {
    case ac = "AC"
    case dc = "DC"
}

enum Cable:String {
    
    case usa = "USA"
    case eu = "EU"
    case china = "CHINA"
    case japan = "JAPAN"
    case tesla = "TESLA"
}

struct ChargerStation {
    
    var stationName:String
    var currentType:[CurrentType]
    var cableType:[Cable]
    
}

class CollectionViewSampleVC: UIViewController {
    
    var filterKeys = ["current":["AC","DC"],
                      "cable":["EU","CHINA","TESLA","USA","JAPAN"]]
    
    var chargerStation = [
        ChargerStation(stationName: "İzmir", currentType: [.ac,.dc], cableType: [.eu, .china, .japan]),
        ChargerStation(stationName: "Los Angles", currentType: [.dc], cableType: [.usa, .japan]),
        ChargerStation(stationName: "Berlin", currentType: [.ac], cableType: [.eu, .tesla])]

    var addressArray: [AddressInfo] = [
        AddressInfo(name: "John Doe", address: "123 Main St", state: "İstanbul", city: "Kadıköy", country: "Türkiye", phone: "555-1234", isDefault: true),
        AddressInfo(name: "Jane Smith", address: "456 Elm St", state: "Ankara", city: "Çankaya", country: "Türkiye", phone: "555-5678", isDefault: false),
        AddressInfo(name: "Alice Johnson", address: "789 Oak St", state: "İzmir", city: "Bornova", country: "Türkiye", phone: "555-9876", isDefault: false),
        AddressInfo(name: "Bob Williams", address: "321 Pine St", state: "Bursa", city: "Osmangazi", country: "Türkiye", phone: "555-4321", isDefault: false)
    ]
    
    
    private lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.backgroundColor = .white
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    private lazy var collectionView:UICollectionView = {
        
        //MARK: -- CollectionView arayüzü için sağlanan layout protocolü.
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = false
        cv.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(CollectionAddressCell.self, forCellWithReuseIdentifier: "AddressCellItem")
        return cv
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let test = Cable.japan
        let newArr = chargerStation.filter({ element in
            element.cableType.contains(test)
                
        })
        
        print(newArr)
        setupViews()
    }
    
    private func setupViews(){
        
        self.view.backgroundColor = .white
        self.view.addSubviews(tableView,collectionView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        tableView.snp.makeConstraints({ tv in
            tv.top.equalTo(self.view.safeAreaLayoutGuide)
            tv.leading.equalToSuperview().offset(8)
            tv.trailing.equalToSuperview().offset(-8)
            tv.bottom.equalTo(collectionView.snp.top).offset(-16)
        })
        
        collectionView.snp.makeConstraints({ cv in
            cv.leading.equalToSuperview()
            cv.trailing.equalToSuperview()
            cv.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-24)
            cv.height.equalTo(200)
        })
    }
   

}


extension CollectionViewSampleVC:UICollectionViewDelegateFlowLayout {
    
    
    //MARK: -- Her bir item için ebatları belirttiğimiz layout methodu.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = CGSize(width: collectionView.frame.width-32, height:150)
        return size
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension CollectionViewSampleVC:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addressArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddressCellItem", for: indexPath) as? CollectionAddressCell else { return UICollectionViewCell() }
        
        let object = addressArray[indexPath.row]
        cell.configure(object: object)
        
        return cell
    }
    
    
}


extension CollectionViewSampleVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
}

extension CollectionViewSampleVC:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "Deneme"
        
        return cell
        
    }
    
    
}
