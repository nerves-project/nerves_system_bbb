#!/bin/sh

set -e

# Run this script to update the BBB kernel patches. See the bottom
# of the script for setting the versions.

update_kernel_patch() {
  local PATCH_VERSION=$1
  local KERNEL_VERSION=$2
  local OUTPUT_PATCH=$3

  local ORIGINAL_DIFF=patch-$PATCH_VERSION.diff
  local ORIGINAL_DIFF_XZ=$ORIGINAL_DIFF.xz
  local KERNEL_TARBALL=linux-$KERNEL_VERSION.tar.xz

  # Work in a temporary directory
  rm -fr work
  mkdir -p work
  cd work

  echo "Downloading files..."

  local RCN_PATCH_URL
  local KERNEL_URL

  case $KERNEL_VERSION in
      3*)
          RCN_PATCH_URL=http://rcn-ee.net/deb/sid-armhf/v$PATCH_VERSION/$ORIGINAL_DIFF_XZ
          KERNEL_URL=https://www.kernel.org/pub/linux/kernel/v3.x/$KERNEL_TARBALL
          ;;
      4*)
          RCN_PATCH_URL=http://rcn-ee.net/deb/stretch-armhf/v$PATCH_VERSION/$ORIGINAL_DIFF_XZ
          KERNEL_URL=https://www.kernel.org/pub/linux/kernel/v4.x/$KERNEL_TARBALL
          ;;
      *)
          echo "Unexpected kernel version: $KERNEL_VERSION"
          exit 1
  esac

  # Download the master patch file for the RCN kernel
  wget $RCN_PATCH_URL

  # Download the kernel that it will patch
  wget $KERNEL_URL

  # Extract the kernel twice so that the patch can be compared
  echo "Extracting..."
  tar -x -f $KERNEL_TARBALL && mv linux-$KERNEL_VERSION a
  tar -x -f $KERNEL_TARBALL && mv linux-$KERNEL_VERSION b

  # Expand the "git" style patch
  unxz $ORIGINAL_DIFF_XZ

  # Make a git repo and apply the "git" style patch
  echo "Creating temporary git repo to extract RCN patch..."
  cd b
  git init
  git add .
  git commit -q -m "Initial commit"
  git apply ../$ORIGINAL_DIFF
  rm -fr .git

  # Now create a regular "diff" patch
  echo "Creating patch..."
  cd ..
  diff -Naur --no-dereference a b > ../$OUTPUT_PATCH || :

  # Clean up
  echo "Cleaning up..."
  cd ..
  rm -fr work

  return 0
}

# NOTE: The -rt vs. no -rt on RCN's site indicates a difference in
#       the defconfigs. The patches are the same.

#update_kernel_patch 3.8.13-bone79 3.8.13 0001-rcn-linux-kernel-3.8.patch
#update_kernel_patch 4.1.23-ti-r60 4.1.23 0001-rcn-linux-4.1.23-ti.patch
#update_kernel_patch 4.4.9-bone10 4.4.9 0001-rcn-linux-4.4.9-bone.patch
#update_kernel_patch 4.4.9-ti-r25 4.4.9 0001-rcn-linux-4.4.9-ti.patch
update_kernel_patch 4.4.113-ti-r147 4.4.113 0001-rcn-linux-4.4.113-ti.patch
#update_kernel_patch 4.9.58-ti-r72 4.9.58 0001-rcn-linux-4.9.58-ti.patch

echo "Updated patches. Now rebuild the linux kernel."
