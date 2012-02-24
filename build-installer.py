import os.path
import os

VERSION='23.4'

EMACS_FOLDER='emacs-%s' % (VERSION)
GNU_ZIP='emacs-%s-bin-i386.zip' % (VERSION)
GNU_URL='http://ftp.gnu.org/pub/gnu/emacs/windows/%s' % (GNU_ZIP)
INNO_SETUP_REG_KEY="InnoSetupScriptFile\\shell\\Compile\\command"

def download(force=False):
    if os.path.isfile(GNU_ZIP):
        if force:
            os.unlink(GNU_ZIP)
        else:
            return
    print('Downloading %s from gnu.org' % (GNU_ZIP))
    try:
        from urllib.request import urlretrieve
    except ImportError:
        from urllib import urlretrieve
    urlretrieve(GNU_URL, GNU_ZIP)

def unpack(force=False):
    if os.path.isdir(EMACS_FOLDER):
        if force:
            import shutil
            print('Cleaning up folder %s' % (EMACS_FOLDER))
            shutil.rmtree(EMACS_FOLDER)
        else:
            return
    print('Unpacking archive to %s' %(EMACS_FOLDER))
    import zipfile
    zipf = zipfile.ZipFile(GNU_ZIP)
    zipf.extractall()

def build():
    import subprocess
    import shlex
    try:
        import winreg
    except:
        import _winreg as winreg
    
    try:
        with winreg.OpenKey(winreg.HKEY_CLASSES_ROOT,
                            INNO_SETUP_REG_KEY) as key:
            compil32 = shlex.split(winreg.QueryValue(key, None))[0]
            inno_compiler = compil32.replace("Compil32.exe", "ISCC.exe")
        return subprocess.call([inno_compiler, "emacs.iss"])
    except:
        print("Cannot find Inno Setup's ISCC.exe")
        print("You can find it at http://www.jrsoftware.org/")
        return 1

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description="Build installer for emacs")
    parser.add_argument('-f', action='store_const', const=True, default=False,
                        help='Force download and unpack')
    args = parser.parse_args()
    download(args.f)
    unpack(args.f)
    exit(build())
