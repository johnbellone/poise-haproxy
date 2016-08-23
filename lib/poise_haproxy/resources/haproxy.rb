#
# Cookbook: poise-haproxy
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

require 'chef/provider'
require 'chef/resource'
require 'poise_service/service_mixin'

module PoiseHaproxy::Resources
  # @see Haproxy::Resource
  # @since 1.0
  module Haproxy
    # A `haproxy` resource to install and configure an instance of
    # HAProxy.
    # @provides haproxy
    # @action enable
    # @action disable
    # @action start
    # @action stop
    # @action restart
    # @action reload
    # @example
    #   haproxy 'default'
    class Resource < Chef::Resource
      include Poise(container: true, inversion: true)
      provides(:haproxy)
      include PoiseService::ServiceMixin

      # @!attribute config
      # Template content resource for the HAProxy configuration file.
      attribute(:config, template: true, default_source: 'haproxy.conf.erb')
      # @!attribute owner
      # System owner to deploy and run HAProxy as.
      # @return [String, nil, false]
      attribute(:owner, kind_of: [String, NilClass, FalseClass], default: nil)
      # @!attribute group
      # System group to deploy and run HAProxy as.
      # @return [String, nil, false]
      attribute(:group, kind_of: [String, NilClass, FalseClass], default: nil)
      # @!attribute path
      # Absolute path to the HAProxy configuration directory. Default is /etc/haproxy.
      # @return [String]
      attribute(:path, kind_of: String, default: lazy { default_path })
      # @!attribute pidfile
      # Absolute path to the HAProxy pidfile. Default is /var/run/haproxy.pid.
      # @return [String]
      attribute(:pidfile, kind_of: String, default: lazy { default_pidfile })
      # @!attribute version
      # Version of HAProxy to install.
      # @return [String, nil, false]
      attribute(:version, kind_of: [String, NilClass, FalseClass], default: nil)

      # @!attribute confd_path
      # The absolute path to the conf.d/ directory.
      # @return [String]
      def confd_path
        ::File.join(path, 'conf.d')
      end

      # @!attribute config_path
      # The absolute path to the configuration file.
      # @return [String]
      def config_path
        ::File.join(path, 'haproxy.cfg')
      end

      # The path to the `haproxy` binary for this HAProxy installation.
      # @return [String]
      def haproxy_binary
        provider_for_action(:haproxy_binary).haproxy_binary
      end

      private

      # The default path for this installation's configuration root.
      # @api private
      # @return [String]
      def default_path
        haproxy_name_path('/etc/%{name}')
      end

      # The default path for this installation's pidfile.
      # @api private
      # @return [String]
      def default_pidfile
        haproxy_name_path('/var/run/%{name}.pid')
      end

      # Interpolate the name of this HAProxy instance into a path.
      # @api private
      # @return [String]
      def haproxy_name_path(path)
        name = if service_name == 'default'
                 'haproxy'
               else
                 "haproxy-#{service_name}"
               end
        path % {name: name}
      end
    end
  end
end
