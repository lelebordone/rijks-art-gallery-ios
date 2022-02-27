import UIKit

extension UIView {
    var safeTopAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.topAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.bottomAnchor
    }
    
    func addContentView(_ subView: UIView) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: topAnchor),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor),
            subView.leadingAnchor.constraint(equalTo: leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func addSafeContentView(_ subView: UIView) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: safeTopAnchor),
            subView.bottomAnchor.constraint(equalTo: safeBottomAnchor),
            subView.leadingAnchor.constraint(equalTo: leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func addTopSafeContentView(_ subView: UIView) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: safeTopAnchor),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor),
            subView.leadingAnchor.constraint(equalTo: leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    /// Pins to the subview to its edges with the given margins.
    /// - Parameter subView: The view to be added as a subview.
    /// - Parameter margins: The margins of the subview.
    func addContentViewWithCustomMargins(_ subView: UIView, margins: UIEdgeInsets) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: topAnchor, constant: margins.top),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margins.bottom),
            subView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margins.left),
            subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margins.right)
        ])
    }
}
