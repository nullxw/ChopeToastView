Pod::Spec.new do |s|
  s.ios.deployment_target = '7.0'
  s.author       = { 'Chope' => 'yoonhg2002@gmail.com' }
  s.name         = 'ChopeToastView'
  s.version      = '0.1'
  s.homepage     = 'https://github.com/chope-yoonhg84/ChopeLibrary'
  s.source       = { :git => 'git@github.com:chope-yoonhg84/ChopeLibrary.git'}
  s.source_files = 'ChopeToastView/*.{h,m}'
  s.requires_arc = true
end