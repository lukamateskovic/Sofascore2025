import UIKit

extension UIImageView {
    func load(urlString: String?) {
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
            self.image = nil 
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}

