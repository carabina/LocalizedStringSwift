Pod::Spec.new do |s|
  s.name         = "LocalizedStringSwift"
  s.version      = "1.0.0"
  s.summary      = "Simple Localization in Swift"
  s.description  = <<-DESC
                            - Using NSLocalizedString more simply.
                   DESC

  s.homepage     = "https://github.com/digitrick/LocalizedStringSwift"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = "digitrick"
  s.social_media_url   = "http://twitter.com/digitrick"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/digitrick/LocalizedStringSwift.git", :tag => "1.0.0" }
  s.source_files  = "LocalizedStringSwift/**/*.swift"
  s.requires_arc = true
end
