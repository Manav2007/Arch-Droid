#!/system/bin/sh
#PROJECT DARK BOOSTER - ABS Tweaks
#Version - 5.0
#Devoloped by dark_optimistic @XDA
#Copyright (C)2015 dark_optimistic
#Thanks To Paget96 @XDA
#==============================================================#
#========================= Licenses ===========================#
#==============================================================#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#  You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
#==============================================================#
#======================= Important Note =======================#
#==============================================================#
#If you want to use my mod in your ROM than you don't need to take permission from me. All you need to is just give ME ( dark_optimistic @XDA) proper CREDITS.
#
#If you want to share my mod on your blog/website/Fb page or any other place than please do not reupload it. Simply give original Android File Host Download link provided on my XDA Thread. 
#
#Do not try to Rename or Modify ABS Tweaks. If I found you doing this than ready to face consequences. I will report you wherever you are.
#
#For more info check out my website - <http://www.techflue.com/>  & also see Licenses given below.
#==============================================================#



mount -o remount,rw /system 2>/dev/null
/tmp/busybox mount -o remount,rw /system 2>/dev/null


for f in $(busybox find /system/xbin -type l); do
  rsl=$(busybox readlink $f)
  if echo "$rsl" | busybox grep -q busybox; then
    busybox rm $f
  fi
done

/tmp/busybox rm -f /system/xbin/busybox
