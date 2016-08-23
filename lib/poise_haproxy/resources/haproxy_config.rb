#
# Cookbook: poise-haproxy
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

require 'poise'

module PoiseHaproxy::Resources
  # @see HaproxyConfig::Resource
  # @since 1.0
  module HaproxyConfig
    # @provides haproxy_config
    # @action create
    # @action delete
    class Resource < Chef::Resource
      include Poise(parent: :haproxy, fused: true)
      provides(:haproxy_config)

      attribute('', template: true, default_source: 'haproxy.cfg.erb')

      action(:create) do
        file new_resource.path do
          content new_resource.content
          owner new_resource.owner
          group new_resource.group
          mode new_resource.mode
        end
      end

      action(:delete) do
        file new_resource.path do
          action :delete
        end
      end
    end
  end
end
