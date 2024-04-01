#!/bin/sh

set -e

# Run this script to update the BBB kernel patches. See the bottom
# of the script for setting the versions.

update_kernel_patch() {
  local PATCH_VERSION=$1
  local KERNEL_VERSION=$2
  local OUTPUT_PATCH=$3

  local ORIGINAL_DIFF=patch-$PATCH_VERSION.diff
  local ORIGINAL_DIFF_XZ=$ORIGINAL_DIFF.gz
  local KERNEL_TARBALL=linux-$KERNEL_VERSION.tar.xz

  # Work in a temporary directory
  rm -fr work
  mkdir -p work
  cd work

  echo "Downloading files..."

  RCN_PATCH_URL=http://rcn-ee.net/deb/sid-armhf/v$PATCH_VERSION/$ORIGINAL_DIFF_XZ
  KERNEL_URL=https://www.kernel.org/pub/linux/kernel/v6.x/$KERNEL_TARBALL

  # Download the master patch file for the RCN kernel
  wget $RCN_PATCH_URL

  # Download the kernel that it will patch
  wget $KERNEL_URL

  # Extract the kernel twice so that the patch can be compared
  echo "Extracting..."
  tar -x -f $KERNEL_TARBALL && mv linux-$KERNEL_VERSION a
  tar -x -f $KERNEL_TARBALL && mv linux-$KERNEL_VERSION b

  # Expand the "git" style patch
  gunzip $ORIGINAL_DIFF_XZ

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

update_kernel_patch 6.6.15-ti-arm32-r1 6.6.15 0001-rcn-linux-6.6.15-ti-arm32-r1.patch

echo "Updated patches. Now rebuild the linux kernel."
