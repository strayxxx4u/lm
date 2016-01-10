//
//  DecorationLineView.swift
//  LashMaker
//
//  Created by Alexander Malakhov on 01/01/2016.
//  Copyright (c) 2016 LashMakers.pro All rights reserved.
//

import UIKit

class DecorationLineView: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = UIColor.whiteColor()
        self.backgroundColor = UIColorFromRGB(0xf3f3f4)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       // self.backgroundColor = UIColor.whiteColor()
        self.backgroundColor = UIColorFromRGB(0xf3f3f4)

    }
}
