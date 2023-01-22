

import UIKit

class PageCell: UICollectionViewCell {
    
    var page : Page? {
        didSet {
            guard let page = page else { return }
            googleImage.image = UIImage(named: page.screenName)
            
            let attrText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
            attrText.append(NSAttributedString(string: "\n\n\(page.information)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.darkGray]))
            companyName.attributedText = attrText
            companyName.textAlignment = .center
        }
    }
    
    private let googleImage: UIImageView = {
         let imageView = UIImageView(image: UIImage(named: "google"))
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit
         return imageView
     }()
     
    private let companyName: UITextView = {
         let textView = UITextView()
         
         textView.translatesAutoresizingMaskIntoConstraints = false
         textView.isEditable = false
         textView.isScrollEnabled = false
         return textView
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private func configureLayout(){
        
        let topView = UIView()
        addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(googleImage)
        addSubview(companyName)
        NSLayoutConstraint.activate([
            
            topView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            topView.widthAnchor.constraint(equalTo: widthAnchor),
            
            googleImage.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            googleImage.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            googleImage.heightAnchor.constraint(equalTo: topView.heightAnchor, constant: 0.6),
            googleImage.widthAnchor.constraint(equalToConstant: 200),
            googleImage.heightAnchor.constraint(equalToConstant: 200),

            companyName.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10),
            companyName.leftAnchor.constraint(equalTo: leftAnchor ,constant: 30),
            companyName.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            companyName.bottomAnchor.constraint(equalTo: bottomAnchor),
        
             ])
        
    }
}
