
func callOCRSpace() {
		// Create URL request
		var url: NSURL = NSURL(string: "https://api.ocr.space/Parse/Image")
		var request: NSMutableURLRequest = NSMutableURLRequest.requestWithURL(url)
		request.HTTPMethod = "POST"
		var boundary: String = "randomString"
		request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
		var session: NSURLSession = NSURLSession.sharedSession()
		
		// Image file and parameters
		var imageData: NSData = UIImageJPEGRepresentation(UIImage.imageNamed("yourImage"), 0.6)
		var parametersDictionary: [NSObject : AnyObject] = NSDictionary(objectsAndKeys: "yourKey","apikey","True","isOverlayRequired","eng","language",nil)
		
		// Create multipart form body
		var data: NSData = self.createBodyWithBoundary(boundary, parameters: parametersDictionary, imageData: imageData, filename: "yourImage.jpg")
		request.HTTPBody = data
		
		// Start data session
		var task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (data: NSData, response: NSURLResponse, error: NSError) in 
			var myError: NSError
			var result: [NSObject : AnyObject] = NSJSONSerialization.JSONObjectWithData(data, options: kNilOptions, error: &myError)
			// Handle result
		
		})
		task.resume()
}
	
func createBodyWithBoundary(boundary: String, parameters parameters: [NSObject : AnyObject], imageData data: NSData, filename filename: String) -> NSData {
	    
		var body: NSMutableData = NSMutableData.data()
		
		if data {
			body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding))
			body.appendData("Content-Disposition: form-data; name=\"\("file")\"; filename=\"\(filename)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding))
			body.appendData("Content-Type: image/jpeg\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding))
			body.appendData(data)
			body.appendData(".dataUsingEncoding(NSUTF8StringEncoding))
		}
		
		for key in parameters.allKeys {
			body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding))
			body.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding))
			body.appendData("\(parameters[key])\r\n".dataUsingEncoding(NSUTF8StringEncoding))
		}
		
		body.appendData("--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding))
		return body
}
