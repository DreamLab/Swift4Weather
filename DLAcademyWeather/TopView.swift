//
//  TopView.swift
//  DLAcademyWeather
//
//  Created by Szczęsny Kamil on 03.07.2017.
//  Copyright © 2017 Szczęsny Kamil. All rights reserved.
//

import UIKit

@IBDesignable class TopView: UIView {

    var contentView : UIView?
    
    // Outlets
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var pictogram: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var feelTemp: UILabel!
    @IBOutlet weak var actualTemp: UILabel!
    @IBOutlet weak var changesInTemp: UILabel!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        guard let contentView = loadViewFromNib() else {
            return
        }
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func prepareView(with forecast: Forecast){
        // Tutaj nadpisujemy defaultowe wartości w widoku
    }

}
