#!/usr/bin/env ruby
require 'benchmark'
require 'redis'
require 'redis-bloomfilter'
require 'trollop'
require "hiredis"
require "em-synchrony"

opts = Trollop::options do
  opt :num, "num tests total", :default => 1_000_000
  opt :repeats, "num repeats", :default => 100
  opt :host, "host for bloomfilter", :default => 'localhost'
  opt :driver, "driver for test", :default => ""
end


redis_opts = { :host => opts[:host] } 
redis_opts[:driver] = opts[:driver].to_sym unless opts[:driver]==""

redis = Redis.new(:server => redis_opts)
redis.flushdb

num = opts[:num]
num_included = num / opts[:repeats]
keys = []

puts "driver = #{opts[:driver]}"

Benchmark.bm do |x|
  r = RedisBloomFilter::Redis.new(:db => redis)

  x.report("insert") do
    num.times do
      k = "key:#{rand(num_included)}"
      keys << k
      r.insert(k)
    end
  end
  
  keys.uniq!

  x.report("lookup present") do
    keys.each do |k|
      r.include?(k)
    end
  end

  x.report("lookup missing") do
    num.times do
      r.include?("not_a_key")
    end
  end

end

