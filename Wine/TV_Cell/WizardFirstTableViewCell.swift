//
//  WizardFirstTableViewCell.swift
//  Wine
//
//  Created by Apple on 13/07/21.
//

import UIKit

class WizardFirstTableViewCell: UITableViewCell , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageArray = [String] ()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "WizardFirstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WizardFirstCollectionViewCell")
                
        imageArray = ["wine1"]
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
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WizardFirstCollectionViewCell", for: indexPath) as? WizardFirstCollectionViewCell
    {
    let randomNumber = Int(arc4random_uniform(UInt32(imageArray.count)))
    cell.imageView.image = UIImage(named: imageArray[randomNumber])
    return cell
    }
    return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: CurrentDevice.ScreenWidth, height: 400)
    return size
    }
}
