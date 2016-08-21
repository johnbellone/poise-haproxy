#
# Cookbook: poise-haproxy
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

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
      end

      notifying_block do
        create_directory
        create_confd_directory
        create_var_directory
        write_config
      end
      super
    end

    # @return [void]
    def action_disable
      super
      notifying_block do
        uninstall_haproxy
        delete_directory
        delete_var_directory
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

    def write_config
      file new_resource.config_path do
        content new_resource.config_content
        owner new_resource.owner
        group new_resource.group
        mode '0600'
        notifies :reload, new_resource, :immediately
        verify ''
      end
    end

    def create_directory
      directory new_resource.path do
        owner new_resource.owner
        group new_resource.group
        mode '0700'
      end
    end

    def create_confd_directory
      directory new_resource.confd_path do
        owner new_resource.owner
        group new_resource.group
        mode '0700'
      end
    end

    def create_var_directory
      directory new_resource.var_path do
        owner new_resource.owner
        group new_resource.group
        mode '0700'
      end
    end

    def delete_directory
      create_directory.tap do |r|
        r.action(:delete)
        r.recursive(true)
      end
    end

    def delete_var_directory
      create_var_directory do |r|
        r.action(:delete)
        r.recursive(true)
      end
    end

    def service_options(r)
      r.command([haproxy_binary].flatten.join(' '))
      r.user(new_resource.owner)
    end
  end
end
