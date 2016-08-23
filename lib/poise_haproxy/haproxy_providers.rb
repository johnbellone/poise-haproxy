#
# Cookbook: poise-haproxy
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

require 'chef/platform/provider_priority_map'

require 'poise_haproxy/haproxy_providers/dummy'
require 'poise_haproxy/haproxy_providers/system'

module PoiseHaproxy
  # Inversion providers for installation of HAProxy.
  # @since 1.0
  module HaproxyProviders
    Chef::Platform::ProviderPriorityMap.instance.priority(:haproxy, [
      PoiseHaproxy::HaproxyProviders::Dummy,
      PoiseHaproxy::HaproxyProviders::System
    ])
  end
end
