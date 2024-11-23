#!/system/bin/sh

chown -R root:root /sys/class/devfreq

apply_settings() {
  # Apply schedtune boost settings
  echo 30 > /dev/stune/foreground/schedtune.boost
  echo 1 > /dev/stune/foreground/schedtune.sched_boost_no_override

  # Set GPU minFreq
  echo 465000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
}

# Apply settings
apply_settings

# Reapply settings for 10 times
for i in $(seq 1 10); do
  sleep 2
  apply_settings
done
