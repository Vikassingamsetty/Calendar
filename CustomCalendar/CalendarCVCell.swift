//
//  CalendarCVCell.swift
//  CustomCalendar
//
//  Created by apple on 13/03/21.
//

import UIKit

class CalendarCVCell: UICollectionViewCell {
    
    class var identifier: String {
        return "\(self)"
    }
    
    @IBOutlet weak var currentDay: UILabel!
    
}
