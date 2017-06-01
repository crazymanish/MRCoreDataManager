Pod::Spec.new do |s|
  s.name         = "MRCoreDataManager"
  s.version      = "1.0.0"
  s.summary      = "A framework to easily perform coredata operations. i.e Add, Fetch, Update, Delete."
  s.platform     = :ios, "10.0"
  s.author       = 'Manish Rathi - manishrathi19902013@gmail.com'
  s.license	     = { :type => 'Manish', :text => <<-LICENSE
                        © Manish Rathi, 2017. All rights reserved.
                     LICENSE
                   }
  s.homepage     = 'https://github.com/crazymanish/MRCoreDataManager'
  s.social_media_url   = "https://github.com/crazymanish"
  s.source       = { :git => "https://github.com/crazymanish/MRCoreDataManager", :tag => '1.0.0'}
  s.source_files  = ["Source/MRCoreDataManager/MRCoreDataManager/**/*.{h,swift}"]
  s.requires_arc = true

end
