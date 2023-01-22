
import Foundation
import UIKit


class TControl: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { _ in
            self.collectionViewLayout.invalidateLayout()
            let indexPath = IndexPath(item: self.pageControl.currentPage,
                                      section: 0)
            self.collectionView.scrollToItem(at: indexPath,
                                             at: .centeredHorizontally,
                                             animated: true)
        }
    }
    
    let pages = [
        Page(screenName: "google",
             title: "Google",
             information: "Google is an American multinational technology company focusing on search engine technology, online advertising, cloud computing, computer software, quantum computing, e-commerce, artificial intelligence, and consumer electronics. "),
        Page(screenName: "amazon",
             title: "Amazon",
             information: "Amazon.com, Inc. is an American multinational technology company focusing on e-commerce, cloud computing, online advertising, digital streaming, and artificial intelligence. "),
        Page(screenName: "facebook",
             title: "Facebook",
             information: "Facebook is a website which allows users, who sign-up for free profiles, to connect with friends, work colleagues or people they don't know, online. It allows users to share pictures, music, videos, and articles, as well as their own thoughts and opinions with however many people they like. "),
        Page(screenName: "instagram",
             title: "Instagram",
             information: "Instagram is a photo and video sharing social networking service owned by American company Meta Platforms. The app allows users to upload media that can be edited with filters and organized by hashtags and geographical tagging. "),
        Page(screenName: "apple",
             title: "Apple",
             information: "Apple Inc. is an American multinational technology company headquartered in Cupertino, California, United States. Apple is the largest technology company by revenue (totaling US$365.8 billion in 2021) and, as of June 2022, is the world's biggest company by market capitalization. ")
    ]
    
    private let btnBefore: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Before",
                        for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(.redColor,
                             for: .normal)
        button.addTarget(self,
                         action: #selector(beforeClick),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func beforeClick() {
        
        pageControl.currentPage -= 1
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: true)
    }
    
    private let btnNext: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next",
                        for: .normal)
        button.setTitleColor(.redColor,
                             for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(nextClick),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func nextClick() {
        
        pageControl.currentPage += 1
        let indexPath = IndexPath(item: pageControl.currentPage,
                                  section: 0)
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: true)
        // pageControl.numberOfPages
    }
    
    private lazy var pageControl: UIPageControl = {
        let pControl = UIPageControl()
        pControl.currentPage = 0
        pControl.numberOfPages = pages.count
        pControl.currentPageIndicatorTintColor = UIColor.redColor
        pControl.pageIndicatorTintColor = UIColor.red2Color
        return pControl
    }()
    
    fileprivate func buttonControl() {
        let buttonStackView = UIStackView(arrangedSubviews: [btnBefore, pageControl, btnNext])
        view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.distribution = .fillEqually
        // bottonStackView.axis = .horizontal
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonControl()
        collectionView.register(PageCell.self,
                                forCellWithReuseIdentifier: "cell")
        collectionView.isPagingEnabled = true
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PageCell
        cell.page = pages[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

