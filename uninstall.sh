#!/system/bin/sh

# Module removal script
print "Removing android_dap_boost_module..."

# Restore settings
  echo 0 > /dev/stune/foreground/schedtune.boost
  echo 0 > /dev/stune/foreground/schedtune.sched_boost_no_override
