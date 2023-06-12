//
//  KeyboardView.swift
//  NewProjTest
//
//  Created by mac on 2023/6/8.
//

import UIKit
import SnapKit
import GrowingTextView
class KeyboardView: UIView {
    
    /// 输入框
    let m_textField: GrowingTextView = {
        let textView = GrowingTextView()
        textView.placeholder = "请输入内容"
        textView.placeholderColor = UIColor.gray
        return textView
    }()
    /// 发布按钮
    lazy var m_publish: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("发布", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        return btn
    }()
    /// 发布按钮
    lazy var m_exBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("切换键盘", for: .normal)
        btn.setTitleColor(.red, for: .normal)

        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        // 添加输入框和按钮
        addSubview(m_textField)
        addSubview(m_publish)
        
        // 设置约束
        m_textField.translatesAutoresizingMaskIntoConstraints = false
        m_publish.translatesAutoresizingMaskIntoConstraints = false
        m_textField.minHeight = 70.0
        m_textField.maxHeight = 80.0
        m_textField.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(80)
        }
        m_publish.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.snp.bottom).offset(-4)
        }
        
        addSubview(m_exBtn)

        m_exBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-4)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
