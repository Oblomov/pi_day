#!/usr/bin/ruby

# This script finds the best rational approximation to a given number
# (pi by default) that can be also read as a date in day/month format
#
# License: GPLv2

target = Math::PI
string = "pi"

if ARGV.length > 0
	string = ARGV[0]

	case ARGV[0]
	when /^pi$/i
		# we're good
	when /^e$/i
		target = Math::E
	when /^tau$/i
		target = 2*Math::PI
	when /^phi$/
		target = (Math::sqrt 5 + 1)/2
	when /^(\d+|\d*\.\d+)$/
		target = ARGV[0].to_f
	else
		raise ArgumentError, "can't handle value #{ARGV[0]}"
	end
end

best = [0, 0, 1]

12.times do |i|
	month = i+1
	prod = target*month
	day = prod.round
	next if day > 31 # TODO skip per month
	e = (day.to_f/month - target).abs/target
	puts "%i/%i (e = %g = %.2g%%)" % [day, month, e, e*100 ]
	if e < best.last
		best[0] = day
		best[1] = month
		best[2] = e
	end
end

puts "Best approximation for %s: %i/%i (e = %g = %.2g%%)" % ([string] + best + [best.last*100])
