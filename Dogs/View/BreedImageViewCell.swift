//
//  BreedImageViewCell.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/15/22.
//

import UIKit

class BreedImageViewCell: UITableViewCell {
    
    @IBOutlet var breedImageView: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var isFavourite: Bool = false
    var breed: Breed?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(_ breed: Breed){
        self.breed = breed
        let thubnailImage = UIImage(named: "placeholder")
        imageView?.loadImageFrom(breed.url, thubnailImage)
        favouriteButton.isSelected = isFavourite
    }

}

//MARK: - Button Clicks
extension BreedImageViewCell{
    
    @IBAction func favouriteButtonClicked(_ sender: Any) {
        isFavourite.toggle()
        favouriteButton.isSelected = isFavourite
        if let breed = breed {
            ManageFavourites.shared.markFavourite(breed)
        }
    }
}


