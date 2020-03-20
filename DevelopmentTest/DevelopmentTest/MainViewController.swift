//
//  MainViewController.swift
//  DevelopmentTest
//
//  Created by Shu Wei Liang on 2020/3/17.
//  Copyright © 2020 Shu Wei Liang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var postModel: PostModel = PostModel(from: [:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        APIManager.shared.getPosts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.postModel = result
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print("getPosts error: \(String(describing: error.errorDescription))")
            }
        }
        
        if let layout = self.collectionView.collectionViewLayout as? CustomFlowLayout {
            layout.delegate = self
        }
    }

}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        cell.setCellContent(post: postModel.posts[indexPath.row])
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

}

extension MainViewController: CustomFlowLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(postModel.posts[indexPath.row].cover.height > 315 ? 315 : postModel.posts[indexPath.row].cover.height)
    }
    
}
