//
//  AddressCell.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 4.08.2023.
//

import UIKit
import TinyConstraints

class AddressCell:UITableViewCell {
    
    weak var delegate:AddressCellDelegate?
    weak var muhbir:EditDelegate?
    typealias ButtonClosure = (IndexPath)->Void
    var closure:ButtonClosure!
    
    public var indexPath:IndexPath?
    
    private lazy var viewsContent:UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
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
        iv.image = #imageLiteral(resourceName: "location2")
        return iv
    }()
    
    private lazy var lblIsDefault:UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "AvenirNext-Medium", size: 14)
        l.textColor = .black
        l.text = "Varsayılan Teslimat Adresi"
        return l
    }()
    
    private lazy var btnDelete:UIButton = {
        let b = UIButton()
        b.setTitle("Sil", for: .normal)
        b.addTarget(self, action: #selector(btnDeleteTapped), for: .touchUpInside)
        b.setTitleColor(.blue, for: .normal)
        return b
    }()
    
    private lazy var btnEdit:UIButton = {
        let b = UIButton()
        b.setTitle("Edit", for: .normal)
        b.addTarget(self, action: #selector(btnEditTapped), for: .touchUpInside)
        b.setTitleColor(.blue, for: .normal)
        return b
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    //MARK: -- Cell yeniden kullanıma başlamadan önce çalışan method.
    override func prepareForReuse() {
        //defaultViewStack.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        self.frame = self.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowOpacity = 0.2
        
    }
    
    @objc func btnEditTapped(){
        
        guard let muhbir = muhbir else { return }
        guard let indexPath = indexPath else { return }
        muhbir.prensentEditPage(indexPath: indexPath)
    }
    
    @objc func btnDeleteTapped(){
        
        guard let indexPath = indexPath else { return }
        
        //delegate?.deleteCellRow(at: indexPath)
        
        self.closure(indexPath)

    }
    
    public func configure(object:AddressInfo) {
        
        lblName.text = object.name
        lblAddress.text = object.address
        lblStateCity.text = object.state + "/" + object.city
        lblCountry.text = object.country
        lblPhone.text = object.phone
        
        defaultViewStack.isHidden = !object.isDefault

        //MARK: -- Eğer kontrol yapılıp, değer manuel verilecekse prepareForReuse methodu içerisinde ilgili element sıfırlanmalıdır.
//        if object.isDefault {
//            defaultViewStack.isHidden = false
//        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupViews(){
        
        
        contentView.backgroundColor = #colorLiteral(red: 0.9540722104, green: 0.9852410837, blue: 1, alpha: 1)
        contentView.addSubviews(lblName,addressStack,defaultViewStack,btnDelete,btnEdit)
        
        addressStack.addArrangedSubview(lblAddress)
        addressStack.addArrangedSubview(lblStateCity)
        addressStack.addArrangedSubview(lblCountry)
        addressStack.addArrangedSubview(lblPhone)
        
        defaultViewStack.addArrangedSubview(imgDefault)
        defaultViewStack.addArrangedSubview(lblIsDefault)
        
        setupLayout()
    }
    
    private func setupLayout(){
        
        lblName.topToSuperview(offset:16)
        lblName.leadingToSuperview(offset:16)
        lblName.trailingToSuperview(offset:16)
        
        addressStack.topToBottom(of: lblName,offset: 10)
        addressStack.horizontalToSuperview(insets:.left(16) + .right(16))
        addressStack.height(90)
        
        imgDefault.width(20)
        imgDefault.height(20)
        
        defaultViewStack.height(20)
        defaultViewStack.topToBottom(of: addressStack,offset: 10)
        defaultViewStack.leading(to: addressStack)
        
        btnDelete.bottomToSuperview(offset:-16)
        btnDelete.trailingToSuperview(offset:16)
        btnDelete.width(40)
        btnDelete.height(24)
        
        btnEdit.bottomToSuperview(offset:-16)
        btnEdit.trailingToLeading(of: btnDelete,offset: -50)
        btnEdit.width(40)
        btnEdit.height(24)
    }
    
    
}


