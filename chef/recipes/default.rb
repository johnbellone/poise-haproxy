#
# Cookbook: poise-haproxy
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

haproxy 'default' do
  node['poise-haproxy']['recipe'].each do |key, value|
    send(key, value) unless value.nil?
  end
end
