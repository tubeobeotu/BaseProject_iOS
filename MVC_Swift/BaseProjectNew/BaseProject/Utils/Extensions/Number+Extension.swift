import Foundation

extension Double
{
    func convertToShortString() -> String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.positiveFormat = "0.0###E0"
        formatter.exponentSymbol = "e"
        formatter.decimalSeparator = "."
        if let scientificFormatted = formatter.string(for: self) {
            return scientificFormatted
        }
        return "0"
    }
}

