# jetbrains LinuxGlobalMenu for FreeBSD with native openjdk17 (without linux compat)
fast way to create a freebsd libdbm.so for jetbrains simply execute 
```
./build.sh
```
the other needed libs are in packages named ```jna``` and ```jetbrains-sqlite```.
extract with 

```
jar -xvf /usr/local/share/java/classes/jna.jar com/sun/jna/freebsd-x86-64/libjnidispatch.so
```
 ```jetbrains-sqlite``` contains
```
/usr/local/share/jetbrains/sqlite/amd64/libsqliteij.so
```
```
cp /usr/local/share/jetbrains/sqlite/amd64/libsqliteij.so  ~/idea-IC-233.SNAPSHOT/lib/native/linux-x86_64/libsqliteij.so
```

and

```
cp com/sun/jna/freebsd-x86-64/libjnidispatch.so ~/idea-IC-233.SNAPSHOT/lib/jna/amd64/libjnidispatch.so
```
copy libdbm.so to idea-IC-233.SNAPSHOT/bin/
You will find libdbm.so in build dir of this repo after exection of build.sh if build dependencies are installed, you can test your dbus global menu with ./dbmexec in same directory

