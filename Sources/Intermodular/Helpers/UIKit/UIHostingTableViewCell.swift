//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

class UIHostingTableViewCell<Content: View> : UITableViewCell {
    var contentHostingController: UIHostingController<Content>?
    
    var content: Content? {
        get {
            contentHostingController?.rootView
        } set {
            guard let content = newValue else {
                return
            }
            
            if let contentHostingController = contentHostingController {
                contentHostingController.rootView = content
            } else {
                contentHostingController = UIHostingController(rootView: content)
                
                let view = contentHostingController!.view!
                
                view.translatesAutoresizingMaskIntoConstraints = false
                
                contentView.addSubview(view)
                
                NSLayoutConstraint.activate([
                    view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    view.topAnchor.constraint(equalTo: contentView.topAnchor),
                    view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                ])
            }
        }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension String {
    static let hostingTableViewCellIdentifier = "UIHostingTableViewCell"
}

#endif
