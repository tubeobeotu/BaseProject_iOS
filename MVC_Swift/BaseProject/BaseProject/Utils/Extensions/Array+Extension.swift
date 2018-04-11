//
//  Array+Extension.swift
//

import Foundation

extension Array {
    
}

extension Array where Element: Equatable  {
	mutating func delete(element: Iterator.Element) {
		self = self.filter{$0 != element }
	}
}
