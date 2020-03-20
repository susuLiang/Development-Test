//
//  MainViewController.swift
//  DevelopmentTest
//
//  Created by Shu Wei Liang on 2020/3/17.
//  Copyright © 2020 Shu Wei Liang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var flowLayout: CustomFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    var postModel: PostModel = PostModel(from: [:])
    var posts: [Post] = []
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        self.callAPI(page: 1)
        self.flowLayout.delegate = self
    }
    
    func callAPI(page: Int) {
        APIManager.shared.getPosts(pageNo: page) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let result):
                self.postModel = result
                self.posts += self.postModel.posts
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print("getPosts error: \(String(describing: error.errorDescription))")
            }
        }
    }
    
    

}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        cell.setCellContent(post: self.posts[indexPath.row])
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(self.collectionView.frame.width - 5 * 2) / 2, height: 170)
    }

}

extension MainViewController: CustomFlowLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.posts[indexPath.row].cover.height > 315 ? 315 : self.posts[indexPath.row].cover.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if postModel.hasMore, self.posts.count < postModel.total, indexPath.row == self.posts.count - 3, !isLoading {
            isLoading = true
            self.callAPI(page: postModel.currentPage + 1)
        }
    }
    
}
