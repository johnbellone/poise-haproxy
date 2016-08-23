#
# Cookbook: poise-haproxy
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

module PoiseHaproxy::HaproxyProviders
  # The dummy provider for `haproxy` for testing.
  # @since 1.0
  class Dummy < Base
    provides(:dummy)

    # Manual overrides for dummy data.
    # @api private
    # @return [Hash]
    def self.default_inversion_options(_node, _resource)
      super.merge(haproxy_binary: '/usr/sbin/haproxy')
    end

    # Enable by default for ChefSpec.
    # @api private
    # @return [true, false]
    def self.provides_auto?(node, _resource)
      node.platform?('chefspec')
    end

    # Output the value for the HAProxy binary.
    # @return [String]
    def haproxy_binary
      options[:haproxy_binary]
    end

    private

    # @api private
    def install_haproxy
    end

    # @api private
    def uninstall_haproxy
    end

    # @api private
    def service_options(r)
      super
      r.provider(:dummy)
    end
  end
end
