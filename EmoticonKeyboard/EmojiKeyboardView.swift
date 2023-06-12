//
//  EmojiKeyboardView.swift
//  NewProjTest
//
//  Created by mac on 2023/6/10.
//

import Foundation

class EmojiKeyboardView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let delete = "⌫"
   

    let emojis:[String] = {
        if let dict =  PlistLoader.loadPlist(name: "EmojisList"), let strs = dict["lama"] as? [String] {
            return strs
        }
        return [""]
    }()
    let emojisPerPage = 20
    let deleteEmoji = "⌫"
    var m_deleteClosure: (() -> Void)?
    var m_insertEmojClosure: ((String) -> Void)?

    let collectionView: UICollectionView = {
        let layout = HorizontalPageFlowlayout(rowCount: 3, itemCountPerRow: 7)!
        layout.scrollDirection = .horizontal
        layout.setColumnSpacing(0, rowSpacing: 30, edgeInsets: UIEdgeInsets(top: 21, left: 0, bottom: 0, right: 0))
        
        
 
            layout.itemSize = CGSizeMake(32, 32)
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.keyboardDismissMode = .none
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.backgroundColor = .white
        return pageControl
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    
    func setupSubviews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: "EmojiCell")
        
        addSubview(collectionView)
        addSubview(pageControl)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        let numberOfPages = Int(ceil(Double(emojis.count) / Double(emojisPerPage)))
        pageControl.numberOfPages = numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count + 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as! EmojiCell
        
        let pageIndex = indexPath.item / (emojisPerPage + 1)
        let indexInPage = indexPath.item % (emojisPerPage + 1)
        let emojiIndex = pageIndex * emojisPerPage + indexInPage
        if indexInPage == emojisPerPage {
            cell.emojiLabel.text = deleteEmoji
        } else if emojiIndex < emojis.count {
            cell.emojiLabel.text =  emojis[emojiIndex]  
        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let screenWidth =  bounds.width
//        let screenHeight =  bounds.height
//        let numberOfColumns: CGFloat = 7
//        let numberOfRows: CGFloat = 3
//        let cellWidth = screenWidth / numberOfColumns
//        let cellHeight = screenHeight / numberOfRows - 30
//        return CGSize(width: cellWidth, height: cellHeight)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pageIndex = indexPath.item / (emojisPerPage + 1)
        let indexInPage = indexPath.item % (emojisPerPage + 1)
        let emojiIndex = pageIndex * emojisPerPage + indexInPage
        
        if indexInPage == emojisPerPage {
            m_deleteClosure?()
        } else if emojiIndex < emojis.count {
            let selectedEmoji =  emojis[emojiIndex]
            m_insertEmojClosure?(selectedEmoji  )
        } else if emojiIndex >= emojis.count {
            m_insertEmojClosure?( emojis.last! )
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        pageControl.currentPage = currentPage
    }
}
class EmojiCell: UICollectionViewCell {
    let emojiLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(emojiLabel)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
