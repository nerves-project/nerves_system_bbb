#!/bin/sh

set -e

# Run this script to update the BBB kernel patches. See the bottom
# of the script for setting the versions.

update_kernel_patch() {
  local PATCH_VERSION=$1
  local KERNEL_VERSION=$2
  local OUTPUT_PATCH=$3

  local KERNEL_PATCH=$PATCH_VERSION.tar.gz
  local KERNEL_TARBALL=linux-$KERNEL_VERSION.tar.xz

  # Work in a temporary directory
  rm -fr work
  mkdir -p work
  cd work

  echo "Downloading files..."

  local PATCH_URL
  local KERNEL_URL

  case $KERNEL_VERSION in
      4*)
          PATCH_URL=https://github.com/beagleboard/linux/archive/$KERNEL_PATCH
          KERNEL_URL=https://www.kernel.org/pub/linux/kernel/v4.x/$KERNEL_TARBALL
          ;;
      *)
          echo "Unexpected kernel version: $KERNEL_VERSION"
          exit 1
  esac

  # Download the master patch file for the RCN kernel
  wget $PATCH_URL

  # Download the kernel that it will patch
  wget $KERNEL_URL

  # Extract the kernel twice so that the patch can be compared
  echo "Extracting..."
  tar -x -f $KERNEL_TARBALL && mv linux-$KERNEL_VERSION a
  tar -x -f $KERNEL_PATCH && mv linux-$PATCH_VERSION b
 
  rm b/.github

  # Now create a regular "diff" patch
  echo "Creating patch..."
  diff -Naur --no-dereference a b > ../$OUTPUT_PATCH || :

  # Clean up
  echo "Cleaning up..."
  cd ..
  rm -fr work

  return 0
}

#update_kernel_patch 4.19.120-bone50 4.19.120 0001-rcn-linux-4.19.120-bone50.patch
update_kernel_patch 4.19.94-ti-r59 4.19.94 0001-rcn-linux-4.19.94-ti-r59.patch

echo "Updated patches. Now rebuild the linux kernel."
