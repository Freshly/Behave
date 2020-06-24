Pod::Spec.new do |s|

  s.name         = 'Behave'
  s.version      = '1.0.0'
  s.platform     = :ios
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.requires_arc = true
  s.summary      = 'A library for Behaviour Development'
  s.homepage     = 'https://github.com/Freshly/Behave'
  s.license      = 'MIT (Behave license)'
  s.author       = { 'Derek Bronston' => 'derek.bronston@freshly.com' }
  s.source       = { :git => 'git@github.com:Freshly/Behave.git', :tag => 'v1.0.0' }
  
  s.source_files = 'Behave/Source/*.swift'
  
  s.ios.deployment_target = '10.0'

  s.dependency 'OHHTTPStubs/Swift', '9.0.0'
end