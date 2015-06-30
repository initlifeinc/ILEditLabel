Pod::Spec.new do |s|
  s.name = 'ILEditLabel'
  s.version = '0.0.1'
  s.summary = 'a copy & edit label for ios'
  s.homepage = 'https://github.com/initlifeinc/ILEditLabel'
  s.license = 'Apache License 2.0'
  s.author = { 'initlifeinc' => 'initlife.inc@gmail.com' }
  s.source = { :git => 'https://github.com/initlifeinc/ILEditLabel.git', :tag => '0.0.1' }
  s.requires_arc = true
  s.exclude_files = 'src/*'
end