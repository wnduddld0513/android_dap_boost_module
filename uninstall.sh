#!/system/bin/sh

# Module removal script
print "Removing dx180_performance module..."

# Restore settings
echo 0 > /dev/stune/schedtune.sched_boost_no_override
