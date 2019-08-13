//
//  CoachCollectionViewController.swift
//  Develop
//
//  Created by Truman, Christopher on 8/8/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit

class CoachCollectionViewController: UICollectionViewController {

    let coaches = Coach.localCoaches()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .lightGray
        collectionView?.registerClass(UICollectionViewCell.self)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coaches.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(UICollectionViewCell.self, indexPath: indexPath)
        let coach = coaches[indexPath.row]

        let props: [KeyPath<Coach, String>] = [\.name, \.company, \.job_title, \.bio]
        for (index, prop) in props.enumerated() {
            let label = UILabel(frame: CGRect(x: 15, y: 30 * index, width: 50, height: 20))
            label.text = coach[keyPath: prop]
            cell.contentView.addSubview(label)
        }
    
        return cell
    }

}
