Pod::Spec.new do |s|
  s.name = 'CLScanQrCode'
  s.version = '1.0.0'
  s.swift_version = '4.0'
  s.license = 'MIT'
  s.summary = 'This is a CLScanQrCode'
  s.homepage = 'https://github.com/Darren-chenchen/CLScanQrCode.git'
  s.authors = { 'Darren-chenchen' => '1597887620@qq.com' }
  s.source = { :git => 'https://github.com/Darren-chenchen/CLScanQrCode.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'CLScanQrCode/CLScanQrCode/**/*.swift'
  s.resource_bundles = { 
	'CLScanQrCode' => ['CLScanQrCode/CLScanQrCode/Images/**/*.png','CLScanQrCode/CLScanQrCode/**/*.{xib,storyboard}','CLScanQrCode/CLScanQrCode/**/*.{lproj,strings}']
  }

  s.dependency 'IDDialog'

end
