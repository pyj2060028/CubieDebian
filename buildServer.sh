#!/bin/bash
PWD="`pwd`"
CWD=$(cd "$(dirname "$0")"; pwd)

source ${CWD}/fns.sh

usage(){
cat <<EOF
`basename $0`
-h    : This help message
-t    : Set target to build, available targets are ${TARGETS[@]}
-d    : Destination directory
-i    : The name of the image file ( `basename ${IMGFILE}` )
-v    : Turn on verbose output
EOF
}

while getopts “hi:t:d:v” OPTION
do
     case $OPTION in
         h)
	     HELP_OPT=1
             ;;
         i)
             IMAGEFILE_OPT=$OPTARG
             ;;
         t)
	     TARGET=$OPTARG
             ;;
	 d)
	     DESTDIR_OPT=$OPTARG
	     ;;
         v)
             VERBOSE=1
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

IMGFILE=${IMAGEFILE_OPT:-./Cubian-server-r1-arm.img}
DESTDIR=${DESTDIR_OPT:-./mnt}
TARGETS=("prepare" "apache2" "php5" "mysql" "redis" "nginx" "lighthttpd" "varnish" "haproxy" "memcached" "mongodb" "jre" "node" "racket")

if [ ! -z "${HELP_OPT:-}" ];then
    usage
    exit
fi

if ! isRoot2;then
    echo "`basename $0` must be run as root"
    exit -1
fi

if [ -z "${TARGET}" ];then
    echo "TARGET not found"
    usage
    exit 2
fi

if [ $(contains "${TARGETS[@]}" "${TARGET}") == "n" ];then
    echo "${TARGET} is not supported"
    exit 3
fi

if [ ! -f ${IMGFILE} ];then
    echo "${IMGFILE} does not exists"
    exit 4
fi

BYTES_PER_SECTOR=`fdisk -lu ${IMGFILE} | grep ^Units | awk '{print $9}'`
LINUX_START_SECTOR=`fdisk -lu ${IMGFILE} | grep ^${IMGFILE}1 | awk '{print $2}'`
LINUX_OFFSET=`expr ${LINUX_START_SECTOR} \* ${BYTES_PER_SECTOR}`

if [ ! -z "${DESTDIR}" ];then
    if [ ! -d ${DESTDIR} ];then
        mkdir -p ${DESTDIR}
    else
        umount ${DESTDIR}>/dev/null 2>&1
    fi
    mount -o loop,rw,offset=${LINUX_OFFSET} ${IMGFILE} ${DESTDIR}
fi

case "$TARGET" in
    "prepare")
    export QEMU=`which qemu-arm-static`
    sudo cp -p ${QEMU} ${DESTDIR}${QEMU}
    cat >> ${DESTDIR}/etc/apt/sources.list <<END
#deb http://mirrors.sohu.com/debian/ wheezy main contrib non-free
deb-src http://http.debian.net/debian/ wheezy main contrib non-free
deb-src http://security.debian.org/ wheezy/updates main contrib non-free
END
LC_ALL=C LANGUAGE=C LANG=C chroot ${DESTDIR} apt-get update
LC_ALL=C LANGUAGE=C LANG=C chroot ${DESTDIR} apt-get -y install build-essential
    ;;
    "apache2")
    echo "building apache2"
    if promptyn "copying files?";then
        #tar --exclude=".git" -czf - ./lib | ( cd ../${DESTDIR}/home/cubie; tar -xzvf -)
        BUILD_HOME="/home/cubie/apache2"
        rsync -avc --exclude '.git' ${CWD}/lib/APR* \
${CWD}/lib/PCRE \
${CWD}/lib/httpd \
${CWD}/fns.sh \
${CWD}/buildApache.sh \
${DESTDIR}${BUILD_HOME}
        chroot ${DESTDIR} /bin/bash -c "su - -c ${BUILD_HOME}/buildApache.sh"
    fi
    ;;
    "php5")
    echo "building php"
    if promptyn "copying files?";then
        BUILD_HOME="/home/cubie/php5"
        rsync -avc --exclude '.git' ${CWD}/lib/php5* \
${CWD}/fns.sh \
${CWD}/buildPHP.sh \
${DESTDIR}${BUILD_HOME}
        chroot ${DESTDIR} /bin/bash -c "su - -c ${BUILD_HOME}/buildPHP.sh"
    fi
    ;;
    *)
    echo "sry, ${TARGET} not implemented yet"
    ;;
esac
#echo $TARGET
#chroot ${DESTDIR} /bin/bash -x <<'EOF'
#EOF
