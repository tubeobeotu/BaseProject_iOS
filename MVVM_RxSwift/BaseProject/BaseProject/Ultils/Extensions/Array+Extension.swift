//
//  Array+Extension.swift
//  AB Branded App
//
//  Created by Nguyen Van Tu on 12/20/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

extension Array
{
    func toString() -> String
    {
        var result = ""
        for item in self
        {
            if let stringItem =  item as? String
            {
                if(result == "")
                {
                    result = stringItem
                }else
                {
                    result = result + "," + "\(stringItem)"
                }
                
            }
            
        }
        return result
    }
}

