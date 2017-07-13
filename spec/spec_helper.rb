require 'rspec-puppet'
require 'puppetlabs_spec_helper/module_spec_helper'

base_dir = File.dirname(File.expand_path(__FILE__))

RSpec.configure do |c|
  c.module_path     = File.join(base_dir, 'fixtures', 'modules')
  c.manifest_dir    = File.join(base_dir, 'fixtures', 'manifests')

  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end
