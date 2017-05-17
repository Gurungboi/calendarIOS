//
//  ViewController.swift
//  Calendar3
//
//  Created by Sunil Gurung on 5/16/17.
//  Copyright © 2017 Impactit. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    @IBOutlet weak var lblyear: UILabel!
    @IBOutlet weak var lblmonth: UILabel!
    
    let outsideMonthColor = UIColor(colorWithHexValue: 0xD3D3D3)
    let monthColor = UIColor(colorWithHexValue: 0x000000)
    let selectedMonthColor = UIColor(colorWithHexValue: 0x000000)
    let currentDateSelectedViewColor = UIColor(colorWithHexValue: 0x4e3f5d)
  
    
    let formatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupCalendarView()
        
        
    }

    func setupCalendarView(){
        // Setup Calendar Spacing
        
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        // Setup Label
        calendarView.visibleDates{(visibleDates) in
            
            self.setupViewOfCalendar(from: visibleDates)
        }
       
        
    }
    
    func handleCelltextColor(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? DateViewCell else {return}
        if cellState.isSelected {
        
            validCell.lbldate.textColor = selectedMonthColor
        }
            else
            {
                if cellState.dateBelongsTo == .thisMonth {
                validCell.lbldate.textColor = monthColor
                }
                    else{
                    validCell.lbldate.textColor = outsideMonthColor
                }
            }
            
        }
    

    func handleCellSelected(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? DateViewCell
            else
        {
            return
        }
        if validCell.isSelected{
            validCell.selectedView.isHidden = false
        }
        else{
            validCell.selectedView.isHidden = true
        }

    }
    
    func setupViewOfCalendar(from visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date
        
      
        formatter.dateFormat = "yyyy"
        lblyear.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        lblmonth.text = formatter.string(from: date)
    }
   

}

extension ViewController: JTAppleCalendarViewDataSource{
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2017 12 31")!
        
        let paramaters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return paramaters
    }
    
   
}


extension ViewController: JTAppleCalendarViewDelegate{
    
    //  Dislay the cell
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as!DateViewCell
        cell.lbldate.text = cellState.text

        handleCellSelected(view: cell, cellState: cellState)
        handleCelltextColor(view: cell, cellState: cellState)
        
//        if cellState.isSelected{
//            cell.selectedView.isHidden = false
//        }
//        else{
//            cell.selectedView.isHidden = true
//        }
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//        guard let validCell = cell as? DateViewCell
//            else
//            {
//                return
//            }
         handleCellSelected(view: cell, cellState: cellState)
         handleCelltextColor(view: cell, cellState: cellState)
        //validCell.selectedView.isHidden = false
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//        guard let validCell = cell as? DateViewCell
//            else
//        {
//            return
//        }
         handleCellSelected(view: cell, cellState: cellState)
         handleCelltextColor(view: cell, cellState: cellState)
        //validCell.selectedView.isHidden = true
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        formatter.dateFormat = "yyyy"
        lblyear.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        lblmonth.text = formatter.string(from: date)
    }
}

extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
