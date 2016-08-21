#
# Cookbook: poise-haproxy
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

module PoiseHaproxy
  module HaproxyProviders
    autoload :Dummy, 'poise_haproxy/haproxy_providers/dummy'
    autoload :System, 'poise_haproxy/haproxy_providers/system'
  end
end
