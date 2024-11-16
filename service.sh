#!/system/bin/sh

chown -R root:root /sys/devices/system/cpu
chown -R root:root /sys/class/devfreq

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

  # Set CPU Freq(CPU0~CPU3)
  for cpu in 0 1 2 3; do
    echo 614400 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_min_freq
    echo 1804800 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_max_freq
  done

  # Set CPU Freq(CPU4~CPU7)
  for cpu in 4 5 6 7; do
    echo 902400 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_min_freq
    echo 2016000 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_max_freq
  done

  # Set GPU minFreq 600mhz
  echo 600000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
}

# Apply settings
apply_settings

# Reapply settings for 5 times
for i in $(seq 1 5); do
  sleep 5
  apply_settings
done
