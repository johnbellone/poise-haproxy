require 'spec_helper'

describe PoiseHaproxy::Resources::Haproxy do
  let(:haproxy_version) { '1.6' }
  let(:haproxy_resource) { chef_run.haproxy('default') }
  step_into(:haproxy)

  def service_resource(name)
    chef_run.haproxy(name).provider_for_action(:enable).send(:service_resource)
  end

  context 'action :enable' do
    recipe do
      haproxy 'default'
    end

    let(:service_resource) { chef_run.haproxy('default').provider_for_action(:enable).send(:service_resource) }
    it { is_expected.to create_directory '/etc/haproxy' }
    it { is_expected.to create_directory '/etc/haproxy/conf.d' }
    it { is_expected.to create_directory '/var/lib/haproxy' }
    it { expect(service_resource.command).to eq '/usr/sbin/haproxy -c /etc/haproxy/haproxy.cfg' }

    context 'with a different name' do
      recipe do
        haproxy 'duex'
      end

      let(:service_resource) { chef_run.haproxy('duex').provider_for_action(:enable).send(:service_resource) }
      it { is_expected.to create_directory '/etc/haproxy-duex' }
      it { is_expected.to create_directory '/etc/haproxy-deux/conf.d' }
      it { is_expected.to create_directory '/var/lib/haproxy-deux' }
      it { expect(service_resource.command).to eq '/usr/sbin/haproxy -c /etc/haproxy-deux/haproxy.cfg' }
    end
  end

  context 'action :disable' do
    recipe do
      haproxy 'default'
    end

    it { is_expected.to delete_directory('/etc/haproxy').with(recursive: true) }
    it { is_expected.to delete_directory('/var/lib/haproxy').with(recursive: true) }

    context 'with second instance' do
      recipe do
        haproxy 'default'
        haproxy 'deux' do
          action :disable
        end
      end

      it { is_expected.to delete_directory('/etc/haproxy-deux').with(recursive: true) }
      it { is_expected.not_to delete_directory('/etc/haproxy') }
      it { is_expected.to delete_directory('/var/lib/haproxy-deux').with(recursive: true) }
      it { is_expected.not_to delete_directory('/var/lib/haproxy') }
    end
  end
end
