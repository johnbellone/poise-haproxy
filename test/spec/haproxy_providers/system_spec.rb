require 'spec_helper'

describe PoiseHaproxy::HaproxyProviders::System do
  let(:haproxy_version) { '1.6' }
  let(:default_attributes) { {poise_haproxy_version: haproxy_version} }
  let(:haproxy_resource) { chef_run.haproxy('system') }
  step_into(:haproxy)
  recipe do
    haproxy 'system' do
      provider :system
      version node['poise_haproxy_version']
    end
  end

  it { expect(haproxy_resource.provider_for_action(:enable)).to be_a described_class }
  it { is_expected.to remove_package('haproxy').with(version: haproxy_version) }

  context 'action :disable' do
    recipe do
      haproxy 'default' do
        provider :system
        version node['poise_haproxy_version']
        action :disable
      end
    end

    it { expect(haproxy_resource.provider_for_action(:disable)).to be_a described_class }
    it { is_expected.to remove_package('haproxy') }
  end
end
