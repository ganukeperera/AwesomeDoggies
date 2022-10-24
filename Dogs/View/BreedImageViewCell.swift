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
    @IBOutlet weak var breedNameLabel: UILabel!
    @IBOutlet weak var subBreedNameLabel: UILabel!
    @IBOutlet weak var breedNameHeightConstraints: NSLayoutConstraint!
    
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
    
    func setup(_ breed: Breed, showLabels: Bool){
        self.breed = breed
        let thubnailImage = UIImage(named: "placeholder")
        breedImageView?.loadImageFrom(breed.url, thubnailImage)
        favouriteButton.isSelected = isFavourite
        if showLabels {
            self.breedNameLabel.text = breed.breed.capitalized
            self.subBreedNameLabel.text = breed.subBreed?.capitalized ?? ""
        }
        breedImageView.layer.cornerRadius = 20.0
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


