//
//  ViewController.swift
//  CustomCalendar
//
//  Created by apple on 13/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var daysCV: UICollectionView!
    @IBOutlet weak var displayDate: UILabel!
    
    var selectedDate = Date()
    var totalSquares = [String]()
    
    var isSelected: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        setMonthView()
        
        let finalDate = CalendarHelper().dayOfMonth(date: selectedDate)//formatter.string(from: selectedDate)
        print(selectedDate, "selected Date", "final date is \(finalDate)")
        
        if totalSquares.contains("\(finalDate)") {
            print("contains")
        }else{
            print("not cointains")
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func setUpCollectionView() {
        
        daysCV.delegate = self
        daysCV.dataSource = self
        
        //Adding spacing to collection view and there are 7 days a week
        let width = ((daysCV.frame.size.width - (7-1)) * 1)
        
        let flowLayout = daysCV.collectionViewLayout as! UICollectionViewFlowLayout
        
        
        if UIScreen.main.bounds.width > 375 {
            flowLayout.itemSize = CGSize(width: width / 7, height: 30)
        }else{
            flowLayout.itemSize = CGSize(width: width / 8, height: 30)
        }
        
        print(width, "CV width", UIScreen.main.bounds.width)
    }

    func setMonthView() {
        
        totalSquares.removeAll()
        
        let dayInMonth = CalendarHelper().dayInMonth(date: selectedDate) //getting day in month
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate) //getting 1st day of the month
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth) //adding spaces to the empty days
        
        var count: Int = 1
        
        while count <= 42 {
            if (count <= startingSpaces || count - startingSpaces > dayInMonth) {
                totalSquares.append("")
            }else{
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        monthLbl.text = CalendarHelper().monthString(date: selectedDate) + " " + CalendarHelper().yearString(date: selectedDate)
        daysCV.reloadData()
    }
    
    //MARK:- Selectors
    
    @IBAction func onTapPreviousMonth(_ sender: Any) {
        isSelected = nil
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func onTapNextmonth(_ sender: Any) {
        isSelected = nil
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = daysCV.dequeueReusableCell(withReuseIdentifier: CalendarCVCell.identifier, for: indexPath) as! CalendarCVCell
        
        cell.currentDay.text = totalSquares[indexPath.item]
        
        if isSelected == indexPath.item {
            cell.currentDay.textColor = .systemBlue
        }else {
            cell.currentDay.textColor = .black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(totalSquares[indexPath.item], monthLbl.text)
        
        isSelected = indexPath.row
        let value = "\(totalSquares[indexPath.item]) \(monthLbl.text!)"
        print(value)
        self.displayDate.text = "Your selected date is \(value)"
        daysCV.reloadData()
    }
    
}
