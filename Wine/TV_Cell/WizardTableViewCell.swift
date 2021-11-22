//
//  WizardTableViewCell.swift
//  Wine
//
//  Created by Apple on 13/07/21.
//

import UIKit

class WizardTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageArray = [String] ()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "WizardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WizardCollectionViewCell")
        
        imageArray = ["wine1","wine2","wine1","wine2","wine1"]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WizardCollectionViewCell", for: indexPath) as? WizardCollectionViewCell
    {
    let randomNumber = Int(arc4random_uniform(UInt32(imageArray.count)))
    cell.imageView.image = UIImage(named: imageArray[randomNumber])
    return cell
    }
    return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    let size = CGSize(width: 300, height: 300)
    return size
    }
    
}
