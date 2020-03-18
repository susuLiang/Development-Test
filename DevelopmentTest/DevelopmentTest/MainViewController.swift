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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        APIManager.shared.getPosts {
            
        }
    }

}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath)
        return cell
    }
    
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
}
