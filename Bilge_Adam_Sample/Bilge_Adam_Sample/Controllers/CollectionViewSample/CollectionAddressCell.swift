//
//  CollectionAddressCell.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 7.08.2023.
//

import UIKit
import TinyConstraints

class CollectionAddressCell: UICollectionViewCell {
    
    private lazy var lblName:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        return label
    }()
    
    private lazy var addressStack:UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.axis = .vertical
        sv.spacing = 0
        return sv
    }()
    
    private lazy var lblAddress:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        return label
    }()
    
    private lazy var lblStateCity:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        return label
    }()
    
    private lazy var lblCountry:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        return label
    }()
    
    private lazy var lblPhone:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        return label
    }()
    
    private lazy var defaultViewStack:UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        sv.distribution = .fillProportionally
        sv.isHidden = true
        return sv
    }()
    
    private lazy var imgDefault:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "leaves")
        return iv
    }()
    
    private lazy var lblIsDefault:UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "AvenirNext-Medium", size: 14)
        l.textColor = .black
        l.text = "Varsayılan Teslimat Adresi"
        return l
    }()
    
    private lazy var lblCableType:UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "AvenirNext-Medium", size: 14)
        l.textColor = .black
        l.text = "Varsayılan Teslimat Adresi"
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupViews()
    }
    
    public func configure(object:ChargerStation) {
        
        lblName.text = object.stationName
        lblAddress.text = "Kadıköy - İstanbul"
        
        var strCable = ""
        object.cableType.forEach({ item in
            
            strCable += "\(item.rawValue),"
        })
        
        lblCableType.text = strCable
    }
    
    private func setupViews(){
        
        self.contentView.addSubviews(lblName,lblAddress,lblCableType,imgDefault)
        self.contentView.backgroundColor = .red
        setupLayout()
    }
    
    private func setupLayout(){
        
        lblName.topToSuperview(offset:16)
        lblName.leadingToSuperview(offset:8)
        
        lblAddress.topToBottom(of: lblName,offset: 4)
        lblAddress.leadingToSuperview(offset:8)
        
        lblCableType.bottomToSuperview(offset:-8)
        lblCableType.centerXToSuperview()
        
        imgDefault.edgesToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
