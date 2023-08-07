//
//  CollectionViewSampleVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 7.08.2023.
//

import UIKit
import SnapKit

class CollectionViewSampleVC: UIViewController {

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
    
    private lazy var collectionView:UICollectionView = {
        
        //MARK: -- CollectionView arayüzü için sağlanan layout protocolü.
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        cv.delegate = self
        cv.dataSource = self
        cv.register(CollectionAddressCell.self, forCellWithReuseIdentifier: "AddressCellItem")
        return cv
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews(){
        
        self.view.backgroundColor = .white
        self.view.addSubviews(collectionView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        collectionView.snp.makeConstraints({ cv in
            cv.edges.equalToSuperview()
        })
    }
   

}


extension CollectionViewSampleVC:UICollectionViewDelegateFlowLayout {
    
    
    //MARK: -- Her bir item için ebatları belirttiğimiz layout methodu.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = CGSize(width: (collectionView.frame.width - 48) / 2, height: 150)
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
