#!/system/bin/sh

# Utility script
print() {
  echo "$1"
}

error() {
  print "Error: $1" >&2
}
