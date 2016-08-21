#
# Cookbook: poise-haproxy
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

module PoiseHaproxy
  module Resources
    autoload :Haproxy, 'poise_haproxy/resources/haproxy'
    autoload :HaproxyService, 'poise_haproxy/resources/haproxy_service'
  end
end
