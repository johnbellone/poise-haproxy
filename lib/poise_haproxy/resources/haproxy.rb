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
    # A `haproxy` resource to install and configure HAProxy.
    # @provides haproxy
    # @action enable
    # @action disable
    # @action start
    # @action stop
    # @action restart
    # @action reload
    # @example
    #   haproxy 'haproxy'
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
    end
  end
end
