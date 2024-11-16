#!/system/bin/sh

# Change ownership to make sure settings can be applied
chown -R root:root /sys/devices/system/cpu
chown -R root:root /sys/class/devfreq

# Function to apply settings
apply_settings() {
  # Apply schedtune boost settings
  echo 5 > /dev/stune/schedtune.boost

  echo 20 > /dev/stune/top-app/schedtune.boost
  echo 1 > /dev/stune/top-app/schedtune.sched_boost_no_override

  echo 10 > /dev/stune/foreground/schedtune.boost
  echo 1 > /dev/stune/foreground/schedtune.sched_boost_no_override

  echo 5 > /dev/stune/audio-app/schedtune.boost
  echo 1 > /dev/stune/audio-app/schedtune.sched_boost_no_override

  echo 0 > /dev/stune/background/schedtune.boost
  echo 1 > /dev/stune/background/schedtune.sched_boost_no_override

  # Set CPU min frequency to 600MHz and max frequency to 1804800 for little cores (CPU0-CPU3)
  for cpu in 0 1 2 3; do
    echo 614400 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_min_freq
    echo 1804800 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_max_freq
  done

  # Set CPU min frequency to 902400 and max frequency to 2016000 for big cores (CPU4-CPU7)
  for cpu in 4 5 6 7; do
    echo 902400 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_min_freq
    echo 2016000 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_max_freq
  done

  # Set GPU min frequency to 745MHz
  echo 600000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
}

# Apply initial settings
apply_settings

# Reapply only Freq settings for 5 times only
for i in $(seq 1 5); do
  sleep 5
  apply_settings
done
