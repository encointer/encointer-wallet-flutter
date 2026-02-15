Pod::Spec.new do |s|
  s.name             = 'ew_zk_prover'
  s.version          = '0.1.0'
  s.summary          = 'ZK proof generation for Encointer offline payments.'
  s.homepage         = 'https://github.com/encointer/encointer-wallet-flutter'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Encointer' => 'info@encointer.org' }
  s.source           = { :path => '.' }
  s.platform         = :ios, '13.0'

  s.vendored_frameworks = 'Frameworks/ew_zk_prover.xcframework'

  s.pod_target_xcconfig = {
    'OTHER_LDFLAGS' => '-lew_zk_prover',
    'DEFINES_MODULE' => 'YES',
  }

  # Build script to compile Rust for iOS (requires macOS with Xcode):
  # s.script_phase = {
  #   :name => 'Build Rust library',
  #   :script => 'cd "${PODS_TARGET_SRCROOT}/../rust" && cargo build --target aarch64-apple-ios --release && cp target/aarch64-apple-ios/release/libew_zk_prover.a "${PODS_TARGET_SRCROOT}/"',
  #   :execution_position => :before_compile,
  # }
end
