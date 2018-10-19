//
//  Int+Extension.swift
//

extension Int {
    
    func toBool() -> Bool {
        switch self {
        case 0:
            return false
        case 1:
            return true
        default:
            return false
        }
    }
    
    func toString() -> String {
        return "\(self)"
    }
    
    func isZero() -> Bool {
        guard self == 0 else {
            return false
        }
        
        return true
    }
}
