Pod::Spec.new do |s|
  s.name = 'TvOSCustomizableTableViewCell'
  s.author = 'Zattoo'
  s.version = '1.1.1'
  s.license = 'MIT'
  s.summary = 'Light wrapper of UITableViewCell that allow extra customization for tvOS'
  s.homepage = 'https://github.com/zattoo/TvOSCustomizableTableViewCell'
  s.source = { :git => 'https://github.com/zattoo/TvOSCustomizableTableViewCell.git', :tag => s.version }
  s.swift_version = '5.0'
  s.tvos.deployment_target = '11.0'
  s.source_files = 'Sources/**/*.swift'
  s.dependency 'ZattooGradientView', '~> 1.0.0'
end
