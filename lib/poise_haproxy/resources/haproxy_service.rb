#
# Cookbook: poise-haproxy
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

module PoiseHaproxy::Resources
  # @see HaproxyService::Resource
  # @since 1.0
  module HaproxyService
    class Resource < Chef::Resource
      include Poise(parent: :haproxy)
      provides(:haproxy_service)
      actions(:enable, :disable, :start, :stop, :restart)
    end

    # @see Resource
    class Provider < Chef::Provider
      include Poise
      provides(:haproxy_service)

      def load_current_resource
      end
    end
  end
end
