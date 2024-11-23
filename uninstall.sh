#!/system/bin/sh

# Module removal script
print "Removing dx180_performance module..."

# Restore settings
  echo 0 > /dev/stune/foreground/schedtune.boost
  echo 0 > /dev/stune/foreground/schedtune.sched_boost_no_override
