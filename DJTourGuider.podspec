Pod::Spec.new do |spec|

  spec.name         = "DJTourGuider"
  spec.version      = "0.0.1"
  spec.summary      = "Its a guider for your iOS application."

  spec.description  = <<-DESC
Through this CocoaPods library, you can helps your app user to guide about how to use your application. 
                   DESC

  spec.homepage     = "https://github.com/DilipJangid-iOS/DJTourGuider"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  spec.license      = { :type => "Apache-2.0", :file => "LICENSE" }
  # spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Dilip Jangid" => "dilipjangidr@gmail.com" }

  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "https://github.com/DilipJangid-iOS/DJTourGuider.git", :tag => "0.0.1" }

  spec.source_files  = "DJTourGuider/**/*.{h,m}"
  spec.exclude_files = "DJTourGuider/Exclude"


  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
