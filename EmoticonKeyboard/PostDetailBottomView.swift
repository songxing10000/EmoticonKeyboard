//
//  PostDetailBottomView.swift
//  NewProjTest
//
//  Created by mac on 2023/6/8.
//

import UIKit
import SwiftHEXColors

class PostDetailBottomView: UIView {
    lazy var m_replayBtn: UIButton = {
        
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = UIColor(hex: 0xEDEDED)
        btn.setTitle("恶言伤人心", for: .normal)
        btn.setTitleColor(UIColor(hex: 0xC2C2C2), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 10) 
        btn.contentHorizontalAlignment = .left
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        
        return btn
    }()
    private lazy var hLine: UIView = {

        let line = UIView()
        line.isUserInteractionEnabled = false
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(hex: 0xF0F0F0)
         
        return line
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    func setupSubviews() {
        


        addSubview(hLine)
        hLine.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        
        
 

        addSubview(m_replayBtn)
        m_replayBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

    }
}
