//
//  DetailViewModel.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class DetailViewModel {
        
    private var item: Item
    
    var name: String {
        return item.name
    }
    
    var description: String {
        return item.description
    }
    
    var cost: Int {
        return item.cost
    }
    
    init(_ item: Item) {
        self.item = item
    }
    
    func renderPdf(_ completion: @escaping (Data) -> Void) {
        
        let pageRect = CGRect(x: 0, y: 0, width: 595, height: 841)

        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
        
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "sparta")
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        let imageString = NSAttributedString(attachment: imageAttachment)
        
        let text = "\n\nName: \(item.name)\nDescription: \(item.description)\nCost: \(item.cost)"
        let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        
        let formatedText = NSAttributedString(string: text, attributes: textAttributes)
        
        let formattedTitle = NSMutableAttributedString(attributedString: imageString)
        formattedTitle.append(formatedText)
        
        let data = renderer.pdfData { ctx in
            ctx.beginPage()
            
            formattedTitle.draw(in: pageRect.insetBy(dx: 50, dy: 50))
        }
        
        completion(data)
        
//        let url = URL(fileURLWithPath: "/Users/vladimir/Documents/")
//        let fileUrl = url.appendingPathComponent("myFile.pdf")
        
//        let path = Bundle.main.bundlePath
        
//        guard let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            print("No path in render PDF")
//            return
//        }
//
////        let fileUrl = URL(fileURLWithPath: path).appendingPathComponent(constants.pdfFileName)
//
//        print(fileUrl)
//
//        do {
//            try data.write(to: fileUrl)
//            completion()
//        } catch let error {
//            print("Error save data: ", error.localizedDescription)
//        }
    }
    

}
