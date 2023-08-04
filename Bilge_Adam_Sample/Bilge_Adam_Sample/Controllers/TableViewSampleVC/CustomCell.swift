//
//  CustomCell.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 4.08.2023.
//

import UIKit

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
