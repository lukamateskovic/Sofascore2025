import UIKit

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
