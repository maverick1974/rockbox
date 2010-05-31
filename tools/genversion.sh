#!/bin/sh
#             __________               __   ___.
#   Open      \______   \ ____   ____ |  | _\_ |__   _______  ___
#   Source     |       _//  _ \_/ ___\|  |/ /| __ \ /  _ \  \/  /
#   Jukebox    |    |   (  <_> )  \___|    < | \_\ (  <_> > <  <
#   Firmware   |____|_  /\____/ \___  >__|_ \|___  /\____/__/\_ \
#                     \/            \/     \/    \/            \/

# Usage: genversion.sh c/h destination-dir path-to-version.sh [source-root]

# Generate version.[ch] files (if first argument is c or h)

# XXX DO NOT TWEAK VERSION HERE, EDIT version.sh INSTEAD

VERSION=`$3 $4`

if [ "$1" = "h" ]; then
    cat > "$2/_version.h" << EOF
/* Generated by genversion.sh */
extern const char rbversion[];
#define RBVERSION "$VERSION"
EOF

    if [ -f "$2/version.h" ]
        then if diff "$2/_version.h" "$2/version.h" > /dev/null
            then mv "$2/_version.h" "$2/version.h"
            else rm -f "$2/_version.h"
        fi
        else mv "$2/_version.h" "$2/version.h"
    fi
elif [ "$1" = "c" ]; then
    cat > "$2/_version.c" << EOF
/* Generated by genversion.sh */
#include "version.h"
const char rbversion[] = RBVERSION;
EOF

    if [ -f "$2/version.c" ]
        then if diff "$2/_version.c" "$2/version.c" > /dev/null
            then mv "$2/_version.c" "$2/version.c"
            else rm -f "$2/_version.c"
        fi
        else mv "$2/_version.c" "$2/version.c"
    fi
fi
