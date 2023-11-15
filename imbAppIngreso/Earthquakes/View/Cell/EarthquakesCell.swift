//
//  EarthquakesCell.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import Foundation
import UIKit

class EarthquakesCell: UITableViewCell {
  
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var mag: UILabel!
    @IBOutlet weak var profundidad: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var contentCard: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setView()
    }
    func setView(){
        self.contentCard.layer.borderWidth = 0.2
        self.contentCard.layer.borderColor = UIColor.gray.cgColor
        self.contentCard.layer.shadowColor = UIColor.gray.cgColor
        self.contentCard.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.contentCard.layer.shadowRadius = 9.0
        self.contentCard.layer.shadowOpacity = 0.5
        
    }

    func setDataCell(title:String,mag:String,profundidad:String,place:String){
        self.title.text = title
        self.mag.text = "Magnitud: \(mag)"
        self.profundidad.text = "Profundidad: \(profundidad)" 
        self.place.text = place
    }
  
}

