#!/system/bin/sh

# Initial wait for 3 seconds after boot
sleep 3

# Change ownership to make sure settings can be applied
chown -R root:root /sys/devices/system/cpu
chown -R root:root /sys/class/devfreq

# Function to apply settings
apply_settings() {
  # Apply schedtune boost settings
  echo 5 > /dev/stune/schedtune.boost
  echo 1 > /dev/stune/schedtune.sched_boost_no_override

  echo 20 > /dev/stune/top-app/schedtune.boost
  echo 1 > /dev/stune/top-app/schedtune.sched_boost_no_override

  echo 10 > /dev/stune/foreground/schedtune.boost
  echo 1 > /dev/stune/foreground/schedtune.sched_boost_no_override

  echo 5 > /dev/stune/audio-app/schedtune.boost
  echo 1 > /dev/stune/audio-app/schedtune.sched_boost_no_override

  echo 0 > /dev/stune/background/schedtune.boost
  echo 1 > /dev/stune/background/schedtune.sched_boost_no_override

  # Set CPU min frequency to 300MHz and max frequency to 1804800 for little cores (CPU0-CPU3)
  for cpu in 0 1 2 3; do
    echo 300000 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_min_freq
    echo 1804800 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_max_freq
  done

  # Set CPU min frequency to 300MHz and max frequency to 2016000 for big cores (CPU4-CPU7)
  for cpu in 4 5 6 7; do
    echo 300000 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_min_freq
    echo 2016000 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_max_freq
  done

  # Set GPU governor to simple_ondemand for all available paths
  for path in /sys/class/devfreq/*/governor; do
    if [ "$(cat $path)" != "simple_ondemand" ]; then
      echo "simple_ondemand" > $path
    fi
  done
}

# Apply initial settings
apply_settings

# Reapply settings every 5 seconds for 1 minute to ensure they are not overwritten
for i in $(seq 1 12); do
  sleep 5
  apply_settings
done
