#
# Cookbook: poise-haproxy
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

require 'chef/provider'

require 'poise_service/service_mixin'

module PoiseHaproxy::HaproxyProviders
  # The provider base class for `haproxy`.
  # @see PoiseHaproxy::Resources::PoiseHaproxy::Resource
  # @provides haproxy
  class Base < Chef::Provider
    include Poise(inversion: :haproxy)
    include PoiseService::ServiceMixin

    # @return [void]
    def action_enable
      notifying_block do
        install_haproxy
        create_etc_directory
        create_directory
      end
      super
    end

    # @return [void]
    def action_disable
      super
      notifying_block do
        uninstall_haproxy
        delete_directory
        delete_etc_directory
      end
    end

    # @abstract
    # @return [String]
    def haproxy_binary
      raise NotImplementedError
    end

    private

    # @abstract
    def install_haproxy
      raise NotImplementedError
    end

    # @abstract
    def uninstall_haproxy
      raise NotImplementedError
    end

    # @api private
    def create_etc_directory
      directory new_resource.path do
        owner new_resource.owner
        group new_resource.group
        mode '0700'
      end
    end

    # @api private
    def create_directory
      directory new_resource.directory do
        owner new_resource.owner
        group new_resource.group
        mode '0700'
      end
    end

    # @api private
    def delete_etc_directory
      create_directory.tap do |r|
        r.action(:delete)
        r.recursive(true)
      end
    end

    # @api private
    def delete_directory
      create_service_directory.tap do |r|
        r.action(:delete)
        r.recursive(true)
      end
    end

    def service_options(r)
      configs = ['-f', r.config.path]
      r.parent.subresources.keep_if { |c| c.is_a?(PoiseHaproxy::Resources::HaproxyConfig::Resource) }.each do |config|
        configs << ['-f', config.path]
      end

      r.command([haproxy_binary, configs].flatten.join(' '))
      r.user(new_resource.owner)
    end
  end
end
