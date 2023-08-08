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

struct FilterKey {
    var current:[CurrentType]
    var cable:[Cable]
}

class CollectionViewSampleVC: UIViewController {
    
    var filterKeys = FilterKey(current: [.ac,.dc], cable: [.china,.usa,.tesla,.japan,.eu])
    
    var filteredArray = [ChargerStation]()
    
    var chargerStation = [
        ChargerStation(stationName: "İzmir", currentType: [.ac,.dc], cableType: [.eu, .china, .japan]),
        ChargerStation(stationName: "Pekin", currentType: [.ac,.dc], cableType: [.eu, .china, .japan]),
        ChargerStation(stationName: "Trabzon", currentType: [.ac,.dc], cableType: [.eu, .china, .japan]),
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
        tv.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
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
        
        setupViews()
        
        setFilteredArray()
    }
    
    func setFilteredArray(_ cableType:Cable? = nil){
        
        guard let type = cableType else {
            self.filteredArray = chargerStation
            return
        }
        
        let filteredArray = chargerStation.filter { item in
            item.cableType.contains(type)

        }
        self.filteredArray = filteredArray
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
        return filteredArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddressCellItem", for: indexPath) as? CollectionAddressCell else { return UICollectionViewCell() }
        
        let object = filteredArray[indexPath.row]
        cell.configure(object: object)
        
        return cell
    }
    
    
}


extension CollectionViewSampleVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Akım Tipi"
            
        }else {
            return "Kablo Tipi"
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            
            setFilteredArray()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 1 {
            let item = filterKeys.cable[indexPath.row]
            setFilteredArray(item)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
        
        
        
    }
    
}

extension CollectionViewSampleVC:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return filterKeys.current.count
        }else {
            return filterKeys.cable.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.textLabel?.textColor = .black
        if indexPath.section == 0 {
            let title = filterKeys.current[indexPath.row].rawValue
            cell.textLabel?.text = title
            
        }else {
            let title = filterKeys.cable[indexPath.row].rawValue
            cell.textLabel?.text = title
        }
        
        return cell
        
    }
    
    
}
