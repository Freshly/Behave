Pod::Spec.new do |s|

  s.name         = 'Behave'
  s.version      = '1.0.21'
  s.platform     = :ios
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.requires_arc = true
  s.summary      = 'A library for Behaviour Driven Development'
  s.homepage     = 'https://github.com/Freshly/Behave'
  s.license      = 'MIT (Behave license)'
  s.author       = { 'Derek Bronston' => 'derek.bronston@freshly.com', 'Denis Efimov' => 'denis.efimov@freshly.com' }
  s.source       = { :git => 'https://github.com/Freshly/Behave.git', :tag => '1.0.20' }

  s.source_files = 'Behave/Source/*.swift'

  s.dependency 'OHHTTPStubs/Swift', '9.1.0'
end
