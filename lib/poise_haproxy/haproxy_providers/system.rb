#
# Cookbook: poise-haproxy
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#
require 'chef/resource'
require 'poise_haproxy/haproxy_providers/base'

module PoiseHaproxy::HaproxyProviders
  # The provider for `haproxy` to install from the operating system's
  # package manager.
  # @since 1.0
  class System < Base
    provides(:system)

    # @api private
    # @return [true, false]
    def self.provides_auto?(node, _resource)
      node.platform_family?('rhel', 'debian')
    end

    # @api private
    # @return [Hash]
    def self.default_inversion_options(_node, _resource)
      super.merge(package: 'haproxy')
    end

    # Output the value for the HAProxy binary.
    # @return [String]
    def haproxy_binary
      '/usr/sbin/haproxy'
    end

    private

    # @api private
    def install_haproxy
      init_file = file '/etc/init.d/haproxy' do
        action :nothing
      end

      package options[:package] do
        notifies :delete, init_file, :immediately
        if node.platform_family?('debian')
          options '-o Dpkg::Options::=--path-exclude=/etc/*'
        end
        version new_resource.version
      end
    end

    # @api private
    def uninstall_haproxy
      package options[:package] do
        action(platform_family?('debian') ? :purge : :remove)
      end
    end
  end
end
