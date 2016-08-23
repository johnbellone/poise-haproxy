require 'spec_helper'

describe PoiseHaproxy::HaproxyProviders::Dummy do
  let(:haproxy_resource) { chef_run.haproxy('dummy') }
  step_into(:haproxy)
  recipe do
    haproxy 'dummy' do
      provider :dummy
    end
  end

  describe '#haproxy_binary' do
    subject { haproxy_resource.haproxy_binary }
    it { is_expected.to eq '/usr/sbin/haproxy' }
  end

  describe 'action :disable' do
    recipe do
      haproxy 'dummy' do
        provider :dummy
        action :disable
      end
    end

    it { chef_run }
  end
end
