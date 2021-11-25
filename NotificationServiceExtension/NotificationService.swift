import UserNotifications
import FirebaseMessaging
class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        if let bestAttemptContent = bestAttemptContent { // Modify the notification content here...
            let apsData = request.content.userInfo["aps"] as! [String : Any]
            let alertData = apsData["alert"] as! [String : Any]
            let imageData = request.content.userInfo["fcm_options"] as! [String : Any]
//            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
//            bestAttemptContent.body = "\(bestAttemptContent.body) [modified]"
            guard let urlImageString = imageData["image"] as? String else {
                contentHandler(bestAttemptContent)
                return
            }
            if let newsImageUrl = URL(string: urlImageString) {
                guard let imageData = try? Data(contentsOf: newsImageUrl)
                else {
                    contentHandler(bestAttemptContent)
                    return
                }
                guard let attachment = UNNotificationAttachment.saveImageToDisk(fileIdentifier: "newsImage.jpg", data: imageData as NSData, options: nil) else {
                    contentHandler(bestAttemptContent)
                    return
                }
                bestAttemptContent.attachments = [ attachment ]
            }
            Messaging.serviceExtension().populateNotificationContent(bestAttemptContent, withContentHandler: self.contentHandler!)
            contentHandler(bestAttemptContent)
            
        }
    }
    
    
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
}

@available(iOSApplicationExtension 10.0, *)
extension UNNotificationAttachment {
    
    static func saveImageToDisk(fileIdentifier: String, data: NSData, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
        let fileManager = FileManager.default
        let folderName = ProcessInfo.processInfo.globallyUniqueString
        let folderURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(folderName, isDirectory: true)
        
        do {
            try fileManager.createDirectory(at: folderURL!, withIntermediateDirectories: true, attributes: nil)
            let fileURL = folderURL?.appendingPathComponent(fileIdentifier)
            try data.write(to: fileURL!, options: [])
            let attachment = try UNNotificationAttachment(identifier: fileIdentifier, url: fileURL!, options: options)
            return attachment
        } catch let error {
            print("error \(error)")
        }
        
        return nil
    }
}
